# restart services in docker-compose
docker-compose-restart(){
	docker-compose stop $@
	docker-compose rm -f -v $@
	#docker-compose create --force-recreate $@
	#docker-compose create --no-start $@
	docker-compose up --no-start $@
	docker-compose start $@
	#docker-compose start $@
}
