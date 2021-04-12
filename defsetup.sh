#!/bin/bash

echo "Have you made the necessary changes to all src/main.go files?"
echo "If not, then you should revive the note files in the templates."
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