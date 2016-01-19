#!/usr/bin/python
# decomment50
#
# Annaleah Ernst & Kareem Omar, CS50 jterm 2015
# annaleahernst@college.harvard.edu
#
# intelligently strips a C or php file of comments
# outputs a newly stripped file with the tag _decommented at the end
#
# https://xkcd.com/208/

import re
from sys import argv

def decomment50(in_fname, out_fname):
    # deals with strings vs comments
    def replacer(match):
        match_string = match.group(0)

        # ignore comment characters inside of string and char literals
        return match_string if match_string[0] == '"' or match_string[0] == '\'' else ''
    
    # handles stand alone // comment, inline comment, stand alone /**/ comments, inline block comments, and strings
    regex_c_php = r'^[ \t\f\v]*//.*?(\n|$)|//.*?$|^[ \t\f\v]*/\*.*?\*/(\n|$)|/\*.*?\*/|\'(?:\\.|[^\\\'])*\'|"(?:\\.|[^\\"])*"'

    # handles php specific comment symbol #
    regex_php = r'|^[ \t\f\v]*#.*?(\n|$)|#.*?$'    

    try:
        with open(in_fname,'r') as in_file, open(out_fname,'w') as out_file:
            
                # regex pattern based on what sort of file we're reading
                regex_pattern = re.compile(regex_c_php + (regex_php if in_fname[-4:] == '.php' else ''), re.DOTALL | re.MULTILINE)
                out_file.write(re.sub(regex_pattern, replacer, in_file.read()))

                # strip out shorthand file name
                file_name = lambda fname: fname[max(fname.rfind('/'), fname.rfind('\\'))+1:]
                return 'Successfully decommented ' + file_name(in_fname) + ' and saved in ' + file_name(out_fname)

    except:
        return 'Failed to open file.'

# check user input
if len(argv) != 2 : 
    print("Usage: decomment50.py <filename>")
else :
    # get output file name
    dot = argv[1].rfind('.')
    print(decomment50(argv[1],argv[1][:dot] + "_decommented" + argv[1][dot:]))
