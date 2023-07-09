sudo ufw enable -y
sudo ufw allow 6443/tcp
sudo ufw allow 2379:2380/tcp
sudo ufw allow 10250/tcp
sudo ufw allow 10251/tcp
sudo ufw allow 10252/tcp

sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd

sudo kubeadm init

# how to wait untill kubeadm init is done?
sleep 60

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "hello-master"

# kubeadm token create --print-join-command