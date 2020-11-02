#!/bin/bash

! hash pass 2>/dev/null && sudo apt -y install pass
"${WORKON_HOME}/ansible/bin/ansible-galaxy" install -r requirements.yml && \
#secret-tool lookup ansible-vault personal |
pass show development/ansible-vault/personal | \
    "${WORKON_HOME}/ansible/bin/ansible-playbook" \
    --vault-password-file /bin/cat -i inventory \
    -l "$(hostname)*" "$@" playbook.yml

