ARG synapse_version=latest
FROM matrixdotorg/synapse:${synapse_version}

COPY homeserver.yaml /etc/matrix/homeserver.yaml
COPY irc-registration.yaml /etc/matrix/irc-registration.yaml
