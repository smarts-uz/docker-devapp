echo "myname * mypass *" >> /chap-secrets

docker run --name pptpd --privileged -d -p 1723:1723 -v /chap-secrets:/etc/ppp/chap-secrets:ro whuwxl/pptpd

-----------------------------------------------------------


docker ps

docker rm --force pptpd

echo "home * home *" >> /chap-secrets
echo "asror * asror *" >> /chap-secrets
echo "abror * abror *" >> /chap-secrets

docker run --name pptpd  --privileged -d -p 1723:1723 --restart always -v /chap-secrets:/etc/ppp/chap-secrets:ro whuwxl/pptpd

docker run -it --name php-fpm2 -p 9000:9000 -v d:/Develop/Projects/PHP/docker/php-fpm/php7.2.ini:/usr/local/etc/php/php.ini  -v d:/Develop/Projects/PHP/asrorz/:/var/www:cached  asrorz_php-fpm

 
docker pull 

docker container rm --force --link nginx2

docker run -it --name nginx3 -p 80:80 -p 443:443 -v d:/Develop/Projects/PHP/asrorz/:/var/www:cached -v d:/Develop/Projects/PHP/logger/nginx:/var/log/nginx -v d:/Develop/Projects/PHP/docker/nginx/nginx.conf:/etc/nginx/nginx.conf:ro -v d:/Develop/Projects/PHP/docker/nginx/sites:/etc/nginx/sites-available -v d:/Develop/Projects/PHP/docker/nginx/ssl:/etc/nginx/ssl asrorz_nginx



-v ./../asrorz:/var/www:cached -v ./../logger/nginx:/var/log/nginx -v ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro -v ./nginx/sites:/etc/nginx/sites-available -v ./nginx/ssl:/etc/nginx/ssl
