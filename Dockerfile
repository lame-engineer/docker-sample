FROM node AS builder
WORKDIR /app
# Copy files 
COPY . .
# install node modules
RUN yarn install && yarn build

# nginx alpine
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
# Remove default nginx static assets
RUN rm -rf ./*
# Copy static assets
COPY --from=builder /app/build .
# Containers run nginx with global directives and daemon off
EXPOSE  80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
