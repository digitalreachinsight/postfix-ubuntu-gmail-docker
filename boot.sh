#!/bin/bash

#rm -rf /etc/postfix-conf
#
#ln -s /shared-mount/postfix-conf /etc/postfix-conf

shared_dir="/shared-mount"
if [ -e "$shared_dir/run.container" ]
then
   echo "File Exists $shared_dir/run.container"
   chmod 700  $shared_dir/run.container
else
   touch "$shared_dir/run.container"
   chmod 700  $shared_dir/run.container
fi
$shared_dir/run.container

if [ -d "$shared_dir/postfix-mail" ]
then
   echo "Directory Exists $shared_dir/postfix-mail"
else
   mkdir "$shared_dir/postfix-mail"
fi

if [ -d "$shared_dir/queue_dir" ]
then
   echo "exists";
else
   mkdir $shared_dir/queue_dir;
fi

mv /var/spool/postfix /var/spool/postfix-container
ln -s $shared_dir/queue_dir /var/spool/postfix

if [ -d "$shared_dir/queue_dir/opendkim" ]
then
   echo "exists";
else
   mkdir $shared_dir/queue_dir/opendkim;
fi


# chown opendkim.postfix $shared_dir/queue_dir/opendkim

# mv /etc/dovecot/conf.d /etc/dovecot/conf.d-docker-container
# ln -s /shared-mount/dovecot-conf /etc/dovecot/conf.d
# mv /var/mail /var/mail-container
# ln -s $shared_dir/postfix-mail /var/mail
# service syslog-ng start 
# status=$?
# if [ $status -ne 0 ]; then
#     echo "Failed to start syslog-ng: $status"
#     exit $status
# fi



# # Start the first process
# env > /etc/.cronenv
# rm /etc/cron.d/dockercron
# #ln -s /shared-mount/postfix-conf/dockercron /etc/cron.d/dockercron
# cp /shared-mount/postfix-conf/dockercron /etc/cron.d/dockercron

# service cron start 
# status=$?
# if [ $status -ne 0 ]; then
#   echo "Failed to start cron: $status"
#   exit $status
# fi

# # Start the second process
# cp /shared-mount/postfix-conf/main.cf /etc/postfix/
# cp /shared-mount/postfix-conf/master.cf /etc/postfix/
# cp /shared-mount/opendkim/opendkim-default /etc/default/opendkim
# chown -R opendkim:opendkim /shared-mount/opendkim/keys/
# mv /etc/opendkim.conf /etc/opendkim.conf-container
# ln -s /shared-mount/opendkim/opendkim.conf /etc/opendkim.conf


# chown -R opendkim.opendkim $shared_dir/opendkim
# chown -R www-data.www-data $shared_dir/postfix-conf
# chown -R www-data.www-data $shared_dir/run.container
# chown -R www-data.www-data $shared_dir/sync_relays.sh
# chown -R www-data.www-data $shared_dir/account_manager.sh
# chown -R www-data.www-data $shared_dir/accounts.txt
# chown -R www-data.www-data $shared_dir/dovecot-conf
# chown -R www-data.www-data $shared_dir/keys
# chmod -R 0600 $shared_dir/keys
# # queue dir
# chmod 777 $shared_dir/queue_dir
# chown -R postfix $shared_dir/queue_dir/active
# chmod 0700 $shared_dir/queue_dir/active
# chown -R postfix $shared_dir/queue_dir/bounce
# chmod 0700 $shared_dir/queue_dir/bounce
# chown -R postfix $shared_dir/queue_dir/corrupt
# chmod 0700 $shared_dir/queue_dir/corrupt
# chown -R postfix $shared_dir/queue_dir/defer
# chmod 0700 $shared_dir/queue_dir/defer
# chown -R postfix $shared_dir/queue_dir/deferred
# chmod 0700 $shared_dir/queue_dir/deferred
# chown -R postfix $shared_dir/queue_dir/flush
# chmod 0700 $shared_dir/queue_dir/flush
# chown -R postfix $shared_dir/queue_dir/hold
# chmod 0700 $shared_dir/queue_dir/hold
# chown -R postfix $shared_dir/queue_dir/incoming
# chmod 0700 $shared_dir/queue_dir/incoming
# chown -R postfix.postdrop $shared_dir/queue_dir/maildrop
# chmod 0730 $shared_dir/queue_dir/maildrop
# chown -R opendkim.postfix $shared_dir/queue_dir/opendkim
# chmod 0755  $shared_dir/queue_dir/opendkim
# chown -R postfix $shared_dir/queue_dir/private
# chmod 0700 $shared_dir/queue_dir/private
# chown -R postfix.postdrop $shared_dir/queue_dir/public
# chmod 0710 $shared_dir/queue_dir/public
# chown -R postfix $shared_dir/queue_dir/saved
# chmod 0700 $shared_dir/queue_dir/saved
# chown -R postfix $shared_dir/queue_dir/trace
# chmod 0700 $shared_dir/queue_dir/trace

# # queue directory


echo gmail-relay-container > /etc/mailname

service postfix start 
status=$?
if [ $status -ne 0 ]; then
	  echo "Failed to start postfix: $status"
    exit $status
fi

# Start the second process
service dovecot start 
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start dovecot: $status"
  exit $status
fi


bash
