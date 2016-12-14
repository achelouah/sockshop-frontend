FROM mhart/alpine-node:6.3

ARG LAFORGE_PROXY=http://10.200.220.66:3128

ENV NODE_ENV="production" \
    PORT=8079

EXPOSE 8079
RUN addgroup mygroup && adduser -D -G mygroup myuser && mkdir -p /usr/src/app && chown -R myuser /usr/src/app
USER myuser

# Prepare app directory
WORKDIR /usr/src/app
COPY package.json /usr/src/app/
RUN npm config set registry http://si-nexus-forge-rec.pcy.edf.fr/repository/npm/ \
	&& npm config set proxy ${LAFORGE_PROXY} \
	&& npm config set https-proxy ${LAFORGE_PROXY} \
	&& npm config set no-proxy .edf.fr \
	&& npm install \
	&& npm config rm proxy \
	&& npm config rm https-proxy \
	&& npm config rm no-proxy \
	&& unset HTTP_PROXY \
	&& unset HTTPS_PROXY \
	&& unset http_proxy \
	&& unset https_proxy

COPY . /usr/src/app

# Start the app
CMD ["npm", "start"]
