FROM scratch
ADD output/images/rootfs.tar /

RUN adduser -S  mongodb

RUN mkdir -p /data/db && chown -R mongodb /data/db
VOLUME /data/db

USER mongodb

EXPOSE 27017
CMD ["mongod"]
