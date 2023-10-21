**Kubernetes кластер**

Последовательность:

```
yc compute instance list
```

![img.png](pics/img.png)

```
ssh ubuntu@51.250.86.195

sudo apt update
sudo apt install git
git clone https://github.com/kubernetes-sigs/kubespray
```
![img_1.png](pics/img_1.png)

```
sudo apt-get install pip
cd kubespray/
sudo nano requirements.txt -> ansible==6.7.0

sudo pip3 install -r requirements.txt
cp -rfp inventory/sample inventory/mycluster
declare -a IPS=(10.129.0.13 10.129.0.18 10.129.0.27)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

```

![img_2.png](pics/img_2.png)

после добавления ansible_user: ubuntu и etcd на master:

```
cat ./inventory/mycluster/hosts.yaml
```

![img_3.png](pics/img_3.png)

добавлен приватный ключ и права, запуск плейбука:

```
nano ~/.ssh/id_rsa
sudo chmod 0700 ~/.ssh/id_rsa
ansible-playbook -i inventory/mycluster/hosts.yaml cluster.yml -b -v
```
![img_4.png](pics/img_4.png)

kubectl должен понимать к чему подключаться используя конфиг:

```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=$HOME/.kube/config
kubectl get nodes
```
![img_5.png](pics/img_5.png)

```
kubectl get pods --all-namespaces
kubectl cluster-info
```

![img_6.png](pics/img_6.png)

обновила ip адрес в конфиг-файле, указав внешний ip виртуальной машины (master):
```
sudo nano ~/.kube/config
sudo cat ~/.kube/config
```

```
 scp ubuntu@51.250.86.195:/home/ubuntu/.kube/config ~/.kube
 cat ~/.kube/config
```

![img_7.png](pics/img_7.png)
![img_8.png](pics/img_8.png)