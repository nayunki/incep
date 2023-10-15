
name = inception

all:
	@printf "Launch configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
	@docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up -d

up:
	@printf "Up all stoped container${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up -d

down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env down

re: fclean
	@printf "Rebuild configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up -d --build

clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a
	@sudo rm -rf ~/data/


fclean: clean
	@printf "Total clean of all configurations docker\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env down -v
	@docker system prune --volumes
	@docker network prune
	@docker volume prune -a
	@docker image prune -a
	@docker system prune -a

.PHONY	: all up down re clean fclean
