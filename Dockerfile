# Imagen base con PHP 8.2 y extensiones necesarias para Laravel
FROM php:8.2

# Instala dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    sqlite3 \
    libsqlite3-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_sqlite mbstring gd

# Instala Composer globalmente
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

# Crea el directorio de la app
WORKDIR /app

# Copia el contenido del proyecto Laravel
COPY . .

# Asegura que estas carpetas existan y tengan permisos correctos
RUN mkdir -p bootstrap/cache storage/framework storage/logs database \
    && touch database/database.sqlite \
    && chmod -R 775 bootstrap storage database

# Copia el archivo .env.example si .env no existe
RUN [ -f .env ] || cp .env.example .env

# Instala dependencias de Composer en modo producción
RUN composer install --no-dev --optimize-autoloader

# Genera la clave de aplicación
RUN php artisan key:generate

# Expone el puerto 80
EXPOSE 80

# Comando para iniciar Laravel con el servidor embebido de PHP
CMD php artisan migrate --force && php -S 0.0.0.0:80 -t public public/index.php

