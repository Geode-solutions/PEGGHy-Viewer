FROM python:3.12-slim

WORKDIR /app

COPY . .
RUN pip3 install --user -r requirements.txt && pip3 cache purge
RUN pip3 ihl
RUN pip3 install .
ENV PYTHONPATH="/usr/local:$PYTHONPATH"
ENV PYTHON_ENV="prod"

CMD ["pegghy-viewer", "--data_folder_path", "/data"]

EXPOSE 1234