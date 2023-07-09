sudo ufw enable -y
sudo ufw allow 10250/tcp
sudo ufw allow 30000:32767/tcp

sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd

echo "hello-worker"