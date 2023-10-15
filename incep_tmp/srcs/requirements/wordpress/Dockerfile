FROM alpine:3.17

RUN apk update && apk upgrade
RUN apk add --no-cache tini

RUN apk add php81        \
	# PHP 프로그래밍 언어
	php81-fpm     		 \
	# FastCGI Process Manager : PHP 실행 환경
    php81-mysqli         \
	# MySQL 데이터베이스에 연결하기 위한 확장
    php81-json            \
    # JSON 데이터 처리를 위한 확장
    php81-curl            \
    # curl : 웹 요청 및 데이터 전송을 위한 확장
    php81-dom              \
    # dom : XML 및 HTML 문서 처리를 위한 확장
    php81-exif             \
    # exif : 이미지 EXIF 데이터 처리를 위한 확장
    php81-fileinfo        \
    # fileinfo : 파일 형식 식별을 위한 확장
    php81-mbstring       \
    # MBString : 다국어 문자열 처리를 위한 확장
    php81-openssl         \
    # OpenSSL : 암호화 및 보안 기능을 위한 확장
    php81-xml             \
    # XML 데이터 처리를 위한 확장
    php81-zip              \
    # ZIP 파일 처리를 위한 확장
    php81-phar            \
    # Phar : PHP 아카이브 파일(.phar)을 실행하기 위한 확장
    php81-iconv           \
    # Iconv : 문자 인코딩 변환을 위한 확장
    mariadb-client        \
    # MariaDB 데이터베이스에 접속하기 위한 클라이언트
    curl
    # cURL - URL을 통해 데이터를 전송하기 위한 명령 줄 도구

# WP-CLI를 설치
WORKDIR /tmp

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin
RUN chmod +x /usr/local/bin/wp-cli.phar
# wp 명령을 /usr/local/bin 디렉토리에 생성하여 사용할 수 있도록 설정
RUN ln -sf /usr/local/bin/wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html
WORKDIR /var/www/html
# PHP-FPM 작업폴더 /var/www/html 디렉토리를 작업 디렉토리로 설정

RUN sed -i 's/;chdir = \/var\/www/chdir = \/var\/www\/html/g' /etc/php81/php-fpm.d/www.conf
# listen = 127.0.0.1:9000와 같이 설정된 경우, PHP-FPM은 로컬 호스트(127.0.0.1)의 9000 포트에서만 연결을 수신
# PHP-FPM은 모든 네트워크 인터페이스(로컬 루프백 및 외부 네트워크 인터페이스)에서 9000 포트로 들어오는 연결을 수신
# 웹 서버나 다른 시스템에서 PHP-FPM과 연결 가능해짐
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php81/php-fpm.d/www.conf

COPY ./conf/wordpress.sh /tmp/wordpress.sh
RUN chmod +x /tmp/wordpress.sh
EXPOSE 9000
ENTRYPOINT ["/sbin/tini", "--"]
# forground shell session not deamon
CMD ["sh", "/tmp/wordpress.sh"]
