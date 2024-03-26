all: roonserver

base:
	docker build -t mikedickey/roonserver:base -f Dockerfile.base .

roonserver:
	docker build --no-cache -t mikedickey/roonserver:latest -f Dockerfile .

stop:
	docker-compose -f /etc/compose/roon.yml down

start:
	docker-compose -f /etc/compose/roon.yml up -d

restart:
	docker-compose -f /etc/compose/roon.yml down
	docker-compose -f /etc/compose/roon.yml up -d

