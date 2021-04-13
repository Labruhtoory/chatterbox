#!/bin/bash
#edit nginx
read -p "What is your website domain name? (EX: mydomain.com)> " domain
sed -i "s+$domain+_+gi" /etc/nginx/sites-available/default
systemctl restart nginx
echo "In a separate terminal, if you have not already done so, "
echo "Run the following command to get an ssl cert for your domain: "
echo "sudo certbot --nginx"
echo ""
echo "press 'c' to continue....."
while : ; do
read -n 1 k <&1
if [[ $k = c ]] ; then
echo ""
printf "Ok then, moving on....."
break
fi
done
mv template-ssl/serv.conf /etc/nginx/conf.d/
sed -i "s+$domain+mydomain.dns+gi" /etc/nginx/conf.d/serv.conf
systemctl restart nginx
echo ""
echo ""
echo ""
read -p "What is the /path/to/chatterbox folder? (EX: /var/www/chatterbox)> " mainloc
read -p "What it the /path/to/ssl/cert? (EX: /etc/letsencrypt/domain/fullhain.pem)> " certloc
read -p "What it the /path/to/ssl/cert? (EX: /etc/letsencrypt/domain/privkey.pem)> " keyloc
#main.go public folder edits
echo "Editing public folder paths"
sed -i "s+$mainloc/chat-blue/public+../public+gi" chat-blue/src/main.go
sed -i "s+$mainloc/chat-red/public+../public+gi" chat-red/src/main.go
sed -i "s+$mainloc/chat-green/public+../public+gi" chat-green/src/main.go
sed -i "s+$mainloc/chat-orange/public+../public+gi" chat-orange/src/main.go
sed -i "s+$mainloc/chat-blue-ssl/public+../public+gi" chat-blue-ssl/src/main.go
sed -i "s+$mainloc/chat-red-ssl/public+../public+gi" chat-red-ssl/src/main.go
sed -i "s+$mainloc/chat-green-ssl/public+../public+gi" chat-green-ssl/src/main.go
sed -i "s+$mainloc/chat-orange-ssl/public+../public+gi" chat-orange-ssl/src/main.go
#main.go ssl cert path edits
echo "Editing ssl cert folder paths"
sed -i "s+$certloc+/full/path/to/cert+gi" chat-blue-ssl/src/main.go
sed -i "s+$certloc+/full/path/to/cert+gi" chat-red-ssl/src/main.go
sed -i "s+$certloc+/full/path/to/cert+gi" chat-green-ssl/src/main.go
sed -i "s+$certloc+/full/path/to/cert+gi" chat-orange-ssl/src/main.go
#main.go ssl key path edits
echo "Editing ssl key folder paths"
sed -i "s+$keyloc+/full/path/to/certkey+gi" chat-blue-ssl/src/main.go
sed -i "s+$keyloc+/full/path/to/certkey+gi" chat-red-ssl/src/main.go
sed -i "s+$keyloc+/full/path/to/certkey+gi" chat-green-ssl/src/main.go
sed -i "s+$keyloc+/full/path/to/certkey+gi" chat-orange-ssl/src/main.go
# double check
echo "Have you made the necessary changes to all src/main.go files?"
echo "If not, then you should review the note files in the templates."
echo "press 'Ctrl + c' twice to quit....."
echo "If so, then press 'c' to continue....."
while : ; do
read -n 1 k <&1
if [[ $k = c ]] ; then
echo ""
printf "Ok then, moving on....."
break
fi
done
#build & make services 
sudo cp services/* /etc/systemd/system/
sudo mkdir /opt/chats
sudo go build -o /opt/chats/chat1 chat-blue/src/main.go
sudo go build -o /opt/chats/chat2 chat-red/src/main.go
sudo go build -o /opt/chats/chat3 chat-green/src/main.go
sudo go build -o /opt/chats/chat4 chat-orange/src/main.go
sudo go build -o /opt/chats/chat5 chat-blue-ssl/src/main.go
sudo go build -o /opt/chats/chat6 chat-red-ssl/src/main.go
sudo go build -o /opt/chats/chat7 chat-green-ssl/src/main.go
sudo go build -o /opt/chats/chat8 chat-orange-ssl/src/main.go
sudo systemctl enable chat1
sudo systemctl enable chat2
sudo systemctl enable chat3
sudo systemctl enable chat4
sudo systemctl enable chat5
sudo systemctl enable chat6
sudo systemctl enable chat7
sudo systemctl enable chat8
sudo systemctl start chat1
sudo systemctl start chat2
sudo systemctl start chat3
sudo systemctl start chat4
sudo systemctl start chat5
sudo systemctl start chat6
sudo systemctl start chat7
sudo systemctl start chat8