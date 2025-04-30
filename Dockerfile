# Usa una imagen oficial de PHP como base
FROM php:8.1-cli

# Instalar las dependencias necesarias
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip git && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd pdo pdo_mysql

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el código del proyecto en el contenedor
COPY . .

# Instalar las dependencias de Laravel
# RUN composer install --no-dev --optimize-autoloader
RUN composer install --no-dev --optimize-autoloader || { cat /app/storage/logs/laravel.log || true; exit 1; }


# Exponer el puerto en el que se ejecutará el servidor
EXPOSE 80

# Iniciar el servidor PHP embebido
CMD ["php", "-S", "0.0.0.0:80", "-t", "public"]
