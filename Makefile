export ALLURE_VERSION=2.13.2

.PHONY: build push

build:
	docker build --build-arg ALLURE_VERSION=$(ALLURE_VERSION) \
                     -t freehck/allure-report-generator:$(ALLURE_VERSION) \
                     -t freehck/allure-report-generator:latest \
                     .

push:
	docker push "freehck/allure-report-generator:$(ALLURE_VERSION)"
	docker push "freehck/allure-report-generator:latest"
