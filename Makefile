VERSION=$(strip $(shell date -u '+%Y%m%dT%H%M%SZ'))
RELEASE_VERSION=v$(VERSION)
GIT_BRANCH=$(strip $(shell git symbolic-ref --short HEAD))
GIT_VERSION="$(strip $(shell git rev-parse --short HEAD))"
GIT_LOG=$(shell git log `git describe --tags --abbrev=0`..HEAD --pretty="tformat:%h | %s [%an]\n" | sed "s/\"/'/g")
PLATFORM_VERSION=$(strip $(shell cat platform/version))
SUB_APPS_VERSIONS=platform: $(PLATFORM_VERSION)
RELEASE_BODY=release on branch __$(GIT_BRANCH)__\n\n$(GIT_LOG)\n\n$(SUB_APPS_VERSIONS)
ifeq ($(app),)
else
	RELEASE_BODY+=\n\napps=$(app)
endif
RELEASE_DATA='{"tag_name": "$(RELEASE_VERSION)", "name": "$(RELEASE_VERSION)", "target_commitish": "master", "body": "$(RELEASE_BODY)"}'
RELEASE_URL=https://api.github.com/repos/AlexanderChen1989/hello_world/releases

release:
ifeq ($(GITHUB_TOKEN),)
	@echo "To generate a release, you need to define 'GITHUB_TOKEN' in your env."
else
	@echo "Create a release on $(RELEASE_VERSION)"
	@git tag -a $(RELEASE_VERSION) -m "Release $(RELEASE_VERSION). Revision is: $(GIT_VERSION)"
	@git push origin $(RELEASE_VERSION)
	curl -s -d $(RELEASE_DATA) "$(RELEASE_URL)?access_token=$(GITHUB_TOKEN)"
endif