# FAQ

## What is APRSC?
APRSC is an APRS-IS server for core servers, handling APRS communications.

## How do I build the Docker image?
Run `docker-compose build` (or `docker build .`) from the project root.

## How do I configure APRSC?
Configuration is done via environment variables defined in the `docker-compose.yaml` file. These variables replace placeholders in `aprsc.conf.template` at runtime using `envsubst`.

## Which ports are exposed?
- **10152**: Fullfeed (TCP/UDP)
- **14580**: Igate (TCP/UDP)
- **8080**: UDP Submit (UDP) and HTTP Upload (TCP)
- **14501**: HTTP Status (TCP)

## Where are logs stored?
Logs are located in `/opt/aprsc/logs` inside the container.

## How do I update APRSC?
Rebuild the Docker image to pull in updates from the APRSC package repository.

## How can I contribute?
Check out [CONTRIBUTING.md](./CONTRIBUTING.md) for contribution guidelines.

## Who do I contact for support?
Open an issue on GitHub or refer to the email specified in the configuration (via `APRSC_MYEMAIL`).

## What base image is used?
The container is built on `debian:bookworm-slim`.
