mkdir -p ~/data
conditional-get \
    --etags ~/data/etags.json \
    --output ~/data/cpad_2020a.zip \
    'https://data.cnra.ca.gov/dataset/0ae3cd9f-0612-4572-8862-9e9a1c41e659/resource/5de6b92d-0534-422f-816e-45dbc1c48104/download/cpad_2020a.zip'
