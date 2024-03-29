#!/bin/sh

openrc default
if [ ! -d "/var/lib/mysql/mysql" ]; then

    if [ ! -e /etc/mysql/my.cnf ]; then
        cat /my.cnf.tmpl | envsubst > /etc/mysql/my.cnf
    fi

    /etc/init.d/mariadb setup
    rc-service mariadb start

    # Creating db for wordpress
    cat /tmpl.sql | envsubst | mysql -u root

    rc-service mariadb stop

fi

# Running daemon
exec mysqld_safe --datadir="/var/lib/mysql" $@