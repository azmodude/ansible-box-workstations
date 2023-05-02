#!/bin/bash
set -Eeuxo pipefail

[[ -z ${WORKON_HOME+x} ]] && WORKON_HOME=${HOME}/.cache/virtualenvs

mkdir "${WORKON_HOME}" || true
python3 -m venv "${WORKON_HOME}/ansible" &&
  "${WORKON_HOME}/ansible/bin/pip" install wheel &&
  "${WORKON_HOME}/ansible/bin/pip" install ansible
(. ${WORKON_HOME}/ansible/bin/activate && pip install github3.py psutil ggshield)
