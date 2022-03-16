.PHONY: build maria

run:
	go run cmd/main.go

build:
	go build \
		-ldflags "-X main.buildcommit=`git rev-parse --short HEAD` \
		-X main.buildtime=`date "+%Y-%m-%dT%H:%M:%S%Z:00"`" \
		-o app cmd/main.go

db:
	docker run --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD=mysecretpassword -e POSTGRES_DB=myapp -d postgres

image:
	docker build -t todo:test -f Dockerfile .

container:
	docker run -p:8081:8081 --env-file ./local.env --link some-mariadb:db \
	--name myapp todo:test

installvegeta:
	go install github.com/tsenart/vegeta@latest
vegeta:
	echo "GET http://:8081/limitz" | vegeta attack -rate=10/s -duration=1s | vegeta report
load:
	echo "GET http://:8081/limitz" | vegeta attack -rate=10/s -duration=1s > results.10qps.bin
plot:
	 cat results.10qps.bin | vegeta plot > plot.10qps.html
hist:
	cat results.10qps.bin | vegeta report -type="hist[0,100ms,200ms,300ms]"