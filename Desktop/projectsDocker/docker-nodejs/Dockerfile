FROM node:22
WORKDIR /app
COPY server.js .
COPY package.json .
 
RUN npm install
CMD ["node", "server.js"]