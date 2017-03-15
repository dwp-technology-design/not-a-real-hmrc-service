.PHONY: install package deploy destroy build_ami

PUBLIC_KEY_PATH="/home/vagrant/.ssh/id_rsa_not-a-real-hmrc-service.pub"
KEY_NAME="not-a-real-hmrc-service"
AMI=$(shell grep 'artifact,0,id' /dev/null deploy/ami-build.log | cut -d, -f6 | cut -d: -f2)
REGION=$(shell grep 'artifact,0,id' /dev/null deploy/ami-build.log | cut -d, -f6 | cut -d: -f1)
PACKER_CMD="/usr/local/bin/packer"

install:
	npm install

package: install 

build_ami:
	(cd deploy && \
		${PACKER_CMD} build -machine-readable packer.json | tee ami-build.log)
	
deploy: 
	(cd deploy && \
	terraform apply -var "key_name=$(KEY_NAME)" -var "public_key_path=$(PUBLIC_KEY_PATH)" -var "aws_region=$(REGION)" -var "aws_ami=$(AMI)")

destroy:
	(cd deploy && \
	terraform destroy -var "key_name=$(KEY_NAME)" -var "public_key_path=$(PUBLIC_KEY_PATH)" -var "aws_region=$(REGION)" -var "aws_ami=$(AMI)")
