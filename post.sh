echo Please run ipfs daemon or setup the service
set -o xtrace # Show the commands like bat files do
# sudo pacman -S go-ipfs
# ipfs init
# get the key

# Git no support hard links
# symlinks dont work with ipfs as of writing
mkdir -p ./publishlinked/
if cmp --silent -- "./publishlinked/index.html" "./index.html"; then
echo index.html already linked
else
rm ./publishlinked/index.html
ln index.html publishlinked/
fi
if cmp --silent -- "./publishlinked/favicon.ico" "./favicon.ico"; then
echo favicon.ico already linked
else
rm ./publishlinked/favicon.ico
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
