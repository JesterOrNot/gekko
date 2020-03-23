FROM gitpod/workspace-full
USER gitpod
SHELL [ "/usr/bin/sudo", "/bin/bash", "-cl" ]
ENV HOST localhost
ENV PORT 3000
RUN sudo mkdir -p /usr/src/app
WORKDIR /usr/src/app
RUN npm install -g --production node-gyp && \
    npm cache clean --force
COPY package.json .
RUN npm install --production && \
    npm install --production redis@0.10.0 talib@1.0.2 tulind@0.8.7 pg && \
    npm cache clean --force
WORKDIR exchange
COPY exchange/package.json .
RUN npm install --production && \
    npm cache clean --force
WORKDIR ../
COPY . /usr/src/app
RUN chmod +x /usr/src/app/docker-entrypoint.sh \
    && chown -hR /usr/src/app
