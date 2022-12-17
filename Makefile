build:
	docker build -t glogar/toolbox .

run:
	docker run -it --rm --pid=host --net=host --privileged -v /Users/glogar/GIT:/GIT -v /Users/glogar/.ssh:/root/.ssh glogar/toolbox