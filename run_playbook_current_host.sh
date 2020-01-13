#!/bin/bash

! hash pass 2>/dev/null && sudo apt -y install pass
#~/.venv/ansible/bin/ansible-galaxy install -r requirements.yml && \
pass show devel/ansible-vault/personal | \
    ~/.venv/ansible/bin/ansible-playbook --vault-password-file /bin/cat -i inventory \
    -l "$(hostname)*" "$@" playbook.yml

