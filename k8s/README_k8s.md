**Kubernetes кластер**

Последовательность:

```
yc compute instance list
```

![img.png](pics/img_9.png)

```
ssh ubuntu@51.250.90.227

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
declare -a IPS=(10.128.0.35 10.128.0.29 10.128.0.21)
CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

```

![img_2.png](pics/img_2.png)

после добавления ansible_user: ubuntu и etcd на master:

```
cat ./inventory/mycluster/hosts.yaml
```

![img.png](pics/img_3.png)

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

обновить ip адрес в конфиг-файле, указав внешний ip виртуальной машины (master):
```
sudo nano ~/.kube/config
sudo cat ~/.kube/config
```
скопировать конфиг на локальную машину:
```
 scp ubuntu@51.250.90.227:/home/ubuntu/.kube/config ~/.kube
 cat ~/.kube/config
```

![img.png](pics/img_8.png)

