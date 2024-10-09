FROM node:22.9.0
ENV NODE_ENV=production
WORKDIR /usr/src/app
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm install --production --silent && mv node_modules ../
RUN npm run build
FROM builder AS test
RUN npm run test
COPY . .
EXPOSE 7000
RUN chown -R node /usr/src/app
USER node
CMD ["node", "index.js"]
