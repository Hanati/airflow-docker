build_name=latest
docker_name=airflow

all: stop rm run

build:
	docker build -t {docker_name} .

run:
	docker run --rm --hostname localhost \
			-p 8080:8080 \
                        --name ${docker_name} -it ${docker_name}:${build_name}

stop:
	-docker stop ${docker_name}

rm:
	-docker rm ${docker_name}

rmi:
	-docker rmi ${docker_name}



