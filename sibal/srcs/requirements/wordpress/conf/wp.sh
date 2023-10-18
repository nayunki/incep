# 워드프레스 CLI 명령어를 사용하여 워드프레스 웹사이트를 설치하고 설정하는 스크립트

if [ ! -f "/var/www/html/index.php" ]; then
# 워드프레스 설치 여부 체크 후 다운로드
  wp core download
  wp config create --dbhost=mariadb:3306 --dbname=${MYSQL_DB_NAME} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PWD}
# 워드프레스 설정파일인 wp-config.php 생성, 마리아디비 포트 3306 연결 및 데이터베이스 설정
  wp core install --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_NAME} --admin_password=${WP_ADMIN_PWD} \
                --admin_email=${WP_ADMIN_MAIL} --skip-email
# 워드프레스 설치 및 초기 설정
  wp user create ${WP_USER_NAME} ${WP_USER_MAIL} --user_pass=${WP_USER_PWD}
# 워드프레스에 새로운 유저 생성
fi

php-fpm81 -F
# php-fpm 서버 실행. forground shell session not deamon