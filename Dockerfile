FROM python:3.12-slim

WORKDIR /app

COPY . .
RUN apt-get update && apt-get install -y libx11-dev libxrender-dev libosmesa6-dev
RUN pip3 install .
RUN mkdir www && touch www/healthcheck

EXPOSE 1234
ENV PYTHONPATH="/usr/local:$PYTHONPATH"
ENV PYTHON_ENV="prod"

CMD ["pegghy-viewer", "--data_folder_path", "/data", "--content", "./www", "--host", "0.0.0.0"]
