FROM alpine:3.18

RUN  apk update && apk upgrade && apk add --no-cache nginx openssl
# apk 파일 관리자가 최신 소프트웨어 버전으로 저장소목록을 업데이트하고, \
# 소스를 캐시에 저장하지 않고 nginx를 설치하도록 지시. 데비안에서의 apt과 동일하게 작동
RUN apk add --no-cache tini

COPY ./conf/nginx.conf /etc/nginx/http.d
RUN  mkdir -p /etc/nginx/ssl
# openSSL 을 사용하여 SSL 인증서 생성
RUN  openssl req -x509 \
	# X.509 : 인증서 생성 관리 표준
     -nodes \
	# 인증서를 비 암호화
     -days 365 \
	# 유효기간 365일
     -newkey rsa:2048 \
	# RSA, 2048비트 개인키
     -keyout /etc/ssl/private/naki.42.fr.key \
     -out /etc/ssl/certs/naki.42.fr.crt \
     -subj "/C=KR/ST=Seoul/L=Gaepo/O=42Seoul/OU=Develop/CN=naki"
    # 인증서에 포함될 정보 :  국가(C), 지역(ST), 조직(O), 부서(OU), 일반 이름(CN)
EXPOSE 443
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["nginx", "-g", "daemon off;"]
# 설치된 구성 실행. 데몬모드가 아닌 nginx를 직접 실행.