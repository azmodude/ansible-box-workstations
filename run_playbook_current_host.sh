#!/bin/bash

ansible-galaxy install -r requirements.yml && \
pass show development/ansible-vault/personal |
    ansible-playbook --vault-password-file /bin/cat -i inventory \
        -l "$(hostname)*" "$@" playbook.yml
