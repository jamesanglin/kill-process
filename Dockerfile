FROM ubuntu:18.04

ENV APP_DIR /opt/application/killprocess
WORKDIR $APP_DIR

RUN apt update && apt install -y cron htop vim dos2unix

# install killprocess
COPY killprocess.sh killprocess.sh
COPY start.sh start.sh
RUN dos2unix start.sh && chmod +x start.sh
RUN dos2unix killprocess.sh && chmod +x killprocess.sh

ENV KILLLIST="default"
ENV EMAIL=""
ENV MAX_CPU=90
ENV MAX_SEC=300
ENV MAX_SEC2=600
ENV MAX_RAM=524288
ENV EXCLUDE_ROOT="grep -v root"
ENV COLSNUM=""

ENTRYPOINT ["./start.sh"]