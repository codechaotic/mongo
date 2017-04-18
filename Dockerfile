FROM scratch
ARG PROJECT
ADD project/$PROJECT/output/images/rootfs.tar /

RUN adduser -SH  mongodb

RUN mkdir -p /data/db && chown -R mongodb:mongodb /data/db
VOLUME /data/db

USER mongodb

EXPOSE 27017
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mongod"]
