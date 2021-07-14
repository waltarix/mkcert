build:
	goreleaser --rm-dist --snapshot --skip-publish

clean:
	$(RM) -r dist

.PHONY: build clean
