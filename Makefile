all: roonserver

base:
	docker build -t mikedickey/roonserver-base:latest -f Dockerfile.base .

roonserver:
	docker build --no-cache -t mikedickey/roonserver:latest -f Dockerfile .

stop:
	docker kill RoonServer
	docker rm RoonServer

start:
	/usr/local/bin/start_roon.sh

restart:
	docker kill RoonServer
	docker rm RoonServer
	/usr/local/bin/start_roon.sh
