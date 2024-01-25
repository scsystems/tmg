#!/usr/bin/env bash

# Set safer error handling
set -euo pipefail

localhost_ansible_playbook() {
    local localhost_inventory_path="${SELF_PATH}/ansible/inventories/localhost"

    # Enable verbose mode if TMG_VERBOSE is true
    [[ "${TMG_VERBOSE:-}" == "true" ]] && set -x

    # Run the ansible-playbook command
    ansible-playbook -i "${localhost_inventory_path}" -D "$@"

    # Disable verbose mode
    set +x
}

localhost_ansible() {
    local localhost_inventory_path="${SELF_PATH}/ansible/inventories/localhost"

    # Enable verbose mode if TMG_VERBOSE is true
    [[ "${TMG_VERBOSE:-}" == "true" ]] && set -x

    # Run the ansible command
    ansible -i "${localhost_inventory_path}" -D "$@"

    # Disable verbose mode
    set +x
}

# Execute the script only if it is not being sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo "This script is intended to be sourced, not executed directly."
fi
