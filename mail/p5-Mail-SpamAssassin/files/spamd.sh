#!/bin/sh
#
# $FreeBSD$
#

# PROVIDE: spamd
# REQUIRE: LOGIN
# BEFORE: mail
# KEYWORD: FreeBSD shutdown

#
# Add the following lines to /etc/rc.conf to enable spamd:
#
#spamd_enable="YES"
#
# See spamd(8) for flags
#

. %%RC_SUBR%%

name=spamd
rcvar=`set_rcvar`

load_rc_config $name

# Set defaults
: ${spamd_enable:="NO"}
: ${spamd_flags="-c %%SQL_FLAG%% %%RUN_AS_USER%%"}

pidfile=${spamd_pidfile:-"/var/run/spamd/spamd.pid"}
command=%%PREFIX%%/bin/spamd
command_args="-d -r ${pidfile}"
required_dirs=%%PREFIX%%/share/spamassassin

stop_postcmd=stop_postcmd

stop_postcmd()
{
  rm -f $pidfile
}

run_rc_command "$1"
