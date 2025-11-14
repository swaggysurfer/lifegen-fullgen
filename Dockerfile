FROM ubuntu:22.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository universe && \
    add-apt-repository multiverse && \
    apt-get update && \
    apt-get install -y \
        python3 \
        python3-pip \
        python3-venv \
        python3-dev \
        build-essential \
        xvfb \
        xpra \
        pulseaudio \
        alsa-base \
        alsa-utils \
        git \
        wget \
        curl \
    && apt-get clean

# Install pipx + poetry
RUN pip3 install --user pipx && \
    ~/.local/bin/pipx ensurepath
ENV PATH="
