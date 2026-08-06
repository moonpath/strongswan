# StrongSwan IKEv2 Server

```bash
git clone https://github.com/moonpath/strongswan.git
cd strongswan

export DOMAIN=$(hostname -f) # replace with your domain or ip
export USERNAME=username # replace with your username
export PASSWORD=password # replace with your password
export ENABLE_IPV6=false # set to true to enable the IPv6 pool

sudo docker compose up # add -d to run in background
```
