# Stage 1: Build stage
FROM node:20.9.0 AS build
WORKDIR /facti/server
COPY package*.json ./
RUN npm ci
COPY . .
RUN npx prisma generate
RUN npm run build

# Stage 2: Production stage
FROM node:20.9.0
WORKDIR /facti/server
COPY --from=build /facti/server/node_modules ./node_modules
COPY --from=build /facti/server/dist ./dist
COPY --from=build /facti/server/package*.json ./
COPY --from=build /facti/server/prisma ./prisma
COPY --from=build /facti/server/.env ./

EXPOSE 3000
CMD [ "npm", "run", "start" ]