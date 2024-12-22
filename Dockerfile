# Stage 1: Build
FROM node:21 AS build
WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json* ./
RUN npm install

# Copy the rest of the code and build
COPY . ./
RUN npm run build

# Stage 2: Serve
FROM nginx:stable-alpine
COPY --from=build /app/dist /usr/share/nginx/html

# Expose the default NGINX port
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
