#!/bin/bash

ansible-galaxy collection install -r requirements.yml &&
    ansible-galaxy role install -r requirements.yml &&
    pass show development/ansible-vault/personal pass show |
    ansible-playbook --vault-password-file /bin/cat -i inventory \
        -l "$(hostname)*" "$@" playbook.yml
