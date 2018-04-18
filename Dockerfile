FROM busybox
MAINTAINER Chris <c@crccheck.com>

WORKDIR /app

COPY . /app

ADD index.html /www/index.html

EXPOSE 8000

# Create a basic webserver and sleep forever
CMD httpd -p 8000 -h /www; tail -f /dev/null

