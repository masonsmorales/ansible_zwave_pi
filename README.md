# Author: Mason Morales
# Date: September 15, 2018
# All Ansibled configurations in this project are my own

# An Ansible playbook and roles for fully configuring a Raspberry Pi 3+ with a Z-Wave stick as a HomeAssisst Automation Server for IOT
## Installs public and private SSH keys
## Configures the OS
## Configures HomeAssist


Before using, you MUST enable SSH on the Raspberry Pi locally
Edit /etc/ssh/sshd_config
Uncomment Port, Listen lines
Restart ssh service
