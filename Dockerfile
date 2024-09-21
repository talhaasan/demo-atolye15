# Base image
FROM node:14-alpine

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and yarn.lock to install dependencies
COPY package.json yarn.lock ./

# Install dependencies, ignoring optional packages
RUN yarn --production --ignore-optional

# Copy all application files
COPY . .

# Expose the port on which the app will run
EXPOSE 3000

# Start the application
CMD ["yarn", "start:prod"]