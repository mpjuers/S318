---
title: "Getting to know R and Rstudio"
author: Mark Juers
date: 2021-01-13
---

# Getting to know R and Rstudio

## Accessing our virtual machines

We've set up several *virtual machines* for the purposes of this class.
These allow us to bypass a lot of the difficulty with setting up the sorts of
tools we'll be using.
We will connect to these virtual machines simply using a web browser, as they
are administered elsewhere "in the cloud".

On your handout, you'll see a table that looks like:

| IP address        | server name      | students                             |
|-----------------  |------------------|--------------------------------------|
| `192.168.255.249` | `Rstudio_S318_A` | `molisaperstein cmnjamm lisebastian` |
| `192.168.1.254`   | `Rstudio_S318_B` | `roleswanson bonewport`              |

Your username should be in the right column associated with one of the servers
in the leftmost column.
Your username is unique to your IP address; you won't be able to sign onto
a different server.
To log on to your instance of the virtual machine, just paste the IP address
into your browser window, adding with suffix ":8787". You'll see a login
prompt where you can enter your IU username and the default password
`learningR`.

Now you'll see something that looks like this:

![Rstudio](./Figures/rstudioOverview.png)

This is Rstudio, a graphical program that interfaces with R itself, which is
a text-only program.
This is an example of an *integrated development environment*.
Basically, it brings together a ton of really useful tools for programming in
a specific language or purpose. There are IDEs available for most widely-used
programming languages.

The left pane is how we pass instructions into the computer directly.
Most of the techniques we'll be learning in this class, and indeed many others
that are used broadly in scientific data analysis and computing in general
will use a text-based interface like this one.
The simplest way of interacting with the machine is simply by typing our
commands into the console directly.
This is termed using a program *interactively*.
First, let's change our passwords. Click the "Terminal" tab in the top left.
This is our interface directly with the virtual machine we're working on.
Type `passwd` (the Linux command to change a user's password) into the terminal
after the `$` prompt. You'll see this:

    Changing password for mpjuers.
    (current) UNIX password:

Type your current password (`learningR`) into the prompt.
*You will not see any characters displayed as you type.*
Press Enter/Return and you'll be asked to confirm it.
