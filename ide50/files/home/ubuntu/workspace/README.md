
     ,-----. ,---.  ,-----. ,--.      ,--.,------.  ,------.
    '  .--./'   .-' |  .--'/    \     |  ||  .-.  \ |  .---'
    |  |    `.  `-. '--. `\  ()  |    |  ||  |  \  :|  `--,
    '  '--'\.-'    |.--'  /\    /     |  ||  '--'  /|  `---.
     `-----'`-----' `----'  `--'      `--'`-------' `------'
    --------------------------------------------------------

                        This is CS50!
                      Powered by Cloud9

Welcome to the CS50 IDE! Below are a list of features and some tips and tricks
for usage and getting started.

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

Start the web server with `apache50 start VHOST_DIR` in the Console below, where
`VHOST_DIR` is the directory containing your website. For example, you might
use `apache50 start ~/workspace/pset7/public` to start a web server for Problem Set 7.

You can stop Apache with `apache50 stop`.

The domain of your workspace is shown in the top-right of the workspace.
If the button is enabled, Apache is running and you may click it to open a
new tab that will take you to your site. You may also click the information
button (the `i` with a circle) to see this same information.
You can figure out Apache's status and the hostname of your workspace from
the terminal by typing `apache50 status` and `hostname50`, respectively.

If you're curious, Cloud9's domain acts as a proxy to your workspace. The
Apache webserver runs on port 8080 on your instance, and Cloud9 forwards
requests from *both* `http://WORKSPACE-USER.cs50.io:80` and
`https://WORKSPACE-USER.cs50.io:443` to port 8080 in the `WORKSPACE` owned
by `USER`. This impacts the directions for Problem Set 6, as we'll discuss
below.

## MySQL and phpMyAdmin

Start MySQL with `mysql50 start`, and stop it with `mysql50 stop`. You can
find out the username and password of your MySQL database by using the
`username50` and `password50` commands, respectively. You can also find this
same information in the CS50 IDE Stats Dialog, by clicking the `i` with a
circle button in the top-right of your workspace.

Once Apache and MySQL are both started, you can access phpMyAdmin by going to
`http://HOSTNAME/phpmyadmin`, where HOSTNAME is the domain of your workspace.
The username and password match the MySQL username and password, which you
can find out with `username50` and `password50`.

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

* ***Be sure Apache is stopped!*** Use `apache50 stop` before working on this
  problem set, or you will get a `Address already in use` error.

* Use port `8080` to access your web server from your own web browser. The
  URL to access it is given by the `hostname50` command or is found in the
  top-right of your workspace.

* For testing, it's easiest to use `telnet` on your workspace instance using
  `telnet localhost 8080`.

* It is possible to access it remotely (using `telnet` on your own computer,
  for instance) if you do the following:

  * First, find your instance's hostname using `hostname50`. We'll refer
    to it as `HOSTNAME` in the steps below.

  * On an external computer, `telnet HOSTNAME 80`. Make sure `HOSTNAME` does
    not include any protocol like `http://` or `https://`.

  * You must add a `Host` header to the HTTP headers so that the Cloud9 proxy
    knows how to properly direct your request. For instance:

    ```
    GET /cat.html HTTP/1.1
    Host: HOSTNAME
    ```

## Problem Set 7 (C$50 Finance)

To get started on Problem Set 7, first upload the distribution code into your
workspace. You should then have a `pset7` folder inside of `~/workspace` that
contains the `includes`, `public`, and `templates` folders.

Update `includes/constants.php` to look like the following:

    // your database's name
    define("DATABASE", "pset7");

    // your database's server
    define("SERVER", getenv("IP"));

    // your database's username
    define("USERNAME", `username50 -n`);

    // your database's password
    define("PASSWORD", `password50 -n`);

Finally, you can start Apache with the following command:
`apache50 start ~/workspace/pset7/public`

## Problem Set 8 (Mashup)

The directions for Problem Set 8 match those of Problem Set 7, above, but
just use `pset8` instead of `pset7` everywhere!
