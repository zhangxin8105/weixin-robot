REPORTER = landing
LOG_FILE = ./tmp.log

TEST_TEXT_MSG = "@./test/wx_text.xml"
TEST_GEO_MSG = "@./test/wx_geo.xml"

req:
	clear
	curl -d $(TEST_TEXT_MSG) http://0.0.0.0:3000/
	@echo "\n"
	@echo "\n"
	curl -d $(TEST_GEO_MSG) http://0.0.0.0:3000/
	@echo "\n"

test:
	clear
	./node_modules/mocha/bin/mocha --reporter $(REPORTER)
	@echo "\n"

cov: lib-cov
	@EXPRESS_COV=1 $(MAKE) test REPORTER=html-cov > coverage.html
	@-rm -rf ../ll-cov

lib-cov:
	@jscoverage --exclude=.git --exclude=test --exclude=node_modules ./ ../ll-cov

.PHONY: test cov lib-cov