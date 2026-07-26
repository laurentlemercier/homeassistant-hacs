Automatically builds a container that can initialise install HACS in home assistant config directory.

Typical docker compose file provided in [[docker-compose.yml]].

```
services:
  hacs-init:
    image: laurentlemercier/homeassistant-hacs-init:latest
    container_name: homeassistant-init
    volumes:
      - /opt/homeassistant/config:/config
    restart: no
    network_mode: bridge
  homeassistant:
    image: homeassistant/home-assistant:latest
    container_name: homeassistant
    environment:
      - TZ=Europe/Paris
    ports:
      - 8123:8123
    volumes:
      - /opt/homeassistant/config:/config
      - /etc/localtime:/etc/localtime:ro
    restart: unless-stopped
    network_mode: bridge
    depends_on:
      hacs-init:
        condition: service_completed_successfully
networks: {}
```

Container homeassistant-init can be removed after first start.
