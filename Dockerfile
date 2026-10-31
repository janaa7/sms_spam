FROM quay.io/jupyter/scipy-notebook:latest

USER root

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt \
    && mkdir -p /home/jovyan/bd-a1 \
    && chown -R ${NB_UID}:${NB_GID} /home/jovyan/bd-a1

WORKDIR /home/jovyan/bd-a1

COPY --chown=${NB_UID}:${NB_GID} data/ ./data/
COPY --chown=${NB_UID}:${NB_GID} notebook/ ./notebook/
COPY --chown=${NB_UID}:${NB_GID} output/ ./output/

USER ${NB_UID}

EXPOSE 8888

CMD ["start-notebook.py", "--ServerApp.ip=0.0.0.0", "--ServerApp.port=8888", "--ServerApp.root_dir=/home/jovyan/bd-a1"]