## While making the VM
- Setting up VirtualBox Arch, vboxdrv module was not built successfully. Same with vboxnetadp and vboxnetflt (for networking)
- Had to change ip from 192.168.33.10 to 192.168.56.9 since that was the alloted range (192.168.56.0/21)

## While writing the yaml scripts
- The mounted volume was mounted in the system root, not in the user directory
- The service yaml selector naming. It does not uses matchLabels

## While setting up multiple VMs
- Added data for servers and worker nodes.
- Looped through nodes using servers.each (not using standard for loop syntax)
- set everything in a private network. (Using a standard for loop makes each network point at the last iterable server)

## While initalizing the HA cluster
- Separated one server node to initalize the HA cluster. And copied the token to /vagrant/
- Read about vm.trigger to pass the token more securely.
- Added the --tls-san "$IP" cause the default cert was for the loop back ip 10.0.2.15
- Then the node were not discoverable to each, so added --node-ip to set the ip.
> - Used ai for log interpretations

## While adding agents in the cluster

```bash
#!/bin/bash
curl -sfL https://get.k3s.io | K3S_URL="https://192.168.56.11:6443" K3S_TOKEN="$TOKEN" sh -s - agent --node-ip "$IP"
```

- It was not working when I added the --tls-san
