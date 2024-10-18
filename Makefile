build:
	cd server && $(MAKE) build
	cd client && $(MAKE) build

start:
	docker-compose up -d 

stop:
	docker-compose down