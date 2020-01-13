#!/bin/bash

pass show devel/ansible-vault/personal | \
    ansible-playbook --vault-password-file /bin/cat -i inventory \
    -l "$(hostname)*" "$@" playbook.yml

