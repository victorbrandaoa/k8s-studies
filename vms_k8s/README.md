## Using vagrant to creat vms and creating k8s cluster

The `Vagrantfile` defines the configuration for three virtual machines:

- Control Plane with 2 VCPUs and 4GB
- Worker 1 with 1 VCPU and 2GB
- Worker 2 with 1 VCPU and 2GB

Vagrant uses the following scripts

- `containerd_install.sh` script to install `containerd` as the container runtime for Kubernetes

- `containerd_config.sh` script to configure the containerd

- `k8s_install.sh` script to install the K8S (kubeadm, kubectl and kubelet)

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

### Configuring the systemd cgroup driver

```sh
containerd config default | sudo tee /etc/containerd/config.toml # add the default config for containerd

sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml # search the SystemdCgroup in the config file and then set its value to true

sudo sed -i 's/sandbox_image = "registry.k8s.io\/pause:3.6"/sandbox_image = "registry.k8s.io\/pause:3.9"/' /etc/containerd/config.toml # search the sandbox_image in the config file and then set its version from 3.6 to 3.9

sudo systemctl restart containerd
```
