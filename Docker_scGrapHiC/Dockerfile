FROM mambaorg/micromamba:1.5.8

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    git \
    build-essential \
    libglib2.0-0 \
    libgl1 \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# TUI subprocesses call `conda run`; micromamba is compatible.
RUN ln -sf /usr/local/bin/micromamba /usr/local/bin/conda

WORKDIR /opt/scGrapHiC

COPY requirements.txt /tmp/requirements.txt
COPY Docker_scGrapHiC/environment.yml /tmp/environment.yml

RUN micromamba create -y -n scgraphic -f /tmp/environment.yml \
    && micromamba run -n scgraphic pip install --no-cache-dir -r /tmp/requirements.txt textual rich \
    && micromamba clean -a -y

COPY . /opt/scGrapHiC/
COPY Docker_scGrapHiC/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV SCGRAPHIC_CONDA_ENV=scgraphic
ENV TERM=xterm-256color
ENV PYTHONUNBUFFERED=1

ENTRYPOINT ["/entrypoint.sh"]
