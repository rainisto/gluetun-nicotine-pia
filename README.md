# gluetun-nicotine-pia
Running nicotine+ behind gluetun with PIA. With noVNC you can keep everything inside VPN environment without contaminating your normal internet usage.

# to run create .env file with following details:
PIA_USER=pia_username    
PIA_PASS=pia_pass    
VPN_REGION=vpn region for example "Estonia"    
VNC_PW=password    
DATA_PATH=optional data-path    
DOWNLOAD_PATH=optional download path    

# and then start docker-compose with:
sudo docker-compose up -d    
