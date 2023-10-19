FROM alpine:3.18.3

RUN apk update && apk upgrade

RUN apk add --no-cache php81 \
# PHP 프로그래밍 언어
    php81-fpm             \
# FPM (FastCGI Process Manager) - PHP 실행 환경
    php81-mysqli         \
# MySQL 데이터베이스에 연결하기 위한 확장
    php81-json            \
# JSON 데이터 처리를 위한 확장
    php81-curl            \
# 웹 요청 및 데이터 전송을 위한 확장
    php81-dom              \
# XML 및 HTML 문서 처리를 위한 확장
    php81-exif             \
# 이미지 EXIF 데이터 처리를 위한 확장
    php81-fileinfo        \
# 파일 형식 식별을 위한 확장
    php81-mbstring       \
# 다국어 문자열 처리를 위한 확장
    php81-openssl         \
# 암호화 및 보안 기능을 위한 확장
    php81-xml             \
# XML 확장 - XML 데이터 처리를 위한 확장
    php81-zip              \
# ZIP 파일 처리를 위한 확장
    php81-phar            \
# PHP 아카이브 파일(.phar)을 실행하기 위한 확장
    php81-iconv           \
# 문자 인코딩 변환을 위한 확장
    mariadb-client        \
# MariaDB 데이터베이스에 접속하기 위한 클라이언트
    curl				  \
# URL을 통해 데이터를 전송하기 위한 명령 줄 도구
	tini
# init system

# 명령어로 wordpress를 관리할 수 있는 도구인 wp-cli 설치
WORKDIR /tmp
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin
RUN chmod +x /usr/local/bin/wp-cli.phar
RUN ln -sf /usr/local/bin/wp-cli.phar /usr/local/bin/wp
# 심볼릭링크 설정 (alias 같은 역할)

RUN mkdir -p /var/www/html
# 워드프레스 루트 디렉토리 생성
WORKDIR /var/www/html
# PHP-FPM 작업폴더를 작업 디렉토리로 설정

RUN sed -i 's/;chdir = \/var\/www/chdir = \/var\/www\/html/g' /etc/php81/php-fpm.d/www.conf
# php-fpm의 www.conf 파일에서 설정을 수정, 작업 디렉토리 변경
RUN sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /etc/php81/php-fpm.d/www.conf
# listen = 127.0.0.1:9000로 설정된 경우, PHP-FPM은 로컬 호스트(127.0.0.1)의 9000 포트에서만 연결을 수신
# 모든 네트워크 인터페이스(로컬 루프백 및 외부 네트워크)에서 9000 포트로 들어오는 연결을 수신하도록 변경
# 웹 서버나 다른 시스템에서 PHP-FPM과 연결 가능해짐

COPY ./conf/wp.sh /tmp/wp.sh
RUN chmod +x /tmp/wp.sh
EXPOSE 9000
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["sh", "/tmp/wp.sh"]