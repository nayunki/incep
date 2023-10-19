FROM alpine:3.18.3

RUN apk update && apk upgrade
RUN apk add --no-cache nginx openssl tini

COPY ./conf/nginx.conf /etc/nginx/http.d
# 호스트 파일을 컨테이너 내부로 복사

# openSSL 을 사용하여 자체서명 SSL 인증서 생성
RUN  mkdir -p /etc/nginx/ssl
RUN  openssl req -x509 \
# 인증서서명요청서 생성 (request), X.509 : 인증서 생성 관리 표준
     -nodes \
# 개인 키를 비암호화
     -days 365 \
     -newkey rsa:2048 \
# 365일 유효기간, 2048비트 RSA키
     -keyout /etc/ssl/private/naki.42.fr.key \
     -out /etc/ssl/certs/naki.42.fr.crt \
# 개인키 & 인증서
     -subj "/C=KR/ST=Seoul/L=Gaepo/O=42Seoul/OU=Develop/CN=naki"
# 인증서에 포함될 정보 :  국가(C), 지역(ST), 조직(O), 부서(OU), 일반 이름(CN)

EXPOSE 443
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["nginx", "-g", "daemon off;"]
# 전역적으로, 포그라운드에서 nginx 실행
