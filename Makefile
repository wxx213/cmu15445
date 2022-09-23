IMAGE = cmu15445-dev
PWD = $(shell pwd)

build: image
	docker run -it --rm -v $(PWD):/tmp/cmu15445 $(IMAGE) bash -c \
	"cd /tmp/cmu15445 && rm -rf build && mkdir build && cd build && cmake .. && make"

test: image
	docker run -it --rm -v $(PWD):/tmp/cmu15445 $(IMAGE) bash -c \
	"cd /tmp/cmu15445 && cd build && make check-tests"

clean: image
	docker run -it --rm -v $(PWD):/tmp/cmu15445 $(IMAGE) bash -c \
	"cd /tmp/cmu15445 && rm -rf build"

# make sure the docker version is fresh enough for ubuntu 22.04
image:
	if [ -z `docker image ls -q $(IMAGE)` ]; \
	then \
		docker build -t $(IMAGE) .; \
	fi
	
