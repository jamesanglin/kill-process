FROM ubuntu:18.04

ENV APP_DIR /opt/application/killprocess
WORKDIR $APP_DIR

RUN apt update && apt install -y cron htop vim dos2unix

# install killprocess
COPY killprocess.sh killprocess.sh
RUN dos2unix killprocess.sh
RUN chmod +x killprocess.sh
RUN echo "* * * * * root /opt/application/killprocess/killprocess.sh kill top cpu > /proc/1/fd/1 2>/proc/1/fd/2" >> /etc/cron.d/killprocess
RUN crontab /etc/cron.d/killprocess

ENV KILLLIST="default"
ENV EMAIL=""
ENV MAX_CPU=90
ENV MAX_SEC=300
ENV MAX_SEC2=600
ENV MAX_RAM=524288
ENV EXCLUDE_ROOT="grep -v root"
ENV COLSNUM=""

ENTRYPOINT ["cron", "-f"]