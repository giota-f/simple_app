FROM python:3

WORKDIR /tmp
COPY . /tmp
RUN pip3 install -r requirements.txt
ENV FLASK_APP=restapi

ENTRYPOINT flask run --host=0.0.0.0
