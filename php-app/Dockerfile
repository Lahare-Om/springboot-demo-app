FROM php:8.2-fpm-alpine
WORKDIR /var/www/html
COPY index.php .

FROM nginx:alpine
COPY --from=0 /var/www/html /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
