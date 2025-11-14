FROM ubuntu:22.04

# Prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv \
    python3-dev build-essential \
    xvfb xpra xpra-html5 \
    pulseaudio alsa-base alsa-utils \
    git wget curl \
    && apt-get clean

# Install pipx + poetry
RUN pip3 install pipx && pipx ensurepath
ENV PATH="/root/.local/bin:${PATH}"
RUN pipx install poetry

# Set working directory
WORKDIR /app

# Copy repo contents
COPY . .

# Install dependencies with Poetry (no venv)
RUN poetry config virtualenvs.create false
RUN poetry install --no-root

# Disable audio errors
ENV SDL_AUDIODRIVER=dummy

# Start Xpra HTML5 server AND the game automatically
CMD xpra start :100 \
    --bind-tcp=0.0.0.0:8080 \
    --html=on \
    --daemon=no \
    --exit-with-children=true \
    --start="python3 main.py"
