.PHONY: clean dist docker

version = $(shell dzil distversion)

clean:
	dzil clean
{{ $dist->name }}-%.tar.gz:
	dzil build
dist: {{ $dist->name }}-$(version).tar.gz
docker: dist
	docker build \
		--build-arg version=`dzil distversion` \
		--build-arg gitrev="`set -x ; git rev-parse HEAD ; git status ; git diff`" \
		-t quay.io/opusvl/{{ lc $dist->name }}:latest .
