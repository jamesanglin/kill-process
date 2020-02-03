FROM ubuntu:18.04

ENV APP_DIR /opt/application/killprocess
WORKDIR $APP_DIR

RUN apt update && apt install -y cron htop vim dos2unix

# install killprocess
COPY killprocess.sh killprocess.sh
RUN dos2unix killprocess.sh
RUN chmod +x killprocess.sh
RUN echo "* * * * * /opt/application/killprocess/killprocess.sh kill top cpu > /proc/1/fd/1 2>/proc/1/fd/2" >> /etc/cron.d/killprocess
RUN crontab /etc/cron.d/killprocess

ENV KILLLIST="default"
ENV EMAIL=""
ENV MAX_CPU=90
ENV MAX_SEC=1800
ENV MAX_SEC2=2700
ENV MAX_RAM=358400
ENV EXCLUDE_ROOT="grep -v root"
ENV COLSNUM=""

ENTRYPOINT ["cron", "-f"]