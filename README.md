# Abdullah Azzam portfolio

Static portfolio page served by NGINX in Docker Compose, with the VPS NGINX
acting as the public reverse proxy. Downloadable files are stored in the
`downloads/` directory on the VPS and mounted read-only into the container.

## Start the app

```sh
docker compose up --build -d
```

The container listens on `127.0.0.1:8080` on the VPS, so it is reachable by the
local NGINX service and is not exposed directly to the internet. The Compose
bind mount at `./downloads` keeps app downloads persistent across container
rebuilds and restarts.

## Configure NGINX on the VPS

Copy `nginx-vps.conf` to `/etc/nginx/sites-available/aazzam.my.id`, then enable
it and reload NGINX:

```sh
sudo ln -s /etc/nginx/sites-available/aazzam.my.id /etc/nginx/sites-enabled/aazzam.my.id
sudo nginx -t
sudo systemctl reload nginx
```

The config proxies `aazzam.my.id` to the Compose app on `127.0.0.1:8080`. Point
an `A` record for that name to the VPS public IPv4 address (and add an `AAAA`
record too if the VPS has public IPv6).

To enable HTTPS with Certbot on Ubuntu/Debian, first make sure DNS is resolving
to the VPS and ports 80 and 443 are open, then run:

```sh
sudo certbot --nginx -d aazzam.my.id
```

## Update app listings

Edit the sample app cards and replace their `href` values in `index.html` with
your actual store pages or downloadable files. Replace the contact email if you
use a different address.
