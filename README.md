backshop-jenkins
================

Setup a jenkins host on vagrant for some local testing.

Setup
=====

Download and install VirtualBox from http://download.virtualbox.org/virtualbox/4.3.18/VirtualBox-4.3.18-96516-OSX.dmg and then run ```./bootstrap.sh.```
If you need to reconfigure the host, run ```vagrant provision jenkins```.

Usage
=====

Access the jenkins webinterface on http://10.0.142.2/.
Access the host by running ```vagrant ssh jenkins```.
If you need to add more plugins, add them to ```jenkins_plugins``` list on ```jenkins.yml```.

More info
=========

Check these roles documentation on https://github.com/Stouts/Stouts.jenkins and https://github.com/Stouts/Stouts.nginx.
