#!bin/sh

#make user and
#set all permission
#set root passwd
cat > /tmp/create_db_sql << EOF
USE mysql;
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PWD';
GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PWD';
FLUSH PRIVILEGES;
EOF

# run init.sql
/usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db_sql
/usr/bin/mysqld -u mysql
