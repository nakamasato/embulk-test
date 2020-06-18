FROM openjdk:8-jre-alpine

# Embulk 本体をインストールする
RUN wget -q https://dl.embulk.org/embulk-latest.jar -O /bin/embulk \
  && chmod +x /bin/embulk

# 使いたいプラグインを入れる
RUN apk add --no-cache libc6-compat \
  && embulk gem install embulk-output-mysql \
  && embulk gem install embulk-input-mysql 

WORKDIR /work

ENTRYPOINT ["java", "-jar", "/bin/embulk"]
