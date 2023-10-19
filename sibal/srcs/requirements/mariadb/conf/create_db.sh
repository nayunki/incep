#mkdir -p /auth_pam_tool_dir
#touch /auth_pam_tool_dir/auth_pam_tool

# /tmp/init_db.sql 파일 생성, 아래 내용을 해당 파일에 적는다.
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
# mysql DB서버 초기화를 위해 --bootstrap 옵션과 함께 실행. 위 스크립트를 사용하여 DB 설정
/usr/bin/mysqld -u mysql
# 초기화된 MySQL DB 서버를 실행. mysql 사용자로 실행한다.
