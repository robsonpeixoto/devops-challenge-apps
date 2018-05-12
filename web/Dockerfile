FROM node:latest
MAINTAINER Raphael Neumann <raphael@rneumann.me>

# Define app dir
WORKDIR /app

# Install dependencies before to use advantage of layer caching
COPY package.json package.json
RUN npm install

# Copy all application files to container
COPY . .

# Set Args
ARG WEB_PORT=5000
ARG API_HOST

# Export port will be used by application
EXPOSE $WEB_PORT

# Define environments
ENV PORT=$WEB_PORT
ENV API_HOST=$API_HOST

CMD ["npm", "start" ]
