mkdir -p ~/data
conditional-get \
    --etags ~/data/etags.json \
    --output ~/data/cpad_2020a.zip \
    'https://data.cnra.ca.gov/dataset/0ae3cd9f-0612-4572-8862-9e9a1c41e659/resource/2f5efcf0-dffa-4890-92a8-3df3589f0e50/download/cpad_2020b.zip'
