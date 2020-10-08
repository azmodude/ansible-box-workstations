#!/bin/bash

ansible-galaxy install -r requirements.yml &&
    secret-tool lookup ansible-vault personal |
    ansible-playbook --vault-password-file /bin/cat -i inventory \
        -l "$(hostname)*" "$@" playbook.yml
