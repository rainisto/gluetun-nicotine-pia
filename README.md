# gluetun-nicotine-pia
Running nicotine+ behind gluetun with PIA. With Broadway as display server (port 9080, change in docker-compose file if needed) you can keep everything inside VPN environment without contaminating your normal internet usage.


# to run create .env file with following details:
PIA_USER=pia_username    
PIA_PASS=pia_pass    
VPN_REGION=vpn region for example "Estonia"    
DATA_PATH=optional data-path    
DOWNLOAD_PATH=optional download path    
CONFIG_PATH=optional config path    
NICO_USER=nicotine+ soulseek loginname    
NICO_PASS=nicotine+ soulseek password    

# and then start docker-compose with:
sudo docker-compose up -d    
