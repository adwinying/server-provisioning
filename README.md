# server-provisioning

Server setup scripts powered by ansible

## Installation

1. Copy `group_vars/servers.yml.example` to `group_vars/servers.yml` set the appropriate config

2. Copy `roles/user/templates/authorized_keys.j2.example` to `roles/user/templates/authorized_keys.j2` add the SSH public keys to be authorized

3. Configure `roots` inventory file

```
[remote]
tunnel ansible_user=root ansible_ssh_pass=extrasecret

[local]
nas ansible_user=root ansible_ssh_pass=extrasecret

[servers:children]
remote
local
```

4. Add `ForwardAgent yes` to SSH config

```
Host nas
  HostName nas.example.org
  ForwardAgent yes

Host tunnel
  HostName tunnel.example.org
  ForwardAgent yes
```

5. Add identity key

```bash
$ ssh-add ~/.ssh/id_rsa
```

6. Run pre-deployment script

```bash
$ ansible-playbook -i roots bootstrap.yml
```

7. Configure `servers` inventory file

```
[remote]
tunnel ansible_user=user ansible_become_pass=secret

[local]
nas ansible_user=user ansible_become_pass=secret

[servers:children]
remote
local
```

8. Run deployment script

```bash
$ ansible-playbook -i servers site.yml
```

## References

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
