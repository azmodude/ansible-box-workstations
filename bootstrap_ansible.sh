#!/bin/bash

sudo apt -y install python3-venv
mkdir ~/.venv || true
python3 -m venv ~/.venv/ansible && \
    ~/.venv/ansible/bin/pip install wheel && \
    ~/.venv/ansible/bin/pip install ansible

