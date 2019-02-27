FROM openjdk:8-alpine

LABEL maintainer="dan@kryha.io"

RUN apk add --no-cache jq wget unzip nodejs

RUN wget -q -O sonar-scanner.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$(wget -O- -q https://api.github.com/repos/SonarSource/sonar-scanner-cli/tags |jq .[0]|jq -r .name)-linux.zip && \
	unzip -qq sonar-scanner.zip && mv sonar-scanner-* sonar-scanner && rm sonar-scanner.zip

RUN sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' sonar-scanner/bin/sonar-scanner

ENV SONAR_RUNNER_HOME=/root/sonar-scanner
ENV PATH $PATH:/root/sonar-scanner/bin

CMD sonar-scanner/bin/sonar-scanner