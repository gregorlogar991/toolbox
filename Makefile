build:
	docker build -t ghcr.io/gregorlogar991/toolbox:latest .

run:
	docker run -it --rm --pid=host --net=host --privileged -v /Users/glogar/GIT:/GIT -v /Users/glogar/.ssh:/root/.ssh ghcr.io/gregorlogar991/toolbox:latest
