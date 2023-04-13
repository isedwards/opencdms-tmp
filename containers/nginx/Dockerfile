FROM nginx:latest

# Install Certbot and OpenSSL
RUN apt-get update \
    && apt-get install -y certbot python3-certbot-nginx openssl \
    && rm -rf /var/lib/apt/lists/*

# Create directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Generate self-signed certificates
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=US/ST=YourState/L=YourCity/O=YourOrganization/OU=YourDepartment/CN=api.opencdms.org"

# Copy the startup script
COPY nginx_startup.sh /usr/local/bin/

# Ensure the script is executable
RUN chmod +x /usr/local/bin/nginx_startup.sh
