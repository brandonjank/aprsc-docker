FROM debian:bookworm-slim

# Install requirements
RUN apt-get update && apt-get install -y gnupg

# add signing key and deb source, install aprsc
RUN gpg --keyserver keyserver.ubuntu.com --recv-keys C51AA22389B5B74C3896EF3CA72A581E657A2B8D && \
    gpg --export C51AA22389B5B74C3896EF3CA72A581E657A2B8D > /etc/apt/trusted.gpg.d/aprsc.gpg && \
    chown root:root /etc/apt/trusted.gpg.d/aprsc.gpg && chmod 644 /etc/apt/trusted.gpg.d/aprsc.gpg && \
    echo "deb [signed-by=/etc/apt/trusted.gpg.d/aprsc.gpg] http://aprsc-dist.he.fi/aprsc/apt $(cat /etc/os-release | grep VERSION_CODENAME | awk '{gsub("VERSION_CODENAME=", "");print}') main" > /etc/apt/sources.list.d/aprsc.list && \
    apt-get update && \
    apt-get install -y aprsc


# Create config directory and copy the template config file
# The config file will be generated at runtime by replacing the environment variables in the template
RUN mkdir -p /opt/aprsc
RUN mkdir -p /opt/aprsc/logs
RUN mkdir -p /opt/aprsc/data
COPY aprsc.conf.template /opt/aprsc/aprsc.conf.template

# Simple entrypoint to replace environment vars in template
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Fullfeed
EXPOSE 10152/tcp
EXPOSE 10152/udp
# Igate
EXPOSE 14580/tcp
EXPOSE 14580/udp
# HTTP Status
EXPOSE 14501/tcp
# HTTP Upload
EXPOSE 8080/tcp
# UDP Submit
EXPOSE 8080/udp

# start the service and follow the logs so that container doesn't exit
ENTRYPOINT ["/entrypoint.sh"]
CMD service aprsc start && tail -F /opt/aprsc/logs/aprsc.log
