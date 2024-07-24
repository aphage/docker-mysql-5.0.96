# mysql-dockerfile

## build

```sh
sudo docker build -t mysql:5.0.96 -f Dockerfile .
```

## run
```sh
sudo docker run --rm -it \
-e MYSQL_ROOT_PASSWORD=root \
-e MYSQL_USER=game \
-e MYSQL_PASSWORD=123456 \
-e MYSQL_USER_GRANTS_ALL=true \
--user="$(id -u)":"$(id -g)" \
--mount type=bind,source="$(pwd)"/docker-entrypoint-initdb.d,target=/docker-entrypoint-initdb.d \
--mount type=bind,src="$(pwd)"/mysql,target=/var/lib/mysql \
--mount type=bind,src="$(pwd)"/my.cnf,target=/etc/my.cnf \
mysql:5.0.96
```

## Environment Variables

- `MYSQL_ROOT_HOST`
The host used to connect to the MySQL server. Defaults to "%".
- `MYSQL_ROOT_PASSWORD`
The password for the MySQL root account.
- `MYSQL_USER`, `MYSQL_PASSWORD`
The username and password for the MySQL user.
- `MYSQL_DATABASE`
This variable is optional and allows you to specify the name of a database to be created on image startup.
If a user/password was supplied then that user will be granted superuser access to this database.
- `MYSQL_USER_GRANTS_ALL`
Whether to grant all privileges to the user. Defaults to "no".
- `MYSQL_RANDOM_ROOT_PASSWORD`
This is an optional variable. Set to a non-empty value, like yes, to generate a random initial password for the root user (using pwgen). The generated root password will be printed to stdout (GENERATED ROOT PASSWORD: .....).

## References

- https://hub.docker.com/_/mysql