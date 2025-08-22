# Base image
FROM node:20-alpine AS builder

# Create app directory
WORKDIR /usr/src/app

# Copy package files and prisma schema
COPY package*.json ./
COPY prisma ./prisma/

# Install all dependencies (including devDependencies for build)
RUN npm install

# Copy source code (INCLUYENDO assets)
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

# Copy built application from builder stage (INCLUYENDO assets)
COPY --from=builder /usr/src/app/dist ./dist
COPY --from=builder /usr/src/app/node_modules/.prisma ./node_modules/.prisma
#COPY --from=builder /usr/src/app/assets ./assets  

# Verifica que los archivos se copiaron correctamente
#RUN echo "=== Verificando assets ===" && ls -la /usr/src/app/assets/ && echo "=== Verificando index.html ===" && ls -la /usr/src/app/assets/index.html && echo "=== Contenido de uploads ===" && ls -la /usr/src/app/assets/uploads/ || echo "Uploads directory exists"

# Generate Prisma client
RUN npx prisma generate

# Expose port
EXPOSE 3000

# Start the application with migrations
CMD sh -c "npx prisma migrate deploy && npm run start:prod"