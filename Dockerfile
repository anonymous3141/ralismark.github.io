FROM starefossen/github-pages:latest
RUN gem install jekyll-local-theme

ENV APPDIR /app
ENV SRVDIR /srv
WORKDIR $SRVDIR

ENV JEKYLL_ENV=development
EXPOSE "4000"
ENTRYPOINT jekyll serve \
	--host 0.0.0.0 --port 4000 -s $APPDIR -d $SRVDIR \
	--config $APPDIR/_config.yml,$APPDIR/_config-dev.yml \
	--watch --force_polling
