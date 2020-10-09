.PHONY: build publish

build:
	docker build --target=base -t kyokley/neovim .
	docker build --target=custom -t kyokley/neovim-custom .

publish: build
	docker push kyokley/neovim
	docker push kyokley/neovim-custom
