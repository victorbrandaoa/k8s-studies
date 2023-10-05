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

sudo kubeadm init
```

Run the following command to make kubectl work with your non-root user

```sh
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Remind to copy the join command that you receive from `kubeadm init` it would look like

```sh
kubeadm join --token <token> <control-plane-host>:<control-plane-port> --discovery-token-ca-cert-hash sha256:<hash>
```

Now you need to install a Pod network add-on, the following command install `calico`

```sh
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
```
