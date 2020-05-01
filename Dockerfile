# docker build --rm -t putssander/robbert .
FROM putssander/docker-jupyter-pytorch
RUN apt-get update && apt-get install -y --no-install-recommends \
         g++ &&\
     rm -rf /var/lib/apt/lists/*

# Install from requirements.txt file
COPY requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt