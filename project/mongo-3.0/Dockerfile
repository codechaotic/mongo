FROM scratch
ADD output/images/rootfs.tar /

RUN addgroup -S mongodb && adduser -SH  mongodb

RUN mkdir -p /data/db && chown -R mongodb:mongodb /data/db
VOLUME /data/db

USER mongodb

EXPOSE 27017
CMD ["mongod"]
