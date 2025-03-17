# APRSC Docker Container

This repo builds and runs APRSC (an APRS-IS server for core servers) on Debian 12 Bookworm Slim using docker and docker-compose. It supports dynamic configuration via environment variables.

## Features

- **Build APRSC from source** on Debian 12 Bookworm Slim.
- **Configure APRSC dynamically** by setting environment variables.
- **Easy deployment** with Docker & docker-compose.

## Files

- **Dockerfile**: Installs dependencies, builds APRSC, and sets up the config template.
- **docker-compose.yaml**: Defines the container, ports, and environment variables.
- **entrypoint.sh**: Uses `envsubst` to convert the config template into the active configuration.
- **aprsc.conf.template**: APRSC config with placeholders for environment variables.

## Using the Docker Hub Image

If you prefer not to build from source, you can use the pre-built image available on Docker Hub:
https://hub.docker.com/repository/docker/backburn/aprsc-docker

```bash
docker pull backburn/aprsc-docker:latest
docker run -d \
  --name aprsc \
  -p 10152:10152 \
  -p 10152:10152/udp \
  -p 14580:14580 \
  -p 14580:14580/udp \
  -p 8080:8080 \
  -p 8080:8080/udp \
  -p 14501:14501 \
  -e APRSC_SERVERID="NOCALL" \
  -e APRSC_PASSCODE="0" \
  -e APRSC_MYADMIN="My Name, MYCALL" \
  -e APRSC_MYEMAIL="email@example.com" \
  -e APRSC_LISTEN_FULLFEED_NAME="Full feed" \
  -e APRSC_LISTEN_FULLFEED_ADDR="::" \
  -e APRSC_LISTEN_FULLFEED_PORT="10152" \
  -e APRSC_LISTEN_FULLFEED_OPTIONS="hidden" \
  -e APRSC_LISTEN_FULLFEED_UDP_PORT="10152" \
  -e APRSC_LISTEN_FULLFEED_UDP_OPTIONS="hidden" \
  -e APRSC_LISTEN_IGATE_NAME="Client-Defined Filters" \
  -e APRSC_LISTEN_IGATE_ADDR="::" \
  -e APRSC_LISTEN_IGATE_PORT="14580" \
  -e APRSC_LISTEN_IGATE_UDP_PORT="14580" \
  -e APRSC_LISTEN_UDPSUBMIT_NAME="UDP submit" \
  -e APRSC_LISTEN_UDPSUBMIT_PORT="8080" \
  -e APRSC_UPLINK_NAME="Core rotate" \
  -e APRSC_UPLINK_TYPE="full" \
  -e APRSC_UPLINK_ADDR="rotate.aprs.net" \
  -e APRSC_UPLINK_PORT="10152" \
  -e APRSC_UPLINK_BIND_IPV4="127.0.0.1" \
  -e APRSC_UPLINK_BIND_IPV6="::1" \
  -e APRSC_HTTPSTATUS_ADDR="0.0.0.0" \
  -e APRSC_HTTPSTATUS_PORT="14501" \
  -e APRSC_HTTPUPLOAD_ADDR="0.0.0.0" \
  -e APRSC_HTTPUPLOAD_PORT="8080" \
  backburn/aprsc-docker:latest
```

## Setup

1. **Clone the repo:**
   ```bash
   git clone git@github.com:brandonjank/aprsc-docker.git
   cd aprsc-docker
   ```

2. **Customize** any environment variables in `docker-compose.yaml` as needed.

3. **Build the image:**
   ```bash
   docker-compose build
   ```

4. **Run the container:**
   ```bash
   docker-compose up -d
   ```

## Configuration

APRSC is configured using environment variables defined in `docker-compose.yaml`. Here’s a list of the main variables with their defaults:

- `APRSC_SERVERID`: `"NOCALL"`
- `APRSC_PASSCODE`: `"0"`
- `APRSC_MYADMIN`: `"My Name, MYCALL"`
- `APRSC_MYEMAIL`: `"email@example.com"`
- `APRSC_RUNDIR`: `"data"`
- `APRSC_LOGROTATE_SIZE`: `"10"`
- `APRSC_LOGROTATE_COUNT`: `"5"`
- `APRSC_UPSTREAM_TIMEOUT`: `"15s"`
- `APRSC_CLIENT_TIMEOUT`: `"48h"`
- `APRSC_LISTEN_FULLFEED_NAME`: `"Full feed"`
- `APRSC_LISTEN_FULLFEED_ADDR`: `"::"`
- `APRSC_LISTEN_FULLFEED_PORT`: `"10152"`
- `APRSC_LISTEN_FULLFEED_OPTIONS`: `"hidden"`
- `APRSC_LISTEN_FULLFEED_UDP_NAME`: `""`
- `APRSC_LISTEN_FULLFEED_UDP_ADDR`: `"::"`
- `APRSC_LISTEN_FULLFEED_UDP_PORT`: `"10152"`
- `APRSC_LISTEN_FULLFEED_UDP_OPTIONS`: `"hidden"`
- `APRSC_LISTEN_IGATE_NAME`: `"Client-Defined Filters"`
- `APRSC_LISTEN_IGATE_ADDR`: `"::"`
- `APRSC_LISTEN_IGATE_PORT`: `"14580"`
- `APRSC_LISTEN_IGATE_UDP_NAME`: `""`
- `APRSC_LISTEN_IGATE_UDP_ADDR`: `"::"`
- `APRSC_LISTEN_IGATE_UDP_PORT`: `"14580"`
- `APRSC_LISTEN_UDPSUBMIT_NAME`: `"UDP submit"`
- `APRSC_LISTEN_UDPSUBMIT_ADDR`: `"::"`
- `APRSC_LISTEN_UDPSUBMIT_PORT`: `"8080"`
- `APRSC_UPLINK_NAME`: `"Core rotate"`
- `APRSC_UPLINK_TYPE`: `"full"`
- `APRSC_UPLINK_ADDR`: `"rotate.aprs.net"`
- `APRSC_UPLINK_PORT`: `"10152"`
- `APRSC_UPLINK_BIND_IPV4`: `"127.0.0.1"`
- `APRSC_UPLINK_BIND_IPV6`: `"::1"`
- `APRSC_HTTPSTATUS_ADDR`: `"0.0.0.0"`
- `APRSC_HTTPSTATUS_PORT`: `"14501"`
- `APRSC_HTTPUPLOAD_ADDR`: `"0.0.0.0"`
- `APRSC_HTTPUPLOAD_PORT`: `"8080"`
- `APRSC_FILELIMIT`: `"10000"`

For the full list, see the [aprsc.conf.template](./aprsc.conf.template).

## References

- [APRSC Installation Guide](http://he.fi/aprsc/INSTALLING.html)
- [APRSC Configuration Guide](http://he.fi/aprsc/CONFIGURATION.html)

## License

This project is licensed under the GNU GPL v3 License.
