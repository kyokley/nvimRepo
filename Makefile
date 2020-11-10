.PHONY: build publish

NO_CACHE?=0

build:
ifeq ($(NO_CACHE), 1)
	docker build --no-cache --target=base -t kyokley/neovim .
	docker build --no-cache --target=custom -t kyokley/neovim-custom .
else
	docker build --target=base -t kyokley/neovim .
	docker build --target=custom -t kyokley/neovim-custom .
endif

publish: build
	docker push kyokley/neovim
	docker push kyokley/neovim-custom
