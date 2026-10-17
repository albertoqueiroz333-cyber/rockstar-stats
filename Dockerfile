FROM python:3.15.0-alpine3.24

WORKDIR app/
COPY ./app .

RUN pip install -r requirements.txt

EXPOSE 8000
CMD uvicorn --host 0.0.0.0 app:app