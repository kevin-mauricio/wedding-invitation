# Imagen base oficial de PHP con extensiones necesarias
FROM php:8.1

# Instala dependencias del sistema y extensiones de PHP requeridas por Laravel
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring gd

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia los archivos del proyecto al contenedor
COPY . .

# Asegura que Laravel tenga los directorios correctos
RUN mkdir -p bootstrap/cache storage/framework storage/logs \
    && chmod -R 775 bootstrap storage

# Instala las dependencias de Composer en modo producción
RUN composer install --no-dev --optimize-autoloader || composer diagnose || true

# Expone el puerto 80 para Render
EXPOSE 80

# Comando para iniciar el servidor PHP embebido apuntando a la carpeta "public"
CMD ["php", "-S", "0.0.0.0:80", "-t", "public"]
