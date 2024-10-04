FROM debian:bullseye-slim

# Define build arguments
ARG GODOT_VERSION
ARG GODOT_VERSION_DIR
ARG EXPORT_NAME
ARG OUTPUT_FILENAME
ARG GODOT_ARCHIVE=Godot_v${GODOT_VERSION}_linux_headless.64.zip
ARG EXPORT_TEMPLATES=Godot_v${GODOT_VERSION}_mono_export_templates.tpz


ENV GODOT_VERSION=${GODOT_VERSION}
ENV EXPORT_NAME=${EXPORT_NAME}
ENV OUTPUT_FILENAME=${OUTPUT_FILENAME}

# Generate the templates directory based on the directory version
ENV TEMPLATES_DIR=/tmp/data/godot/templates/${GODOT_VERSION_DIR}

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and install Godot
RUN wget -v https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}/${GODOT_ARCHIVE} -O /tmp/godot.zip \
    && mkdir -p /build/godot \
    && unzip /tmp/godot.zip -d /build/godot \
    && rm /tmp/godot.zip

# Download Godot export templates
RUN wget -q https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}/${EXPORT_TEMPLATES} -O /tmp/export-templates.tpz \
    && mkdir -p ${TEMPLATES_DIR} \
    && unzip -o -j /tmp/export-templates.tpz -d ${TEMPLATES_DIR} \
    && rm /tmp/export-templates.tpz

# Setup environment variables
ENV XDG_CACHE_HOME /tmp/cache
ENV XDG_DATA_HOME /tmp/data
ENV XDG_CONFIG_HOME /tmp/config
RUN mkdir -p /tmp/cache && mkdir -p /tmp/data && mkdir -p /tmp/config

# CMD to export based on the specified variables
CMD rm -rf /build/output/* && /build/godot/Godot_v${GODOT_VERSION}_linux_headless.64 --export "${EXPORT_NAME}" --path "/build/src" "/build/output/${OUTPUT_FILENAME}"