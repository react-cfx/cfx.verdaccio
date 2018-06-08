.PHONY: default

default: rm
	env PORT=4000 make deamon

ImgName := cfx/verdaccio
PjName := cfx.verdaccio
verdaccio := verdaccio/verdaccio:3.0.0

build:
	docker build -t ${ImgName} .

rebuild:
	docker build --no-cache -t ${ImgName} .

in:
	docker run --rm -ti \
		--name=${PjName} \
		-v $$(pwd):/root/${PjName} \
			${ImgName} /bin/bash

deamon:
	docker run -d \
		--name=verdaccio \
		--restart=always \
		-v $$(pwd)/conf:/verdaccio/conf:ro \
		-v $$(pwd)/storage:/verdaccio/storage \
		-p ${PORT}:4873 \
		${verdaccio}

rm:
	-docker rm -f verdaccio

logs:
	docker logs -f verdaccio

clean:
	rm -rf ./storage/* ./storage/.sinopia-db.json
	touch ./storage/.gitkeep
