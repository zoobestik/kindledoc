FROM pandoc/extra

# Install fontconfig if not already installed
RUN apk add --no-cache fontconfig

# Create fonts directory if it doesn't exist
RUN mkdir -p /usr/share/fonts/truetype/custom

# Copy your custom TTF fonts
COPY fonts/*.ttf /usr/local/share/fonts/


# Create fontconfig cache directories and give them proper permissions,
# then force-rebuild the font cache
RUN mkdir -p /var/cache/fontconfig /root/.cache/fontconfig \
    && chmod 0777 /var/cache/fontconfig /root/.cache/fontconfig

# Update font cache
RUN fc-cache -f -v
