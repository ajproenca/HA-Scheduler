ARG BUILD_FROM
FROM ${BUILD_FROM}

# Copy data for add-on
COPY run.sh /home
COPY app.py /home
COPY daemon.py /home
COPY daemon_input.py /home
COPY templates /home/templates

RUN chmod a+x /home/run.sh

# Install requirements for add-on
RUN apk add --no-cache python3 python3-dev py-psutil nano
RUN pip3 install Flask requests python-dateutil

# Python 3 HTTP Server serves the current working dir
# So let's set it to our add-on persistent data directory.
WORKDIR /data

EXPOSE 7777

CMD /home/run.sh

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="hascheduler" \
    io.hass.description="home assistant schedule add-on" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Michele Bossa" \
    org.label-schema.description="Home Assistant schedule add-on" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Example" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://github.com/michelebossa/HA-Scheduler" \
    org.label-schema.usage="https://github.com/michelebossa/HA-Scheduler/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/michelebossa/HA-Scheduler" \
    org.label-schema.vendor="Community Hass.io Addons"
