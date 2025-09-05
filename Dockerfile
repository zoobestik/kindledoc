FROM pandoc/extra

# Install fontconfig if not already installed
RUN apk add --no-cache fontconfig

RUN apk add --no-cache \
    python3 py3-pygments \
    ttf-dejavu \
    font-noto-emoji

RUN tlmgr update --self
RUN tlmgr install fontspec luaotfload soul adjustbox babel-german background bidi \
    collectbox csquotes everypage filehook footmisc footnotebackref \
    framed fvextra letltxmacro ly1 mdframed mweights needspace pagecolor \
    titling ucharcat unicode-math upquote xecjk xurl zref draftwatermark minted emoji enumitem

# Copy your custom TTF fonts
COPY fonts/*.ttf /usr/local/share/fonts/
COPY fonts/Apple*.ttc /usr/share/fonts/truetype/apple/

# Create fontconfig cache directories and give them proper permissions,
# then force-rebuild the font cache
RUN mkdir -p /var/cache/fontconfig /root/.cache/fontconfig \
    && chmod 0777 /var/cache/fontconfig /root/.cache/fontconfig

# Update font cache
RUN fc-cache -f -v
