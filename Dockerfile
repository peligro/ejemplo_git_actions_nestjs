# Base image
FROM node:20-alpine AS builder

# Create app directory
WORKDIR /usr/src/app

# Copy package files and prisma schema
COPY package*.json ./
COPY prisma ./prisma/

# Install all dependencies (including devDependencies for build)
RUN npm install

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Generate Prisma client
RUN npx prisma generate

# Production stage
FROM node:20-alpine AS production

# Install dependencies for production
RUN apk add --no-cache openssl

# Create app directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./
COPY prisma ./prisma/

# Install production dependencies only
RUN npm install --only=production

# Copy built application from builder stage
COPY --from=builder /usr/src/app/dist ./dist
COPY --from=builder /usr/src/app/node_modules/.prisma ./node_modules/.prisma

# Generate Prisma client
RUN npx prisma generate

# Expose port
EXPOSE 3000

# Start the application with migrations
CMD sh -c "npx prisma migrate deploy && npm run start:prod"