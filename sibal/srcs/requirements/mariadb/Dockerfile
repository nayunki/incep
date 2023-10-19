FROM alpine:3.18.3

RUN mkdir -p /run/mysqld
# MariaDB가 소켓 파일을 저장하는 위치
RUN mkdir -p /var/lib/mysql
# data 저장 폴더
RUN apk update && apk upgrade
RUN apk add --no-cache mariadb mariadb-client tini

COPY ./conf/create_db.sh /tmp/create_db.sh
# 컨테이너 내부 경로로 복사
RUN chown -R mysql:mysql /run/mysqld

RUN  sed -i "s/skip-networking/skip-networking=0/g" /etc/my.cnf.d/mariadb-server.cnf
# MariaDB 서버 설정 파일 수정, 네트워크 연결 가능
RUN sed -i "s/.*bind-address\s*=.*/bind-address=0.0.0.0/g" /etc/my.cnf.d/mariadb-server.cnf
# bind-address 옵션 수정, 모든 IP 주소로부터의 연결 수락

# MySQL 데이터베이스 초기화. 사용자를 mysql로 지정하고 MySQL의 설치 및 데이터 디렉토리 경로를 지정
RUN mysql_install_db --user=mysql \
					--basedir=/usr \
					--datadir=/var/lib/mysql \
					--skip-test-db

RUN chmod +x /tmp/create_db.sh
EXPOSE 3306
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["sh", "/tmp/create_db.sh"]
