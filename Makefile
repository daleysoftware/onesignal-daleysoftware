all: deploy bust

deploy:
	mkdir -p _site
	cp index.html _site
	aws s3 sync --acl public-read --delete _site s3://onesignal.daleysoftware.com

bust:
	aws cloudfront create-invalidation \
		--paths "/*" \
		--distribution-id ER4M2W1FFCO95

test:
	./test-endpoints.sh

.PHONY: all deploy bust test
