mkdir -p ~/data
conditional-get \
    --etags ~/data/etags.json \
    --output ~/data/cpad_2020a.zip \
    'https://static.simonwillison.net/static/2021/CPAD_2020a.zip'
