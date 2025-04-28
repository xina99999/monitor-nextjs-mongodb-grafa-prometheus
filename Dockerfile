# Dockerfile

# Base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy dependencies
COPY package*.json ./

# Install deps
RUN npm install --frozen-lockfile

# Copy source code
COPY . .

# Build app
RUN npm run build && ls -alh /app/.next

# Expose port
EXPOSE 3000

# Start app
CMD ["npm", "start"]
