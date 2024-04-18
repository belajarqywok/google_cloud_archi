FROM php:7.4-apache

LABEL creator="al-fariqy raihan"

LABEL twitter="@FariqyAl"
LABEL github="@belajarqywok"
LABEL instagram="@otw.mastah"
LABEL email="alfariqyraihan@gmail.com"

WORKDIR /var/www/html

COPY . .

RUN apt-get update && \
    apt-get install -y libpng-dev

EXPOSE 80

CMD ["apache2-foreground"]
