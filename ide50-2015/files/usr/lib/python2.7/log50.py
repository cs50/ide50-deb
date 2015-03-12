#!/usr/bin/env python
import datetime
import fcntl
import glob
import json
import os
import pexpect
import requests
import re
import shutil
import subprocess
import sys
import tempfile
import time

LOGFILE = 'log50.log'
LOGDIR = '/var/log/log50/'
UPLOADDIR = '/var/log/log50/'
NO50_PATH = '/etc/no50'
APPLIANCE_ID_FILE = '/etc/appliance50.id'
LOCKFILE = '/var/lock/log50'
METADATAFILE = '.uploaded'
DEBUG = False
LOGURL = 'https://log2014.cs50.net'
UPLOADHOURS = 24 # number of hours after which to reupload

class ScriptWrapper:
    def __init__(self, progName, realProgPath = None):
        # if no real path is found, find it with which
        if realProgPath is None:
            realProgPath = self.findRealProgPath(progName)
            if realProgPath is None:
                if DEBUG:
                    print "failed to find program"
                exit()

        # set instance variables
        self.progName = progName
        self.realProgPath = realProgPath

    def run(self):
        # gen rand file name for pexpect logfile
        temp = tempfile.NamedTemporaryFile(delete=False)
        os.chown(temp.name, os.geteuid(), os.getegid())

        # run program, modifying argv to go to real program
        sys.argv[0] = self.realProgPath

        # build command
        command = ' '.join(sys.argv)

        start_time = time.time()
        p = pexpect.spawn(command)
        p.logfile = temp

        # removed because unnecessary
        #global global_pexpect_instance
        #global_pexpect_instance = p
        #signal.signal(signal.SIGWINCH, sigwinch_passthrough)

        try:
            p.interact()

        # for I/O problems on quit
        except OSError:
            pass

        end_time = time.time()

        # read in logfile
        f = open(temp.name)
        content = f.read()
        temp.close()

        p.close()

        # create object to be logged
        obj = {'_type':'wrapper', 'prog': self.progName, 'cmd': command, 'exit_code': p.exitstatus, 'start_time':start_time, 'end_time':end_time, 'content':content}

        # write log
        log_obj(obj)


    def findRealProgPath(self, progName):
        try:
            # call which on program name
            output = subprocess.check_output(['which', '-a', progName])
            lines = output.split('\n')

            # if only one result, fail
            if len(lines) < 2:
                return None
            else:
                # if log50.d is in path multiple times, we might need to index for a bit
                index = 1
                # increase until new path found (if we run out, return None)
                while lines[index-1] == lines[index]:
                    index = index + 1
                    if index > len(lines):
                        return None

                # if new path found, return it
                return lines[index]

        # if call failed, fail
        except:
            return None

def can_log():
    # if no50 exists, pass
    return not os.path.exists(NO50_PATH)

def log_obj(obj):
    if not can_log():
        return

    # add timestamp and turn to string
    obj['_timestamp'] = time.time()
    string = json.dumps(obj)

    with open(LOGDIR + LOGFILE, "a+") as logfile:
        # lock file. lock should be released when file is closed
        # XXX: should this be nonblocking?
        fcntl.flock(logfile, fcntl.LOCK_EX)

        try:
            logfile.write("%s\n" % string)
        except:
            pass

# convenience method for logging strings
def log_str(string):
    obj = {"message": string}
    log_obj(obg)

"""
Copies log into log directory, with timestamp in filename.
If sucessful, wipes log file.
"""
def copy_log(log_file=LOGFILE, log_dir=LOGDIR, dest_dir=UPLOADDIR):
    # open and lock logfile
    log_file_path = log_dir + log_file
    fd = open(log_file_path,"r")

    # try to lock file
    try:
        fcntl.flock(fd, fcntl.LOCK_EX | fcntl.LOCK_NB)
    except Exception, e:
        if DEBUG:
            print "Failed to lock log file"
            print e
        fd.close()
        return False

    # initialize success
    success = None

    try:
        # create upload dir if necessary
        if not os.path.exists(dest_dir):
            os.makedirs(dest_dir, 0755)

        # copy logfile with time suffix
        copy_time = time.time()

        # copy in with new name (TODO: error check on name)
        shutil.copy(log_dir+log_file, dest_dir + log_file + '.' + str(copy_time))

        # zeroes out the log. TODO necessary to lock first?
        open(log_file_path,"w").close()

        success = True
    except Exception, e:
        if DEBUG:
            print "Failed to copy log"
            print e
        success = False

    # unlock file and return
    fd.close()
    return success


def send_log(appliance_id, log_dir=UPLOADDIR, log_url = LOGURL):
    if not can_log():
        return
    files = {}

    # find all files in log directory that end in one or more digits
    log_files = glob.glob(log_dir + "*.log.[0-9][0-9]*")
    if len(log_files) > 0:

        # upload one file at a time
        for file_name in log_files:
            file = open(file_name, 'rb')

            # make POST request once per file, continuing on error
            try:
                r = requests.post(log_url, data={'appliance_id':appliance_id}, files={file_name:file})
            except:
                if DEBUG:
                    print "Request failed for %s." % file_name
                continue

            # validate response
            if r is not None and r.status_code == 200:
                try:
                    response = json.loads(r.text)
                except ValueError:
                    if DEBUG:
                        print "could not parse ", r.text
                    continue

                # see if response succeded
                if "success" in response and response["success"]:
                    # unlink file and continue
                    os.unlink(file_name)
                else:
                    if DEBUG:
                        print "Request failed for %s.\nError:%s" % (file_name, r.text)


"""
Tries to acquire the upload lock. Will succeed if there is no lockfile, or if lockfile is > 24 hours old.
Returns True is lock acquired, otherwise False.
"""
def lock_upload():
    try:
        # open lock file for editing
        # NOTE: if lockfile does not exist, this will create it and return false, due to need to loc
        with open(LOCKFILE, "a+") as lockfile:
            # lock file. lock should be released when file is closed
            # if lock file is currently locked, return false
            try:
                fcntl.flock(lockfile, fcntl.LOCK_EX | fcntl.LOCK_NB)
            except Exception, e:
                if DEBUG:
                    print "Failed to acquire upload lock"
                    print e
                return False

            # if succeeded in acquiring lock, return true
            return True

    # if error occurs, return false
    except Exception, e:
        return False

def should_upload():
    md_file_path = LOGDIR+METADATAFILE

    # if file doesn't exist, return true
    if not os.path.exists(md_file_path):
        return True

    # else check if file is new enough
    else:
        modified_time = os.path.getmtime(md_file_path)
        now = time.time()

        # get difference in hours
        hours_since = (now - modified_time) / 3600

        # return true if its been over 24 hours, or if something went wrong and the time is negative
        return hours_since < 0 or hours_since > UPLOADHOURS

def get_appliance_id():
    try:
        output = subprocess.check_output(['id50'])
        return output.rstrip()
    except:
        if DEBUG:
            print "no appliance id found"
        return None
