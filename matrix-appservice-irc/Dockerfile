ARG bridge_version=latest
FROM matrixdotorg/matrix-appservice-irc:${bridge_version}

COPY config.yaml /data/config.yaml
COPY irc-registration.yaml /data/appservice-registration-irc.yaml
COPY tempkey.pem /data/passkey.pem
