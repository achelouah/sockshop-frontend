FROM mhart/alpine-node:6.3

ARG HTTP_PROXY=http://10.200.220.66:3128
ARG HTTPS_PROXY=http://10.200.220.66:3128

ENV NODE_ENV="production" \
    PORT=8079

EXPOSE 8079
RUN addgroup mygroup && adduser -D -G mygroup myuser && mkdir -p /usr/src/app && chown -R myuser /usr/src/app
USER myuser

# Prepare app directory
WORKDIR /usr/src/app
COPY package.json /usr/src/app/
RUN npm config set registry http://si-nexus-forge-rec.pcy.edf.fr/repository/npm/ \
	&& npm config set proxy ${HTTP_PROXY} \
	&& npm config set https-proxy ${HTTPS_PROXY} \
	&& npm config set no-proxy .edf.fr \
	&& npm install

COPY . /usr/src/app

# Start the app
CMD ["npm", "start"]
