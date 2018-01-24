apt update
apt upgrade
URL=https://github.com/docker/compose/releases/download/1.17.0/
curl -L ${URL}/"docker-compose-$(uname -s)-$(uname -m)" -o docker-compose
sudo cp docker-compose /usr/local/bin/docker-compose
sudo chmod a+x /usr/local/bin/docker-compose
rm -f docker-compose
sudo mkdir -p /var/lib/some-redmine/sqlite
sudo mkdir -p /var/lib/some-redmine/files
sudo mkdir -p /var/lib/some-redmine/plugins
sudo mkdir -p /var/lib/some-redmine/vendor/plugins
sudo mkdir -p /var/lib/some-redmine/public/themes
mkdir redmine-sqlite
cd redmine-sqlite
cat <<EOF > redmine-sqlite.yml
version: '3.0'
services:
  some-redmine:
    image:
      redmine:latest
    restart:
      always
    ports:
      - 80:3000
    volumes:
      - /var/lib/some-redmine/sqlite:/usr/src/redmine/sqlite
      - /var/lib/some-redmine/files:/usr/src/redmine/files
      - /var/lib/some-redmine/plugins:/usr/src/redmine/plugins
      - /var/lib/some-redmine/vendor/plugins:/usr/src/redmine/vendor/plugins
      - /var/lib/some-redmine/public/themes:/usr/src/redmine/public/themes
EOF
docker-compose -f redmine-sqlite.yml up

