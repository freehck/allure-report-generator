FROM openjdk:11-jre

RUN apt-get update -y \
    && apt-get install inotify-tools -y \
    && apt-get clean

ARG ALLURE_VERSION

RUN wget https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/$ALLURE_VERSION/allure-commandline-$ALLURE_VERSION.tgz -O /tmp/allure-commandline-$ALLURE_VERSION.tgz \
    && tar xf /tmp/allure-commandline-$ALLURE_VERSION.tgz -C /opt \
    && ln -s /opt/allure-$ALLURE_VERSION /opt/allure

COPY report-generator.sh /report-generator.sh
CMD /report-generator.sh
