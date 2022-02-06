echo Please run ipfs daemon or setup the service
set -o xtrace # Show the commands like bat files do
# sudo pacman -S go-ipfs
# ipfs init
# get the key

# Git no support hard links
# symlinks dont work with ipfs as of writing
if [ ! -f "publishlinked/index.html" ]; then # if not already linked
ln index.html publishlinked/
fi
if [ ! -f "publishlinked/favicon.ico" ]; then # if not already linked
ln favicon.ico publishlinked/
fi

s=$(bash -c "ipfs add -r publishlinked | grep -v /")
ss=($s)
sss=${ss[1]}
echo $sss
# ipfs daemon & # Does not work if already running
ipfs name publish --key=GitKey $sss
echo Remember to pin to pinata before you close the dev environment

# Add to pinata for quick clouflare link
#. ./secrets.sh
#curl -X POST -H "Content-Type: multipart/form-data; pinata_api_key: \"$PIN_KEY\"; pinata_secret_api_key: \"$PIN_SEC\"" -d "{hashToPin: $sss}" https://api.pinata.cloud/pinning/pinByHash

# Getting Close
# curl --location --request POST 'https://api.pinata.cloud/pinning/pinByHash' \
# --header "'pinata_api_key: $PIN_KEY'" \
# --header "'pinata_secret_api_key: $PIN_SEC'" \
# --header 'Content-Type: application/json' \
# --data-raw "'{
#     "hashToPin": "$sss",
#     "pinataMetadata": {
#         "name": "postedfolder"
#     }
# }'"
