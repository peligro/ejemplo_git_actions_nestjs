# Base image
FROM node:20-alpine AS development

# Create app directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./
COPY prisma ./prisma/

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build the application
RUN npm run build

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

# Copy built application from development stage
COPY --from=development /usr/src/app/dist ./dist

# Generate Prisma client
RUN npx prisma generate

# Expose port
EXPOSE 3000

# Start the application
CMD ["npm", "run", "start:prod"]