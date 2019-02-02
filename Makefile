build_name=latest
docker_name=airflow

all: stop rm run

pull:
	docker pull 10.99.195.7:8080/{docker-name}:{build_name}

run:
	docker run --rm -e http_proxy=${http_proxy} \
                        -e https_proxy=${http_proxy} \
			--hostname localhost \
			-p 30960:8080 \
                        --name ${docker_name} -it 10.99.195.7:8080/${docker_name}:${build_name}

stop:
	-docker stop ${docker_name}

rm:
	-docker rm ${docker_name}

rmi:
	-docker rmi ${docker_name}



