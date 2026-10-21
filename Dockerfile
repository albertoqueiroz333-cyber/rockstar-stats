FROM python:3.15.0-trixie


WORKDIR app/
COPY ./app .

RUN pip install -r requirements.txt

RUN apt-get update && apt-get install -y \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Descomenta e gera o locale pt_BR.UTF-8
RUN sed -i '/pt_BR.UTF-8/s/^# //' /etc/locale.gen && \
    locale-gen pt_BR.UTF-8

# Define as variáveis de ambiente globais do locale
ENV LANG=pt_BR.UTF-8
ENV LANGUAGE=pt_BR:pt
ENV LC_ALL=pt_BR.UTF-8

EXPOSE 8000
CMD uvicorn --host 0.0.0.0 app:app