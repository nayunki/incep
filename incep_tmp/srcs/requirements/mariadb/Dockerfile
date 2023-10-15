FROM alpine:3.17

RUN mkdir -p /run/mysqld
# MariaDB가 소켓 파일을 저장하는 위치
RUN mkdir -p /var/lib/mysql
# data 저장 폴더
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client
RUN apk add --no-cache tini

COPY ./conf/create_db.sh /tmp/create_db.sh
RUN chown -R mysql:mysql /run/mysqld

RUN chmod 777 /var/run/mysqld; \
    { echo '[mysqld]'; \
      echo 'skip-host-cache'; \
    # 호스트 캐시 기능을 비활성화
      echo 'skip-name-resolve';  \
    # DNS 역방향 조회를 비활성화 : 성능, 보안, DNS 관리 작업 효율화가 목적
      echo 'bind-address=0.0.0.0';  \
    # all ip connection allow -> 연결을 위해
    } | tee  /etc/my.cnf.d/docker.cnf;


# maria db can connect to the network
RUN  sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf
# mariadb directory init
# user : mysql , datadir : /var/lib/mysql ,
# MariaDB와 관련된 데몬과 클라이언트를 설치하면, 시스템 상에 필요한 내용들을 자동으로 만들어주는 식의 일련의 과정을 수행하는 mysql-install-db 활용
RUN mysql_install_db --user=mysql \
								--basedir=/usr \
								--datadir=/var/lib/mysql \
								--skip-test-db
EXPOSE 3306

RUN chmod +x /tmp/create_db.sh
ENTRYPOINT ["/sbin/tini", "--"]

CMD ["sh", "/tmp/create_db.sh"]