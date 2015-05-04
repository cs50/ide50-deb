
     ,-----. ,---.  ,-----. ,--.      ,--.,------.  ,------.
    '  .--./'   .-' |  .--'/    \     |  ||  .-.  \ |  .---'
    |  |    `.  `-. '--. `\  ()  |    |  ||  |  \  :|  `--,
    '  '--'\.-'    |.--'  /\    /     |  ||  '--'  /|  `---.
     `-----'`-----' `----'  `--'      `--'`-------' `------'
    --------------------------------------------------------

                        This is CS50!
                      Powered by Cloud9

Welcome to the CS50 IDE Beta! Below are a list of features and some tips and
tricks for usage and getting started. The end of the document describes how 
to file bug reports if you come across problems.

# Features

* Fully-featured IDE with syntax highlighting and word completion for C and
  other languages.

* An embedded terminal window, below, that provides you with command-line
  access to your very own Ubuntu instance, much like the CS50 Appliance, but
  in the cloud! (try typing `ls`!)

* File browser at left, which lets you navigate the files and folders in
  your workspace (without using `cd` and `ls`).

* A graphical interface to `gdb`! To debug a program you're working on,
  click the `Debug` button up top.

# Getting Started

To be sure you're completely up-to-date with our latest workspace,
be sure to run `update50` in the Console window below!

## Files

* Create a new C file by clicking **File > New File** and then begin coding. 
  Save the file with **File > Save As...** and make sure the file name ends in 
  `.c`.

* Download individual files by right-clicking their name and select 
  **Download**.

* Download all the files in the workspace with **File > Download Project**.

* Upload files by selecting **File > Upload Local Files...**.

## Compiling and Running

To compile and run your C programs you can either use the terminal or
the built-in C debugger.

### Terminal

  * To compile, `cd` to the directory with the C file, and type 
    `make <filename>` into the terminal, where `<filename>` 
    is the name of your C file without the extension.

  * Run the compiled executable with `./<filename>`.

### Debugger

  * Click on the `Debug` button above. Your source code will automatically 
    be compiled and run.

    * Your program's input and output (including any errors during 
      compilation) occur in a new tab in the Console panel, below.

    * You can only `Debug` one program at a time, so please quit a running
      program before trying to run `Debug` on another!

  * The `Debug` option will open a GUI-based debugger panel on the right 
    side of the workspace. You can view the stack, step through the code,
    and manipulate variables in this interface.

  * Add breakpoints by clicking in the space directly to the left of a line
    number. A red dot will appear, which annotates the breakpoint.

## Process Management

Sometimes you need to force a program to quit, like if you accidentally
write a program that has an infinite loop!

  * If you're using the GUI debugger, find the tab in the Console panel,
    below, that corresponds to the program and either hit the `Stop` button
    or type Ctrl-C. Please be patient as the process is shut down.

  * If you're manually running a program in the terminal, you can type 
    Ctrl-C to stop the program. It may take several seconds to respond.

  * As a last resort, you can force kill a process by clicking on the
    workspace stats in the upper-right hand corner (it is a graph of
    `Disk`, `Memory`, and `CPU`), and click `Show Process List`. Find
    your program in the process list, and `Kill` it. If, after a few
    seconds it does not respond, try `Force Kill`.

## Web Server

The instance is configured to use the Apache web server in a manner similar
to, but not exactly the same as, the Appliance.

Start the web server with `apachectl start` in the Console below. 
You can later stop it with `apachectl stop`.

You may find out Apache's status and the domain of your workspace by
clicking the `CS50` button at the top-right of the workspace. Note that
you can also figure out this same information in the Console window
below by typing `service apache2 status` and `hostname50`, respectively.

The `vhosts/example` directory in your workspace contains a sample layout
for how you should structure your own sites. You may want to emulate this
structure for Problem Set 7 and 8 in the `vhosts/pset7` and `vhosts/pset8`
directories, respectively. You can access the contents of a directory in the 
`vhosts` folder by typing the directory name after your instance's domain.

For example, the URL for the `vhosts/example` directory is:
`https://WORKSPACE-USER.c9.io/example` where `WORKSPACE`
is your workspace name and `USER` is your Cloud9 username.

If you're curious, Cloud9's domain acts as a proxy to your workspace. The
Apache webserver runs on port 8080 on your instance, and Cloud9 forwards
requests from *both* `http://WORKSPACE-USER.c9.io:80` and
`https://WORKSPACE-USER.c9.io:443` to port 8080 in the `WORKSPACE` owned
by `USER`. This impacts the directions for Problem Set 6, as we'll discuss
below.

## Problem Sets

To begin work on your Problem Set, simply follow the instructions on the
specification from the beginning.

## More comfortable

If you wish to enable more advanced features of the CS50 IDE, disable the
`Less Comfortable` mode by unchecking that option in the `View` menu.

# Known Issues

## Problem Set 3 (Breakout)

Please use the existing CS50 Appliance for Problem Set 3. Because the
CS50 IDE does not provide access to the underlying Ubuntu instance's
Graphical User Interface, it is not possible to implement Breakout in
IDE50 in a manner that works well. However, you may use IDE50 to
work on `find`, if you wish.

## Problem Set 6 (Web Server)

It is possible to implement Problem Set 6 in the CS50 IDE. In fact, we
developed the first version of it entirely in Cloud9! But it requires some
changes from the spec to work properly:

* ***Be sure Apache is stopped!*** Use `apachectl stop` before working on this
  problem set, or you will get a `Address already in use` error.

* Use port `8080` to access your web server from your own web browser. The
  URL to access it is given by the `hostname50` command or is found in the
  CS50 IDE Stats window by clicking the `CS50` button at the top-right of
  the workspace.

* For testing, it's easiest to use `telnet` on your workspace instance using
  `telnet localhost 8080`.

* It is possible to access it remotely (using `telnet` on your own computer, 
  for instance) if you do the following:

  * First, find your instance's hostname using `hostname50`. We'll refer
    to it as `IDE_HOST` in the steps below.

  * On an external computer, `telnet IDE_HOST 80`. Make sure `IDE_HOST` does
    not include any protocol like `http://` or `https://`.

  * You must add a `Host` header to the HTTP headers so that the Cloud9 proxy
    knows how to properly direct your request. For instance:
    
    ```
    GET /cat.html HTTP/1.1
    Host: IDE_HOST
    ```

## Problem Set 7 (C$50 Finance)

Unlike the URLs provided by the Appliance, the URL for Problem Set 7 will be
`https://HOST/pset7/`. You can find the `HOST` by running `hostname50` in the
Console or clicking the `CS50` button at the top-right of the workspace.

The location of the folder is in the `vhosts` directory in your workspace, so
the directory structure is instead: `~/workspace/vhosts/pset7/`

## Problem Set 8 (Mashup)

Like Problem Set 7, above, the URL and `vhosts` directory are changed to:
`https://HOST/pset8/` and `~/workspace/vhosts/pset8/`, respectively.

# Bug Reports

1. Take a screenshot

2. Find out the version you are running by typing `version50` in the Console
   below or click the `CS50` button in the top-right of the workspace.

3. Upload the screenshot to http://imgur.com

4. File a bug report at the following URL, being as detailed as possible!

*** Bug Report URL: http://bit.ly/cs50-ide-bug-report ***
