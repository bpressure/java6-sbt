FROM store/oracle/serverjre:8

ENV SBT_VERSION 0.13.15
RUN yum install -y tar gzip && \
    curl -L https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz | tar zxvf - -C /usr/local && \
    ln -s /usr/local/sbt/bin/sbt /usr/local/bin/sbt && \
    mkdir -p /project/project

WORKDIR /project
RUN echo 'object Warmup extends App { println("\n\nsbt warmup done") }' > warmup.scala && \
    echo "sbt.version=$SBT_VERSION" > project/build.properties && \
    sbt run  && \
    echo 'scalaVersion := "2.12.2"' > build.sbt && \
    sbt run && \
    rm -rf /project/warmup.scala /project/target /project/project/target
