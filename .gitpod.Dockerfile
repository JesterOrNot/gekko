FROM gitpod/workspace-full
ENV HOST localhost
ENV PORT 3000
RUN sudo mkdir -p /usr/src/app
WORKDIR /usr/src/app
RUN npm install -g --production node-gyp && \
    npm cache clean --force
COPY package.json .
RUN sudo npm install --production && \
    sudo npm install --production redis@0.10.0 talib@1.0.2 tulind@0.8.7 pg && \
    sudo npm cache clean --force
WORKDIR exchange
COPY exchange/package.json .
RUN npm install --production && \
    npm cache clean --force
WORKDIR ../
COPY . /usr/src/app
EXPOSE 3000
RUN chmod +x /usr/src/app/docker-entrypoint.sh \
    && sudo chown -hR /usr/src/app
