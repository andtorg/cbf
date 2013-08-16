Enhanced CBF
===============================


About
-

This is a modified version of some scripts developed by Webdetails in 
order to help deploying Pentaho BI server. Original versions can be
forked from github at
- [webdetails/cbf](https://github.com/webdetails/cbf)
- [pmalves/ctools-installer](https://github.com/pmalves/ctools-installer)



##### Ctools-installer2

A bash script that works both in mode downloads and install, according to the value of the parameter -m
passed on the command line.

In download mode, it stores the ctools + saiku components in a pentaho-addons/ folder, downloading from the Internet
all the relevant files, according to version numbers passed as parameters. Note: it only gets stable versions.

This way, you will always have a local repository of stable versions to use in your next build process.
This should make the build process more predictible on solutions already deployed, avoiding backward compatibility 
issues arising from using more recent version. 

Both the script and the folder pentaho-addons/ should stay under cbf main folder.

In install mode, the script can be invoked during build process, setting the related properties that cbf ant file
will read.

At prompt, launch `./ctools-installer2.sh` to see all the options.




##### CBF - Community Build Framework

This ant build file (build.xml) Focused on a multi-project/ multi-environment scenario, the Community Build
Framework (CBF) is the way to setup and deploy Pentaho based applications.


If you work in several projects at the same time, or have to switch among
several environments (production, development, etc.), or need to customize the
Pentaho server (using different databases, changing the L&F, applying different
security types, etc.), CBF is the right tool for you.


CBF is an ant build file (build.xml). Check more extended documentation in
http://cbf.webdetails.org






####Deprecated - to be amended

Features
--------

 Focused on a multi-project/ multi-environment scenario, here are the main characteristics:

* Ability to switch from totally different projects on the fly
* Supports multiple environments (eg: development, production, worker1, worker2...)
* No changes to the original files that could get overwritten in a upgrade
* Supports multiple platform versions
* Simplifies version upgrades
* Debug-friendly
* VCS (Version Control System)-friendly
* Supports all kind of different customization in different projects, from using different databases to different security types
* Supports patches to the source code for fine-grain customization
* Supports deploy to local/remote machines
* OS independent


Requirements
------------

We will need:
* A shell (if on windows, cygwin or equivalent is required)
* Clean directory to host your CBF installation
* Jdk 1.6
* Ant 1.7
* Tomcat 6.0.x (for pentaho 3.7 or before, tomcat 5.5 is required)
* Svn client
* RSync / ssh to do remote deploy

License
-------

CBF is licensed under the [MPLv2](http://www.mozilla.org/MPL/2.0/) license.
