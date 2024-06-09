# Use a Python base image based on Debian
FROM python:3.12-slim-bookworm
SHELL ["/bin/bash", "-i", "-c"]

ARG PYINSTALLER_VERSION=6.8.0

ENV PYPI_URL=https://pypi.python.org/
ENV PYPI_INDEX_URL=https://pypi.python.org/simple

# Set environment variables to non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install dependencies
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    libgtk-3-dev \
    libgl1-mesa-glx \
    libglu1-mesa \
    libjpeg-dev \
    libtiff-dev \
    libpng-dev \
    libwebkit2gtk-4.0-dev \
    libnotify-dev \
    freeglut3-dev \
    libsdl1.2-dev \
    libgstreamer-plugins-base1.0-dev \
    libgstreamer1.0-dev \
    binutils gcc zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint-linux.sh /entrypoint.sh

# Install wxPython using pip
RUN pip3 install wxPython \
    && pip3 install pyinstaller==$PYINSTALLER_VERSION \
    && pip3 cache purge \
    && chmod +x /entrypoint.sh


VOLUME /src/
WORKDIR /src/

ENTRYPOINT ["/entrypoint.sh"]