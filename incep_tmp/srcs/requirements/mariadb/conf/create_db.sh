#!bin/sh

cat > /tmp/create_db_sql << EOF
USE mysql;
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS WORDPRESS;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PW';
GRANT ALL PRIVILEGES ON WORDPRESS.* TO '$MYSQL_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PW';
FLUSH PRIVILEGES;
EOF

# run init.sql
/usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db_sql
/usr/bin/mysqld -u mysql
