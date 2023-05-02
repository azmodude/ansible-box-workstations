#!/bin/bash
set -Eeuxo pipefail

# if 1password is running, ask it for the vault password
# if not, fall back to keyboard input
#
# Need to use an array here for bash not to mess with quotes and stuff in
# resulting commandline
if pgrep 1password >/dev/null; then
  vault=(--vault-id "Ansible Vault Personal@onepassword-client.py")
else
  vault=(--ask-vault-pass)
fi

ansible-galaxy collection install -r requirements.yml
ansible-galaxy role install -r requirements.yml --ignore-errors
ansible-playbook -i inventory/inventory.yml \
  --limit $(hostname) \
  "${vault[@]}" \
  "$@" playbook.yml
