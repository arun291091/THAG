#!/bin/bash
sudo apt-get update -y
sudo apt install nginx -y
cat << EOF > index.html
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Hello, Nginx!</title>
</head>
<body>
    <h1>Hello, Talenthouse!</h1>
    <p>We have just configured our Nginx web server on Ubuntu Server!</p>
</body>
</html>
EOF

sudo cp -pr index.html /var/www/html


sudo sed -i s/80/443/g /etc/nginx/sites-enabled/default

sudo service nginx restart
