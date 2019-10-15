build:
	docker build -t kyokley/neovim .
publish: build
	docker push kyokley/neovim
