# Steps
## create vault
```
ansible-vault create secret.yml
```
### run a playbook
```
ansible-playbook main-playbook.yml
```

# Useful commands
#generate ssh key
```
ssh-keygen -t rsa -b 4096 -C "ansible"
```
 
#copy the sshkey to the recieving vm
```
ssh-copy-id -i ~/.ssh/id_rsa.pub user@target_host
```

#Test connectivity
```
ansible all --key-file ~/.ssh/id_rsa -i inventory.yml -m ping
```

#make ansible.cfg file to a local config in the vm 
#list all available hosts 
```
ansible all --list-hosts
```

#show system info of the hosts 
```
ansible all -m gather_facts
```

#update the hosts based on ther password 
```
ansible all -m apt -a update_cache=true --become --ask-become-pass
```

#test install snapd latest
```
ansible all -m apt -a "name=snapd state=latest" --become --ask-become-pass
```

#check if snapd already installed 
```
ansible all -m shell -a "dpkg -l | grep snapd" --become --ask-become-pass
```

#run a playbook
```
ansible-playbook -i inventory.yml playbook.yml --ask-become-pass
```