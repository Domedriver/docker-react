FROM node:16-alpine as builder
RUN mkdir -p /home/node/app && chown node:node /home/node/app
WORKDIR /home/node/app
USER node
COPY --chown=node:node . .
# COPY --chown=node:node package.json ./
RUN npm install
# COPY --chown=node:node . .
RUN npm run build

FROM nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html
