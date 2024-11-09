# frontend/Dockerfile
FROM node:12.14.0-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .


FROM nginx:alpine
COPY --from=build /app/target/classes/static/built /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]