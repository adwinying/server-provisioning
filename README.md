# server-provisioning

Server infrastructure automation powered by terraform and ansible

## Installation

### Terraform (Infrastructure)

0. Export Vultr's API key as environmental variable
```bash
$ export TF_VAR_api_key="[API key]"
```

1. Init terraform
```bash
$ terraform init
```

2. [If importing an existing infrastructure] Import terraform state
```bash
$ terraform import vultr_instance.tunnel [instanceID]
```

3. Confirm infrastructure changes
```bash
$ terraform plan
```

4. Apply infrastructure changes
```bash
$ terraform apply
```

### Ansible (Software)

0. Add `password_file` and skip to step 3, else continue to next step

```bash
$ touch password_file
```

1. Copy `group_vars/servers.yml.example` to `group_vars/servers.yml` set the appropriate config

2. Configure `servers` inventory file

```
[remote]
tunnel ansible_host=tunnel.example.org ansible_user=user ansible_become_pass=secret

[local]
nas ansible_host=nas.example.org ansible_user=user ansible_become_pass=secret

[servers:children]
remote
local
```

3. Run deployment script

```bash
$ ansible-playbook --vault-password-file=password_file -i servers site.yml
```

## Editing encrypted files

```bash
$ ansible-vault edit --vault-password-file=password_file group_vars/servers.yml
```

## References

### Terraform
- [Vultr provider](https://registry.terraform.io/providers/vultr/vultr/latest/docs)
- [Vultr variables](https://www.terraform.io/docs/language/values/variables.html)
- [Vultr instance resource](https://registry.terraform.io/providers/vultr/vultr/latest/docs/resources/instance)
- [Importing existing resources](https://learn.hashicorp.com/tutorials/terraform/state-import)

### Wireguard
- [WireGuard Site-to-Site](https://gist.github.com/insdavm/b1034635ab23b8839bf957aa406b5e39)
- [WireGuard: How to access a peer’s local network](https://iliasa.eu/wireguard-how-to-access-a-peers-local-network/)
- [Some Unofficial WireGuard Documentation](https://github.com/pirate/wireguard-docs)

### Port forwarding
- [Expose server behind NAT with WireGuard and a VPS](https://golb.hplar.ch/2019/01/expose-server-vpn.html)
- [How To Forward Ports through a Linux Gateway with Iptables](https://www.digitalocean.com/community/tutorials/how-to-forward-ports-through-a-linux-gateway-with-iptables)

### S.M.A.R.T
- [Archiwiki page](https://wiki.archlinux.org/index.php/S.M.A.R.T.)
- [Ubuntu-specific tutorial](https://www.howtoforge.com/tutorial/monitor-harddisk-with-smartmon-on-ubuntu/)

### Firewall
- [How To Set Up a Firewall with UFW on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04)
- [Archwiki page](https://wiki.archlinux.org/index.php/Uncomplicated_Firewall)
