#!/bin/bash
apt-get update
apt-get install -y apache2

cat > /var/www/html/index.html << EOM
<!DOCTYPE html>
<html>
<body>

<h1>Hello World PH here at $(date +%F)</h1>

</body>
</html>
EOM

systemctl enable apache2
systemctl start apache2

curl http://localhost/
