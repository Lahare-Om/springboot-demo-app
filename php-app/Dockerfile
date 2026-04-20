FROM php:8.2-cli-alpine
WORKDIR /app
COPY index.php router.php ./
EXPOSE 8080
CMD ["php", "-S", "0.0.0.0:8080", "router.php"]
