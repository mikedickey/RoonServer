all: roonserver

roonserver:
	docker build -t mikedickey/roonserver:latest -f Dockerfile .

stop:
	docker-compose -f /etc/compose/roon.yml down

start:
	docker-compose -f /etc/compose/roon.yml up -d

restart:
	docker-compose -f /etc/compose/roon.yml down
	docker-compose -f /etc/compose/roon.yml up -d

