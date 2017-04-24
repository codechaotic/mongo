FROM scratch
ARG PROJECT
ADD output/$PROJECT/images/rootfs.tar /

RUN adduser -SH  mongodb

RUN mkdir -p /data/db && chown -R mongodb:mongodb /data/db
VOLUME /data/db

USER mongodb

EXPOSE 27017
CMD ["mongod"]
