FROM scratch
ADD rootfs.tar /

RUN adduser -S  mongodb

USER mongodb

EXPOSE 27017
CMD ["mongo"]
