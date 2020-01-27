#!/bin/bash

# configure bash history logging to rsyslog
# 2017-12-31/04:05/PC
# kindly provided by Peter Creyghton

## add bash history logging in a function in /etc/bashrc

cat >> /etc/bashrc <<-'EOF'
function clilog {
	COMMAND=$(history 1|cut -c 8-);	NEWLINE=$(history 1|cut -c 1-6)
	if [ "${SUDO_USER}" = "" ]; then
        U="${USER}"
    else
        U="${SUDO_USER} as ${USER}"
    fi
	if [ "$LASTLINE" != "" ] && [ "$LASTLINE" != "$NEWLINE" ]; then
	    logger -p local1.notice -t bash -i -- "${U}: ${COMMAND}"
	else
		if [ "$LASTLINE" = "" ] && [ "$NEWLINE" != "" ]; then
			if [ "$USER" = "root" ]; then 
				if [ "$SUDO_USER" = "" ]; then 
					logger -p local1.notice -t bash -i -- "------ root has started bash session"
				else
					logger -p local1.notice -t bash -i -- "------ $SUDO_USER has started bash session as root"
				fi
			else
				logger -p local1.notice -t bash -i -- "------ ${U}: starting bash session"
			fi
		fi	
	fi
	LASTLINE=$NEWLINE
}
trap clilog DEBUG
EOF

## configure rsyslog for history logging

# send cli logging to separate logfile
cat >> /etc/rsyslog.conf <<-'EOF'
local1.notice  /var/log/history.log
EOF
# don't send history to main logfile
sed -i "s/cron.none/cron.none;local1.none/" /etc/rsyslog.conf
# restart service
systemctl restart rsyslog


# optionally, send all terminal output to a logfile per session
echo "script -q /var/log/shell.$(date "+%F%T").$USER.log; exit 2>/dev/null" >> /etc/bashrc 
alias less='less -r'

## final messages
echo "Log out and in again to activate bash history logging"
echo
echo "Remember to enable duplicates if needed by remarking export HISTCONTROL=ignoredups in /etc/profile"
