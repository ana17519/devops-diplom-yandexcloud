Последовательность:

```
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
```

сервисный аккаунт:

```
yc iam service-account list

yc resource-manager folder add-access-binding default \
 --role admin \
 --subject serviceAccount:aje4ofq2hpt96gqf6s7k
```

![img.png](pics/img.png)

```
terraform init
```
![img_2.png](pics/img_2.png)

```
terraform apply:
```
![img_1.png](pics/img_1.png)
![img.png](pics/img_4.png)
```
terraform destroy:
```
![img_1.png](pics/img_3.png)