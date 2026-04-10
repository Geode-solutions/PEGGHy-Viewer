FROM python:3.12-slim-bookworm AS builder

RUN apt-get update && apt-get install -y binutils

WORKDIR /app

COPY . .
RUN pip3 install --no-cache-dir . pyinstaller

RUN pyinstaller \
    --onefile \
    --collect-data opengeodeweb_viewer \
    --collect-data pegghy_viewer \
    --collect-all vtkmodules src/pegghy_viewer/app.py \
    --distpath dist \
    --name pegghy-viewer \
    --clean

FROM debian:12-slim

# Install ONLY the runtime libraries your binary actually needs
# (this list was tested with VTK + PyQt6 + OpenGEODE apps in 2025)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libosmesa6-dev \
    libx11-dev \
    libxrender-dev \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /app/dist/pegghy-viewer /usr/local/bin/pegghy-viewer
RUN chmod +x /usr/local/bin/pegghy-viewer
RUN mkdir www && touch www/healthcheck

EXPOSE 1234
ENV PYTHON_ENV=prod
ENV DISPLAY=:0

ENTRYPOINT ["/usr/local/bin/pegghy-viewer"]
CMD ["--data_folder_path", "/data", "--content", "./www", "--host", "0.0.0.0"]
