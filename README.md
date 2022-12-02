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

This repository creates an infrastructure in Microsoft Azure with 2 virtual machines and a Kubernetes cluster inside a subnet within a Virtual Network.
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
- *variable.tf* : terraform file with the existing variables
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
8. Save the output in a variable to use in DevOps
`$variable_output = terraform output -json | ConvertFrom-Json `
9. Read one specific variable from the output variable
`$variable_output.VMS.value.<resource>.<specific_variable>` e.g.: `$variable_output.VMS.value.VM01.USERvm`  [<sup>2</sup>](#item6)


## Variables to modify<a name="item5"></a>
These variables can be modified in *prod.tfvars* file.

**General info**
- *__location__* : location of the resources (e.g.: "westeurope")
- *__gruporesource__* : name of the project name (it will create a resource group with the same name)
- *__network-vnet-cidr__* : subnet mask of the virtual network (e.g.: "10.128.1.0/16")
- *__network-subnet-cidr__* : subnet mask of the of the subnet (e.g.: "10.128.1.0/24")
- *__maquinas__* : variables related withe the virtual machines
  - *size* : size of the virtual machine (e.g.:Standard_DS1_v2)
  - *source_image_offer* = O.S. of the virtual machine (e.g.:UbuntuServer")
  - *source_image_publisher* = Specifies the publisher of the image (e.g.:Canonical")
  - *storage_account_type* = SKU Type (e.g.:Standard_LRS")
  - *admin_username* = username of the virtual machine (e.g.:azureuser")
  - *if_public_ip* = boolean to indicate if the virtual machine has a public ip
  - *securities_rule_vm* = security rules of the virtual machine (ports, protocol, etc.)


## Outputs:<a name="item6"></a>
The output file has a json format and contents different specific variable for each resource:

For Virtual Machines: 
- *ssh_key_vm* : ssh key of the Virtual Machine
- *public_ip* : public IP to access to the Virtual Machine from the internet
- *private_ip* : private IP to access to the Virtual Machine from the subnet
- *userVM* : administrator username of the Virtual Machine


## Contact:<a name="item7"></a>
mail: hgonzalez@stemdo.io