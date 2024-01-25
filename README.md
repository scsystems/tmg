# Technology Management Gateway (TMG) 

The TMG is a robust command-line interface designed to facilitate and manage various IT operations. This tool treats software as data, offering a wide range of functionalities for IT professionals and developers.

## Features

- **Modular Command Structure**: Commands are organized as individual scripts, allowing for easy extension and customization.
- **Comprehensive IT Operations Support**: Includes support for common DevOps tools like Ansible, Docker, and Terraform.
- **Environment Flexibility**: Can be used in various environments, with support for local setups and development dependencies.
- **Integrated Ansible Support**: Seamless integration with Ansible for automation tasks.

## Installation

Clone the repository to your local machine:

```bash
git clone https://github.com/scsystems/tmg
```

Ensure you have the necessary dependencies installed, including Bash and common Unix tools.

## Usage

To use the TMG CLI, navigate to the cloned directory and execute the `tmg` script:

```bash
cd tmg
./tmg <command> [OPTIONS]
```

### Available Commands

- `ansible`: Manage Ansible-related operations.
- `docker`: Interact with Docker for container management.
- `terraform`: Execute Terraform for infrastructure as code.
- `install-dependencies`: Install necessary dependencies including Ansible and other DevOps tools.

### Command Options

- `--devops`: Install additional tools locally for a complete DevOps setup.

## Customization

TMG CLI is designed to be modular and extensible. You can add new commands by creating a script in the `commands` directory. Each script should have a corresponding `command_description` function to provide a description of the command's functionality.

## Contributing

Contributions to the TMG project are welcome. Please ensure that any pull requests or issues adhere to the TMG framework principles.

## Acknowledgements

This project is maintained by SC Systems, with contributions from the community. Special thanks to all contributors for their valuable input.


