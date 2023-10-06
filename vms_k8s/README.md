## Using vagrant to creat vms and creating k8s cluster

The `Vagrantfile` defines the configuration for three virtual machines:

- Control Plane with 2 VCPUs and 4GB
- Worker 1 with 1 VCPU and 2GB
- Worker 2 with 1 VCPU and 2GB

Vagrant uses the `k8s_install.sh` script to install `kubeadm`, `kubectl` and `kubelet` in all the machines

You can run the following command to setup all the vms

```sh
vagrant up
```

Then you can access all the vms with

```sh
vagrant ssh controlPlane
# or
vagrant ssh worker1
# or
vagrant ssh worker2
```

### Creating the cluster

You need to connect via ssh to you control plane node and then run the `kubeadm init` command

```sh
vagrant ssh controlPlane

ifconfig # you can use this to find the vm's ip, you can get the ip in the enp0s8

kubeadm init --apiserver-advertise-address=<controlPlaneIP> --pod-network-cidr=<IPRange>

# example if your controlPlane's IP is 192.168.56.3
# --apiserver-advertise-address=192.168.56.3 --pod-network-cidr=192.168.0.0/16
```

Run the following command to make kubectl work with your non-root user

```sh
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Now you need to install a Pod network add-on, the following command install `calico`

```sh
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```

Remind to copy the join command that you receive from `kubeadm init` it would look like

```sh
kubeadm join --token <token> <control-plane-host>:<control-plane-port> --discovery-token-ca-cert-hash sha256:<hash>
```

Now you can enter into your worker nodes and then run the command as sudo to join them to the cluster
