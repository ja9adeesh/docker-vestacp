#!/bin/bash

export TERM=xterm

if [ -z "`ls /vesta --hide='lost+found'`" ] 
then
	rsync -a /vesta-start/* /vesta
fi

#starting Vesta
cd /etc/init.d/ \
&& ./vesta start \
&& ./mysql start \
&& ./nginx start \
&& ./exim4 start \
&& ./bind9 start
&& ./dovecot start
