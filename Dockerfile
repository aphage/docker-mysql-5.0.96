FROM ubuntu:22.04

RUN DEBIAN_FRONTEND=noninteractive \
    && sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list \
    && apt update \
    && apt install -y --no-install-recommends \
        openssl \
        libncursesw5 \
        gosu \
        bzip2 \
        perl \
        xz-utils \
        zstd; \
    rm -rf /var/lib/apt/lists/*; \
# verify that the binary works
	gosu nobody true

COPY mysql-5.0.96-linux-x86_64-glibc23 /usr/local/mysql

RUN groupadd mysql \
    && useradd -r -g mysql -s /bin/false mysql \
    && chown -R mysql:mysql /usr/local/mysql \
    && mkdir /docker-entrypoint-initdb.d \
    && mkdir -p /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
    # ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
	&& chmod 1777 /var/run/mysqld /var/lib/mysql

ENV PATH=/usr/local/mysql/bin:$PATH \
    MYSQL_MAJOR=5.0 \
    MYSQL_VERSION=5.0.96

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306 33060

CMD ["mysqld"]