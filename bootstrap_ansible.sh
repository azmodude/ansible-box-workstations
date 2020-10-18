#!/bin/bash

sudo apt -y install python3-venv
mkdir "${WORKON_HOME}" || true
python3 -m venv "${WORKON_HOME}/ansible" && \
    "${WORKON_HOME}/ansible/bin/pip" install wheel && \
    "${WORKON_HOME}/ansible/bin/pip" install ansible

