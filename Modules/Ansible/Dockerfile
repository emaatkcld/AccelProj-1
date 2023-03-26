FROM openjdk:8
COPY spring-petclinic-2.4.2.war app/
COPY ./newrelic/newrelic.jar app/
COPY ./newrelic/newrelic.yml app/
ENV NEW_RELIC_APP_NAME="pet-adoption-dre"
ENV NEW_RELIC_LICENSE_KEY="19934c8af59dee4336ee880bff8a7f28c60cNRAL"
ENV NEW_RELIC_LOG_FILE_NAME="STDOUT"

