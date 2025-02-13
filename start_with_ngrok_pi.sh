
#!/bin/bash                                                                                sngrok.sh                                                                                                  
echo "--------- 🟢 Start Docker compose down  -----------"
sudo -E docker compose down
echo "--------- 🔴 Finish Docker compose down -----------"
echo "--------- 🟢 Start Ngrok setup -----------"
wget -O ngrok.tgz https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz
sudo tar xvzf ./ngrok.tgz -C /usr/local/bin
sudo apt install -y jq
echo "🔴🔴🔴 Please login into ngrok.com and paste your token and static URL here:"
export token="2sx36nSXbvo2J4gCU5rXwsYsvWW_3uuem4dszSAhrW2ZAkAPU"
export domain="wrongly-tolerant-humpback.ngrok-free.app"
ngrok config add-authtoken $token
ngrok http --url=$domain 5678 > /dev/null &
echo "🔴🔴🔴 Please wait Ngrok to start...."
sleep 8
export EXTERNAL_IP="$(curl http://localhost:4040/api/tunnels | jq ".tunnels[0].public_url")"
echo Got Ngrok URL = $EXTERNAL_IP
echo "--------- 🔴 Finish Ngrok setup -----------"
echo "--------- 🟢 Start Docker compose up  -----------"
sudo -E docker compose up -d
echo "--------- 🔴 Finish! Wait a few minutes and test in browser at url $EXTERNAL_IP for n8n UI -----------"
