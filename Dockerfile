FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/index.html
RUN mkdir -p /tmp/client_temp /tmp/proxy_temp \
    && chown -R nginx:nginx /tmp/client_temp /tmp/proxy_temp

EXPOSE 8080

USER nginx
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
