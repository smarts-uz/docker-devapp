FROM redis
    
VOLUME /data

EXPOSE 6379

CMD ["redis-server"]