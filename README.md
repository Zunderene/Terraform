# Infrastructure with Terraform

Index
1. [What kind of infrastructure creates?](#item1)
2. [Case of use](#item2)
3. [File Structure](#item3)
4. [How to launch](#item4)
5. [Variables to modify](#item5)
6. [Outputs](#item6)
7. [Contact](#item7)

## What kind of infrastructure creates?<a name="item1"></a>

This repository creates an infrastructure in Microsoft Azure with a Virtual Network and two connected subnets. The first one has 2 virtual machines and the second one a Kubernetes cluster. 
Look picture below:
![Infrastructure](https://github.com/jbcoleto/Terraform/blob/main/terraformProject.drawio.png)


## Case of use<a name="item2"></a>
An example of use is to deploy an application with three layers (frontend, backend and persistence layer) with a Disaster Recovery system.

It is ready to use in a DevOps structure.


## Structure<a name="item3"></a>
The repository is structured in 3 modules:
- Virtual Machine
- Network
- K8

Each module has:
- *main.tf* : terraform file to launch the module
- *variable.tf* : terraform file with variables
- *outputs.tf* :  terraform file with outputs

## How to launch<a name="item4"></a>
1. Clone the repository:
`git clone https://github.com/Zunderene/Terraform`
2. Enter the Terraform folder:
`cd Terraform`
3. Initiate terraform directory:
`terraform init`
4. Validate terraform files:
`terraform validate`
5. Modify the variables in prod.tfvars [<sup>1</sup>](#item5)
5. Create an execution plan:
`terraform plan -var-file=”prod.tfvars”`
6. Apply the terraform main file to create the infrastructure:
`terraform apply`
7. List all the outputs:
`terraform output`
8. Save the output in a variable to use en DevOps
`$variable_output = terraform output -json  | ConvertFrom-Json `
9. Read one specific variable from the output variable
`$variable_output.<specific_variable>.value.<resource>` e.g.: `$planObj.ssh_key_vm_pem.value.VM01`

8. Use variables in automation
`terraform output -raw variable` ELIMINAR?????


## Variables to modify<a name="item5"></a>
These variables must be modified in *prod.tfvars* file.

There is an example in *prod_example.tfvars*.

**Azure account**
- *storage_account_name* = terraformstorageaccount
- *container_name* = terraformcontainer
- *key* = terraformtfstatefile
- *access_key* = storagekey

**General info**
- *project* : name of the project name (it will create a resource group with the same name)
- *location* : location of the resources
- *environment* : application program language

**Network**
- *name_network* : ¿??
- *network-vnet-cidr* : Ip ranges of the virtual network (e.g.: "10.128.1.0/16")
- *network-subnet-cidr* : Ip ranges of the subnet (e.g.: "10.128.1.0/24")

**Virtual Machine**
- *name_VM* : ¿??
- *sql_admin_username* : administrator name of the virtual machine
- *sql_admin_password* : password of the virtual machine

**K8**
- *cluster_name* : name for the Kubernetes Cluster
- *tags* : tag for Kubernetes Cluster
- *agent_count* : initial number of nodes which should exist in this Node Pool (between 1 and 1000)
- *vm_size* : size of the virtual machine (e.g. "Standard_D2_v2")
- *load_balancer_sku* : SKU of the Load Balancer (e.g. "standard")
- *dns_prefix* : DNS prefix specified when creating the managed cluster.



## Outputs:<a name="item6"></a>
The output file has a json format and contents different specific variable for each resource (Virtual Machine or Kubernete Cluster):
- *ssh_key_vm_pem* : ssh key of the Virtual Machine
- *public_ip* : public IP to access to the Virtual Machine from the internet
- *ip_private_addres* : private IP to access to the Virtual Machine from the subnet
- *admin_username* : administrator username of the Virtual Machine



## Contact:<a name="item7"></a>
mail: hgonzalez@stemdo.io