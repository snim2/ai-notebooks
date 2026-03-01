FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1

RUN useradd -ms /bin/bash jupyter \
  && apt-get update \
  && apt-get install -y \
    build-essential \
    curl \
    git \
    texlive-fonts-recommended \
    texlive-plain-generic \
    texlive-xetex \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY container-requirements.txt requirements.txt
ENV PATH="/opt/venv/bin:$PATH"

RUN python -m venv /opt/venv \
  && pip install --upgrade pip \
  && pip install -r requirements.txt \
  && jupyter server extension enable jupyter_ai \
  && jupyter labextension list \
  && mkdir -p /app/notebooks \
  && chown -R jupyter:jupyter /app \
  && mkdir -p /home/jupyter/.jupyter \
  && chown -R jupyter:jupyter /home/jupyter

USER jupyter

CMD ["jupyter", \
     "lab", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--ServerApp.allow_origin='*'" \
]
