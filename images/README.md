Omelet AMI Template Images 
=================== 

## Omelet AMI Template with [Chef](http://www.getchef.com/chef/)
- Two paramaters are needed in the template: 
    - (string) variables->source_ami_name
    - (list) provisioners->run_list

```
{
  "variables": {
    "aws_access_key": "",
    "aws_secret_key": "",
    "source_ami": "",
    "region": "",
    "ami_name": "",
    "cookbook_path": "",
    "source_ami_name": "[Source Name]"
  },
  "builders": [{
    "type": "amazon-ebs",
    "access_key": "{{user `aws_access_key`}}",
    "secret_key": "{{user `aws_secret_key`}}",
    "region": "{{user `region`}}",
    "source_ami": "{{user `source_ami`}}",
    "instance_type": "t1.micro",
    "ssh_username": "root",
    "ami_name": "{{user `ami_name`}}"
  }],
  "provisioners": [{
    "type": "chef-solo",
    "cookbook_paths": ["{{user `cookbook_path`}}"],
    "run_list": [put_your_run_list_here]
  }]
}
```

- Example: 
    - [TEST-chef.json](https://github.com/TrendMicroDCS/omelet-ami-template/blob/master/images/BL-1/TEST-chef/TEST-chef.json) 
    - [TEST-chef recipes](https://github.com/TrendMicroDCS/omelet-ami-template/tree/master/cookbooks/TEST-chef) 

## Omelet AMI Template with Shell
- Two paramaters are needed in the template: 
    - (string) variables->source_ami_name
    - (string) provisioners->script->$script_name.sh

```
{
  "variables": {
    "aws_access_key": "",
    "aws_secret_key": "",
    "source_ami": "",
    "region": "",
    "ami_name": "",
    "shell_path": "",
    "source_ami_name": "ubuntu/images/ebs/ubuntu-trusty-14.04-amd64-server-20140416.1"
  },
  "builders": [{
    "type": "amazon-ebs",
    "access_key": "{{user `aws_access_key`}}",
    "secret_key": "{{user `aws_secret_key`}}",
    "region": "{{user `region`}}",
    "source_ami": "{{user `source_ami`}}",
    "instance_type": "t1.micro",
    "ssh_username": "ubuntu",
    "ami_name": "{{user `ami_name`}}"
  }],
  "provisioners": [{
    "type": "shell",
    "script": "{{user `shell_path`}}/basic.sh"
  }]
}
```

- Example:
    - [Test-shell.json](https://github.com/TrendMicroDCS/omelet-ami-template/blob/master/images/BL-1/TEST-shell/TEST-shell.json) 
    - [Test-shell script](https://github.com/TrendMicroDCS/omelet-ami-template/blob/master/shell/TEST-shell/basic.sh) 


## How to use Packer to debug recipes temporary: 
```
packer build -var 'ami_name=<your ami name>' -var 'aws_access_key=<aws key>' -var 'aws_secret_key=<aws secret key>' -var 'region=<region>' -var 'source_ami=ami-6ef51d06' -var 'cookbook_path=/your/omelet/project/omelet-ami-template/cookbooks/' /your/omelet/project/omelet-ami-template/images/BL-1/BL-1.json
```
