# packer-ocs
Repo that contains example of packer

## What is packer?

Packer is an open source tool that enables you to create identical machine images for multiple platforms from a single source template. A common use case is creating "golden images" that teams across an organization can use in cloud infrastructure.

How to install ?  (Mac)
brew tap hashicorp/tap
brew install hashicorp/tap/packer

Linux :
 DOwnload https://releases.hashicorp.com/packer/1.8.3/packer_1.8.3_darwin_amd64.zip

 Extract and copy binary to binary directory

## Check installation

`packer --version`

# Example 01
## Create basic template

Configure AWS credentials

Create json template

### Running Packer


To build image use below command:

`packer build -debug basic_template.json`

Available commands are:

- build
- console
- fix
- inspect
- validate
- version

Validate json:
`packer validate basic_template.json`

## Provisioners

File

Shell

Ansible

Chef-solo

## Post-Proceesors

Run after the image is built by the builder and provisioned by the provisioner(s). Post-Processeros are option, and they can be used to upload artifacts, re-package, or more.


