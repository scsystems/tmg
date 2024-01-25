#!/usr/bin/env bash
# install-dependencies command
#
# Usage: ./tmg install-dependencies
#

set -euo pipefail

# Includes
source "${SELF_PATH}/includes/common.sh"
source "${SELF_PATH}/includes/localhost_ansible.sh"

# Function to provide a description of the command
command_description() {
    echo "Installs dependencies including Ansible and optionally development dependencies."
}

# Function to parse command-line options
parse_options() {
    getopt --longoptions no-password,force,dev, --options "" -- "$@"
}

# Function to confirm actions
confirm_action() {
    local message="${1}"
    read -r -p "${message} [y/N] " response
    if [[ ! "${response}" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        echo "Aborted."
        exit 1
    fi
}

# Function to install Ansible
install_ansible() {
    if ! command -v ansible > /dev/null; then
        echo "Installing Ansible"
        # Add the actual installation commands here
    else
        echo "Ansible is already installed. Skipping."
    fi
}

# Function to run the Ansible playbook
run_playbook() {
    local playbook_path="${SELF_PATH}/ansible/install-devops-dependencies.yml"
    local skip_tags="${2:-}"
    local ask_pass="${3:-false}"

    if [[ "${ask_pass}" == true ]]; then
        localhost_ansible_playbook "${playbook_path}" --skip-tags "${skip_tags}" --ask-become-pass
    else
        localhost_ansible_playbook "${playbook_path}" --skip-tags "${skip_tags}"
    fi
}


create_ansible_structure() {
    local base_dir=${SELF_PATH}

    # Create required directory structure in one step
    mkdir -p "$base_dir/ansible/group_vars" "$base_dir/ansible/inventories"

    # Copy or create the install-devops-dependencies file
    cp -n ./includes/install-devops-dependencies.yml "$base_dir/ansible/install-devops-dependencies.yml" || true

    # Define inventory file content
    local inventory_content="[local]\nlocalhost ansible_connection=local"
    local inventory_vars="ansible_host=127.0.0.1\nansible_user: josuesanchez"

    # Create or replace the inventory and group_vars files
    echo -e "$inventory_vars" > "$base_dir/ansible/group_vars/localhost.yml"
    echo -e "$inventory_content" > "$base_dir/ansible/inventories/localhost"

    echo "Ansible structure and inventory created in '$base_dir'"
}

# Main function
install_dependencies_main() {
    local no_password=false
    local force=false
    local devops_dependencies=false

    while [[ "$#" -gt 1 ]]; do
        case "$2" in
        --no-password) no_password=true ;;
        --force) force=true ;;
        --devops) devops_dependencies=true ;;
        *) echo "Ignoring unknown option: $2" ;;
        esac
        shift
    done

    echo "This script installs Ansible."
    [[ "${force}" != true ]] && confirm_action "Are you sure?"
    create_ansible_structure
    install_ansible

    if [[ "${devops_dependencies}" != true ]]; then
        echo "DevOps dependencies flag not set. Ending script after Ansible installation."
        exit 0
    fi

    local playbook_skip_tags=""
    [[ "${devops_dependencies}" != true ]] && playbook_skip_tags="devops_dependencies"
    local ask_pass=$([[ "${no_password}" == true ]] && echo false || echo true)

    run_playbook "${playbook_skip_tags}" "${ask_pass}"
    echo "Finished!!!"
}


# Check if the script is being run indirectly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_dependencies_main "$@"
fi

