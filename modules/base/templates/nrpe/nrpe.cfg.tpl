# LOG FACILITY
# The syslog facility that should be used for logging purposes.

log_facility=daemon

# DEBUGGING OPTION
# This option determines whether or not debugging messages are logged to the
# syslog facility.
# Values: 0=debugging off, 1=debugging on

debug=0

# PID FILE
# The name of the file in which the NRPE daemon should write it's process ID
# number.  The file is only written if the NRPE daemon is started by the root
# user and is running in standalone mode.

pid_file=/var/run/nrpe/nrpe.pid

# PORT NUMBER
# Port number we should wait for connections on.
# NOTE: This must be a non-privileged port (i.e. > 1024).
# NOTE: This option is ignored if NRPE is running under either inetd
# or xinetd or via systemd. [In systemd please use
# systemctl edit nrpe.service
# to set up the port.

server_port=5666

# NRPE USER
# This determines the effective user that the NRPE daemon should run as.
# You can either supply a username or a UID.
#
# NOTE: This option is ignored if NRPE is running under either inetd
# or xinetd or via systemd. [In systemd please use
# systemctl edit nrpe.service
# to set up the group.

nrpe_user=nrpe

# NRPE GROUP
# This determines the effective group that the NRPE daemon should run as.
# You can either supply a group name or a GID.
#
# NOTE: This option is ignored if NRPE is running under either inetd
# or xinetd or via systemd. [In systemd please use
# systemctl edit nrpe.service
# to set up the user.

nrpe_group=nrpe

# ALLOWED HOST ADDRESSES
# This is an optional comma-delimited list of IP address or hostnames
# that are allowed to talk to the NRPE daemon. Network addresses with a bit mask
# (i.e. 192.168.1.0/24) are also supported. Hostname wildcards are not currently
# supported.
#
# Note: The daemon only does rudimentary checking of the client's IP
# address.  I would highly recommend adding entries in your /etc/hosts.allow
# file to allow only the specified host to connect to the port
# you are running this daemon on.
#
# NOTE: This option is ignored if NRPE is running under either inetd
# or xinetd or systemd

<% if not @allowed_hosts.empty? -%>
allowed_hosts=<%= @allowed_hosts.sort.join(',') %>,127.0.0.1,::1
<% else %>
allowed_hosts=127.0.0.1,::1
<% end -%>

# COMMAND ARGUMENT PROCESSING
# This option determines whether or not the NRPE daemon will allow clients
# to specify arguments to commands that are executed.  This option only works
# if the daemon was configured with the --enable-command-args configure script
# option.
#
# *** ENABLING THIS OPTION IS A SECURITY RISK! ***
# Read the SECURITY file for information on some of the security implications
# of enabling this variable.
#
# Values: 0=do not allow arguments, 1=allow command arguments

dont_blame_nrpe=1

# BASH COMMAND SUBSTITUTION
# This option determines whether or not the NRPE daemon will allow clients
# to specify arguments that contain bash command substitutions of the form
# $(...).  This option only works if the daemon was configured with both
# the --enable-command-args and --enable-bash-command-substitution configure
# script options.
#
# *** ENABLING THIS OPTION IS A HIGH SECURITY RISK! ***
# Read the SECURITY file for information on some of the security implications
# of enabling this variable.
#
# Values: 0=do not allow bash command substitutions,
#         1=allow bash command substitutions

allow_bash_command_substitution=0

# COMMAND TIMEOUT
# This specifies the maximum number of seconds that the NRPE daemon will
# allow plugins to finish executing before killing them off.

command_timeout=60

# CONNECTION TIMEOUT
# This specifies the maximum number of seconds that the NRPE daemon will
# wait for a connection to be established before exiting. This is sometimes
# seen where a network problem stops the SSL being established even though
# all network sessions are connected. This causes the nrpe daemons to
# accumulate, eating system resources. Do not set this too low.

connection_timeout=300



# INCLUDE CONFIG DIRECTORY

include_dir=/etc/nrpe.d/