---
title: "Introduction to Linux and the Command Line"
author: Mark Juers
date: 2021-01-13
---

# Getting Files

This tutorial will teach the basics of logging in and getting your files.
Most of the tools we will be using were built with a Linux operating system in mind.
We're going to connect to our remote virtual machines, the ones we did our Rstudio work on, and download our work using a text-based interface, which has a bit of a learning curve.
Generally, the commands we'll be using for getting our files will be in the form `command [options] [source] [destination]`, with some exceptions.
While this technique might seem antiquated if you are used to a modern desktop, it actually holds a number of advantages for certain tasks.

- Requires very little bandwidth.
You can do pretty much anything you need to with dial-up if need be.
- It's very powerful.
It is much easier to automate repetitive tasks than most graphical tools.
- There are more, but most importantly, it's reproducible.
We can run the same analysis multiple times by saving the instructions in a *script* and running it anywhere.

Because of the way our course is set up, you'll have to connect to a remote server to download your project files when you want them.
This guide will help you set it up.

If you're on a Mac/Linux, you can fire up your Terminal app; use Spotlight (cmd+space) to find it.
On Windows, we're going to use an app called Cygwin ([https://bit.ly/39uK9mJ]. Make sure to install the `openssh` package when you install Cygwin.), which basically allows us to interact with our computer as if we were using Linux.
If you already know how to use WSL, just do that and follow all the Linux instructions instead of using Cygwin.
Throughout the tutorial, I'll use the term "terminal", but I'll mean the terminal OR Cygwin, depending on your platform.

First, some notes.
Anytime you copy and paste something from here, *make sure you don't paste it into Word*.
Word will introduce formatting we don't want.
So only paste into a console or a text editor, like the ones in Rstudio.

- Fire up your Terminal or Cygwin.
- type `scp -r user_name@ip_address:~/S318/path/to/file ~/path/to/local/destination`.
If the source file is a directory, including a trailing `/` will get just the contents of the directory, while omitting it will get the whole directory.
On windows, remember two things: Backslashes `\` in Windows file paths must be changed to forward slashes `/`, and the `C:` part of a Windows file path is replaced by `/cygdrive/c`.
So your main S318 directory would be `/cygdrive/c/Users/guest_user/S318`.
    - `scp`: This stands for "Secure CoPy".
This command tells your computer to connect to another remote computer and get a file.
And to do it securely.
    - `-r`: The option, `-r` tells the program `scp` to copy the files recursively, that is, if you select a directory, it will copy the whole contents.
    - The next bit `~/user_name@ip_address:S318/path/to/file`, is the address of the source file.
The ip address you were given is what you will use to access the course image.
If you add `:8787` to this ip address and paste it into your browser, it will launch Rstudio.
The part after that is the destination, and because it refers to a place on your own computer, you cqn leave out everything before the `:`.
An analogy is that the part before `:` gives the city (what server you're connecting to) and everything to the right gives the street address (where the file lives).
The `~` is short for your home directory, which is, e.g., `/home/guest_user2`, though this mapping varies by system.
These are *absolute paths*, however there are also *relative paths*, which refer to files based on where they are in relation to the current directory in the filesystem.
- Now you'll have to log in.
I've set up your accounts to use your IU username, with the default password, `learningR`.
- What would happen if you switched the last two arguments `[source]` and `[destination]`? Open up TextEdit/Notepad, create a text file, on your computer, put it on the server, and open it in Rstudio.

This is the method you'll use any time you want to get files from your remote project space to put on your local computer.

## Changing Your Password

If you'd like to change your password, which I recommend, you can do:
```
ssh user_name@ip_address
```
Then enter your password `learningR`.
Some stuff will happen, and then you'll be looking at something that looks like, 
```
Welcome to
    _   _                             _
   / \ | |_ _ __ ___   ___  ___ _ __ | |__   ___ _ __ ___
  / _ \| __| '_ ` _ \ / _ \/ __| '_ \| '_ \ / _ \ '__/ _ \
 / ___ \ |_| | | | | | (_) \__ \ |_) | | | |  __/ | |  __/
/_/   \_\__|_| |_| |_|\___/|___/ .__/|_| |_|\___|_|  \___|
                               |_|
guest_user2@js-17-71:~$
```
You are now logged into the remote virtual machine we created for this class,
and you can do many things you can do on your own machine.
In fact, just about anything that can be done throught the terminal.
Type `passwd` at the prompt (the `$`).
This is the command to create a new password.
It will prompt you for your old password; you won't see anything when you type.
Then type your new password and press enter, and repeat to confirm.
That's it.
Log out by typing `exit` at the prompt.
