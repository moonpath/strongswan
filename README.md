# StrongSwan IKEv2 Server

```bash
git clone https://github.com/moonpath/strongswan.git
cd strongswan

export DOMAIN=$(hostname -f) # replace with your domain or ip
export USERNAME=username # replace with your username
export PASSWORD=password # replace with your password

sudo docker compose up # add -d to run in background
```
