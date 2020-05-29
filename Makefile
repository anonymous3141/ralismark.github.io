#
# Project Make File
#

DOCKER_NAME = app-serve
DOCKER_OPTS = -v $(CURDIR):/app:ro -p 127.0.0.1:4000:4000

# Start a container
start: image _themes/xyz
	docker run $(DOCKER_OPTS) --rm -it --detach --name $(DOCKER_NAME) $(DOCKER_NAME)

fg: image _themes/xyz
	# xdg-open "http://localhost:4000"
	docker run $(DOCKER_OPTS) --rm -it --name $(DOCKER_NAME) $(DOCKER_NAME)

# Stop a running container
stop:
	docker stop -t 0 $(DOCKER_NAME)

# Build container image (don't run)
image: Dockerfile
	docker build -t $(DOCKER_NAME) -f Dockerfile .

# Load the theme
_themes/xyz:
	mkdir -p _themes
	git worktree add _themes/xyz theme

# Restart (stop then start) a container
restart: stop start

# Display and follow stdout/err logs
flogs:
	docker logs -f $(DOCKER_NAME)

# Run sh in the container
sh:
	docker exec -it $(DOCKER_NAME) /bin/sh

clean: stop
	docker rmi $(DOCKER_NAME)

.PHONY: start fg stop image restart flogs sh clean
