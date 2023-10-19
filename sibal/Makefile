NAME = Inception
DOCKER_COMPOSE_PATH = ./srcs/docker-compose.yml

all:
	mkdir -p /home/naki/data/db-data
	mkdir -p /home/naki/data/wp-data
	docker-compose -f ${DOCKER_COMPOSE_PATH} build
# 도커파일로 이미지를 빌드
	make up
# 도커이미지로 컨테이너를 실행 (백그라운드에서 !)

up:
	docker-compose -f ${DOCKER_COMPOSE_PATH} up -d

down:
	docker-compose -f ${DOCKER_COMPOSE_PATH} down

clean:
	make down
	docker system prune -a
# 사용되지 않는 컨테이너, 네트워크, 이미지 등 구성요소를 제거

fclean:
	make clean
	docker-compose -f ${DOCKER_COMPOSE_PATH} down --volumes
# 컨테이너와 함께 볼륨 제거
	rm -rf /home/naki/data

re:
	make fclean
	make all

.PHONY	: all up down clean fclean re