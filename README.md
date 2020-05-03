<p align="center"> 
    <img src="res/robbert_logo_with_name.png" alt="RobBERT: A Dutch RoBERTa-based Language Model" width="75%">
 </p>


![Python](https://img.shields.io/badge/python-v3.6+-blue.svg)
![Contributions welcome](https://img.shields.io/badge/contributions-welcome-orange.svg)
![GitHub](https://img.shields.io/github/license/ipieter/RobBERT)

# RobBERT
A Dutch language model based on [RoBERTa](https://github.com/pytorch/fairseq/tree/master/examples/roberta) with some tasks specific to Dutch.

Read more on our [blog post](https://people.cs.kuleuven.be/~pieter.delobelle/robbert/) or on the [paper](https://arxiv.org/abs/2001.06286).

## Getting started

RobBERT can easily be used in two different ways, namely either using [Fairseq RoBERTa](https://github.com/pytorch/fairseq/tree/master/examples/roberta) code or using [HuggingFace Transformers](https://github.com/huggingface/transformers)

### Using Huggingface Transformers

You can download your model for 🤗 Transformers directly. You can use the following code to download the base model and finetune it yourself. We'll explain how to do that in the next section!

```python 
from transformers import RobertaTokenizer, RobertaForSequenceClassification
tokenizer = RobertaTokenizer.from_pretrained("pdelobelle/robBERT-base")
model = RobertaForSequenceClassification.from_pretrained("pdelobelle/robBERT-base")
```

**Watch the casing**, as the Transformer's library uses the name to determine which tokenizer and model to use. Starting with `transformers v2.4.0` (or installing from source), you can use AutoTokenizer and AutoModel, as it now uses a `model_type: "roberta"` attribute in the model's `config.json`.

Or you can also download a model that we finetuned. Check [our project site](https://people.cs.kuleuven.be/~pieter.delobelle/robbert/) for a list of all models, the base model is available as `pdelobelle/robbert-base`.

### Using Fairseq

You can also use RobBERT using the RoBERTa architecture code.
We use the same encoder and dictionary as [Fairseq](https://github.com/pytorch/fairseq/), which you can download like this (use curl on Mac OS): 

```
mkdir data
cd data
wget -N 'https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/encoder.json'
wget -N 'https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/vocab.bpe'
wget -N 'https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/dict.txt'
```

Then download our Fairseq model from here [(RobBERT-base, 1.5 GB)](https://github.com/iPieter/BERDT/releases/download/v1.0/RobBERT-base.pt). 

You can then use all functions of [RoBERTa](https://github.com/pytorch/fairseq/tree/master/examples/roberta), but using RobBERT's model.pt.

## Heads

We also provide the following fine-tuned heads:

- Prediction of `die` or `dat` in sentences as a classification problem (trained on [EuroParl](http://www.statmt.org/europarl/) sentences)
- Sentiment analysis (trained on [DBRD](https://github.com/benjaminvdb/110kDBRD))

## Experiments from paper

You can replicate the experiments done in our paper by following the following steps.
You can install the required dependencies either the requirements.txt or pipenv:
- Installing the dependencies from the requirements.txt file using `pip install -r requirements.txt`
- OR install using [Pipenv](https://pipenv.readthedocs.io/en/latest/) *(install by running `pip install pipenv` in your terminal)* by running `pipenv install`.


### Classification
In this section we describe how to use the scripts we provide to fine-tune models, which should be general enough to reuse for other desired textual classification tasks.

#### Sentiment analysis using the Dutch Book Review Dataset

- Download the Dutch book review dataset from [https://github.com/benjaminvdb/110kDBRD](https://github.com/benjaminvdb/110kDBRD), and save it to `data/raw/110kDBRD`
- Run `src/preprocess_dbrd.py` to prepare the dataset.
- To not be blind during training, we recommend to keep aside a small evaluation set from the training set. For this run `src/split_dbrd_training.sh`.
- Follow the notebook `notebooks/finetune_dbrd.ipynb` to finetune the model.

#### Predicting the Dutch pronouns _die_ and _dat_
We fine-tune our model on the Dutch [Europarl corpus](http://www.statmt.org/europarl/). You can download it first with:

```
cd data\raw\europarl\
wget -N 'http://www.statmt.org/europarl/v7/nl-en.tgz'
tar zxvf nl-en.tgz
```
As a sanity check, now you should have the following files in your `data/raw/europarl` folder:

```
europarl-v7.nl-en.en
europarl-v7.nl-en.nl
nl-en.tgz
```

Then you can run the preprocessing with the following script, which fill first process the Europarl corpus to remove sentences without any _die_ or _dat_.
Afterwards, it will flip the pronoun and join both sentences together with a `<sep>` token.

```
python src/preprocess_diedat.py
. src/preprocess_diedat.sh
```

note: You can monitor the progress of the first preprocessing step with `watch -n 2 wc -l data/europarl-v7.nl-en.nl.sentences`. This will take a while, but it's certainly not needed to use all inputs. This is after all why you want to use a pre-trained language model. You can terminate the python script at any time and the second step will only use those._

## Credits and citation

This project is created by [Pieter Delobelle](https://github.com/iPieter), [Thomas Winters](https://github.com/twinters) and Bettina Berendt.

We are grateful to Liesbeth Allein, for her work on die-dat disambiguation, Huggingface for their transformer package, Facebook for their Fairseq package and all other people whose work we could use. 

We release our models and this code under MIT. 

Even though MIT doesn't require it, we would like to ask if you could nevertheless cite our paper if it helped you!

```
@misc{delobelle2020robbert,
    title={RobBERT: a Dutch RoBERTa-based Language Model},
    author={Pieter Delobelle and Thomas Winters and Bettina Berendt},
    year={2020},
    eprint={2001.06286},
    archivePrefix={arXiv},
    primaryClass={cs.CL}
}
```

## Docker edits

Manual download fairseq model

    mkdir models/fairseq
    cd models/fairseq
    
    wget https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/encoder.json &&\ 
    wget https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/vocab.bpe &&\
    wget https://dl.fbaipublicfiles.com/fairseq/gpt2_bpe/dict.txt &&\
    wget https://github.com/iPieter/BERDT/releases/download/v1.0/RobBERT-base.pt
    
Manual download transformer model

    mkdir models/transformer
    cd models/transformer

    wget https://s3.amazonaws.com/models.huggingface.co/bert/pdelobelle/robBERT-base/config.json &&\
    wget https://s3.amazonaws.com/models.huggingface.co/bert/pdelobelle/robBERT-base/merges.txt &&\
    wget https://s3.amazonaws.com/models.huggingface.co/bert/pdelobelle/robBERT-base/pytorch_model.bin &&\
    wget https://s3.amazonaws.com/models.huggingface.co/bert/pdelobelle/robBERT-base/vocab.json

### RUN with GPU

Run from cloned git directory to have notebook available. 

    docker run --gpus all --rm -it --ipc=host \
    --name robbert \
    -p 8888:8888 \
    -p 6006:6006 \
    -v $PWD:/workspace \
    putssander/robbert
    
Jupyter will be come available at port 8888.

Models and data are not included in the image, 
manually downloaded models can be imported using the relative path from the notebooks.

    tokenizer = RobertaTokenizer.from_pretrained("../models/transformers")
    
Scripts can be used by entering the container

    docker exec -it [container-id] bash
