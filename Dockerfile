FROM alpine:3.7

ENV ROOT_PASSWORD root

COPY rootfs/apk_cn_repositories /etc/apk/repositories

RUN apk add --no-cache openssh \
		&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
		&& echo "root:${ROOT_PASSWORD}" | chpasswd \
		&& rm -rf /var/cache/apk/* /tmp/*

RUN apk add --no-cache vim 'tmux>2.7'

COPY rootfs/entrypoint.sh /usr/local/bin/

EXPOSE 22

ENTRYPOINT ["entrypoint.sh"]
