.PHONY: build publish

build:
	docker build --target=custom -t kyokley/neovim-custom .
	docker build --target=base -t kyokley/neovim .

publish: build
	docker push kyokley/neovim
	docker push kyokley/neovim-custom
