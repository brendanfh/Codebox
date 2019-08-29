FROM openresty/openresty:xenial

RUN apt-get update \
	&& apt-get -y install openssl libssl-dev git \
	&& luarocks install lapis \
	&& luarocks install lapis-console \
	&& luarocks install moonscript \
	# && luarocks install openssl \
	# && luarocks install pgmoon \
	# && luarocks install ansicolors \
	# && luarocks install date \
	# && luarocks install etlua \
	# && luarocks install loadkit \
	# && luarocks install lpeg \
	# && luarocks install lua-cjson \
	# && luarocks install luaossl \
	# && luarocks install luafilesystem \
	# && luarocks install luasocket \
	# && luarocks install mimetypes \
	&& luarocks install luacrypto \
	&& luarocks install bcrypt

COPY codebox/ /app

ENV LAPIS_OPENRESTY "/opt/openresty/nginx/sbin/nginx"

EXPOSE 8888 80

WORKDIR /app
