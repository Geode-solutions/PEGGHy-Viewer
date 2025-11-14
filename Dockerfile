FROM python:3.12-slim

WORKDIR /app

COPY . .
RUN apt-get update && apt-get install -y libx11-dev libxrender-dev libosmesa6-dev
RUN pip3 install .
ENV PYTHONPATH="/usr/local:$PYTHONPATH"
ENV PYTHON_ENV="prod"

CMD ["pegghy-viewer", "--data_folder_path", "/data"]

EXPOSE 1234