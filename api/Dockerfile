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
ARG API_PORT=3000
ARG API_DB

# Export port will be used by application
EXPOSE $API_PORT

# Define environments
ENV PORT=$API_PORT
ENV DB=$API_DB

CMD ["npm", "start" ]
