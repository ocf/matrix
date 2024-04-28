FROM docker.io/vectorim/element-web:latest AS element
RUN rm -rf /app/themes/riot/
COPY /branding/themes/riot/ /app/themes/riot/
RUN rm -f /app/welcome/images/logo.svg
COPY /branding/themes/riot/img/logos/riot-im-logo.svg /app/welcome/images/logo.svg
