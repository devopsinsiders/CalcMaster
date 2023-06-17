# Stage 1: Build React application
FROM node:16.17.1-alpine3.15 as build

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the React application
RUN npm run build

RUN cd ./build
RUN ls

# Stage 2: Serve the built React application using Nginx
FROM nginx

# Copy the built React application from the build stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80
