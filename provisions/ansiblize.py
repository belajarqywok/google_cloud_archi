import re
import sys
import subprocess
from typing import Match, Optional


# Parsing Terrfrm output
class TerraformOutput:
    def __init__(self, output: str) -> None:
        self.output: str = output

    def get_ip(self) -> Optional[str]:
        ip_match: Optional[Match[str]] = re.search(
            pattern = r'\d+\.\d+\.\d+\.\d+',
            string  = self.output
        )
        if ip_match:
            return ip_match.group()
        else:
            return None


# cretae Ansible Hosts
class AnsibleInventory:
    def __init__(self, ip_ge: str, ip_sg: str) -> None:
        self.ip_ge: str = ip_ge
        self.ip_sg: str = ip_sg

    def generate_inventory_file(self, hosts_path: str, ) -> None:
        with open(hosts_path, 'w') as inventory_file:
            inventory_file.write("[static_role_vm]\n")
            inventory_file.write(f"{self.ip_sg} ansible_ssh_private_key_file=./../keys/instance-key-sg\n")
            inventory_file.write(f"{self.ip_ge} ansible_ssh_private_key_file=./../keys/instance-key-ge\n\n")
            inventory_file.write("[all:vars]\n")
            inventory_file.write("ansible_user=c211bsy3776\n")

        print("[ Ansible Host Created ... ]")


def main() -> None:
    try:
        output_ge: str = subprocess.check_output(
            args = [f'terraform', f'-chdir=./{sys.argv[1]}', 'output', 'instance_public_ip_ge'],
            text = True
        )

        output_sg: str = subprocess.check_output(
            args = [f'terraform', f'-chdir=./{sys.argv[1]}', 'output', 'instance_public_ip_sg'],
            text = True
        )

        ip_ge: str = TerraformOutput(output = output_ge).get_ip()
        ip_sg: str = TerraformOutput(output = output_sg).get_ip()

        inventory: AnsibleInventory = AnsibleInventory(ip_ge, ip_sg)
        inventory.generate_inventory_file(hosts_path = sys.argv[2])

    except subprocess.CalledProcessError as e:
        print(f"Error: {e}")


if __name__ == "__main__":
    main()

