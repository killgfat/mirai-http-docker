FROM azul/zulu-openjdk-debian:17-latest

WORKDIR /app

COPY ./app /app/

ENTRYPOINT ["/app/mcl -u && /app/mcl"]
