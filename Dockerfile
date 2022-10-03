FROM bloben/nginx:latest

ARG DOCKER_IMAGE_VERSION
ENV DOCKER_IMAGE_VERSION=$DOCKER_IMAGE_VERSION
# api port
ENV PORT=8081
ENV NODE_ENV=production
ENV HOST=localhost

COPY --from=bloben/admin:latest ./usr/app/admin ./usr/app/admin/
COPY --from=bloben/calendar:latest ./usr/app/calendar ./usr/app/calendar/
COPY --from=bloben/api:latest ./usr/app/api/ ./usr/app/api/
COPY --from=bloben/tasks:latest ./usr/app/tasks/ ./usr/app/tasks/

COPY nginx/init.sh /bin/
RUN chmod u+x /bin/init.sh

COPY /nginx/nginx.conf /etc/nginx

CMD /bin/init.sh
