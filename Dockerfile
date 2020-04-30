# docker build --rm -t putssander/robbert .

# Start from a core stack version
FROM jupyter/datascience-notebook:latest

#RUN mkdir -p /home/$NB_USER/models/fairseq && mkdir -p /home/$NB_USER/models/transformers && chmod -R 1777 /home/$NB_USER
#WORKDIR /home/$NB_USER/models/fairseq
#RUN wget https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/encoder.json &&\
#    wget https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/vocab.bpe &&\
#    wget https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/dict.txt &&\
#    wget https://github.com/iPieter/BERDT/releases/download/v1.0/RobBERT-base.pt
#WORKDIR /home/$NB_USER/models/transformers
#RUN wget https://s3.amazonaws.com/models.huggingface.co/bert/pdelobelle/robBERT-base/config.json &&\
#    wget https://s3.amazonaws.com/models.huggingface.co/bert/pdelobelle/robBERT-base/merges.txt &&\
#    wget https://s3.amazonaws.com/models.huggingface.co/bert/pdelobelle/robBERT-base/pytorch_model.bin &&\
#    wget https://s3.amazonaws.com/models.huggingface.co/bert/pdelobelle/robBERT-base/vocab.json &&\
#    wget https://s3.amazonaws.com/models.huggingface.co/bert/pdelobelle/robBERT-base/added_tokens.json &&\
#    wget https://s3.amazonaws.com/models.huggingface.co/bert/pdelobelle/robBERT-base/special_tokens_map.json &&\
#    wget https://s3.amazonaws.com/models.huggingface.co/bert/pdelobelle/robBERT-base/tokenizer_config.json &&\

# Install from requirements.txt file
COPY requirements.txt /tmp/
RUN pip install --requirement /tmp/requirements.txt
#RUN python -m spacy download nl_core_news_sm
#RUN python -m spacy download en_core_web_sm

WORKDIR /home/$NB_USER

RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER