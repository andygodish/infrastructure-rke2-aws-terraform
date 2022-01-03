Host rke2-init-server 
  Hostname ${init_server_ip}
  User ${user}
  IdentityFile ~/.ssh/rancher-laptop

Host rke2-server-0
  Hostname ${server_ip_0}
  User ${user}
  IdentityFile ~/.ssh/rancher-laptop

Host rke2-server-1 
  Hostname ${server_ip_1}
  User ${user}
  IdentityFile ~/.ssh/rancher-laptop
