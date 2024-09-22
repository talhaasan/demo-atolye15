# Base image
FROM node:14-alpine AS builder

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and yarn.lock to install dependencies
COPY package.json yarn.lock ./

# Install all dependencies (including dev dependencies)
RUN yarn install --frozen-lockfile

# Copy all application files
COPY . .

# Build the NestJS app (this compiles the TypeScript files to JavaScript)
RUN yarn build

# Start a new stage from the base image
FROM node:14-alpine

# Set the working directory
WORKDIR /usr/src/app

# Copy only the production dependencies
COPY package.json yarn.lock ./
RUN yarn install --production --frozen-lockfile --ignore-optional

# Copy the compiled files from the build stage
COPY --from=builder /usr/src/app/dist ./dist

# Expose the port on which the app will run
EXPOSE 3000

# Start the application
CMD ["yarn", "start:prod"]