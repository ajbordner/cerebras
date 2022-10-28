# Instructions for running ProtXLNet fine-tuning with the Hugging Face transformers library
  
Build docker container using:  
`docker build -t protxlnet .`  
  
Run container:  
`export UID=$(id -u)`  
`export GID=$(id -g)`  
`docker run -it -d --runtime=nvidia --user $UID:$GID --shm-size=16g --network=host --ulimit memlock=-1 -v ${PWD}:/workspace/lm --name protxlnet protxlnet`  
  
Attach to container:  
`docker attach protxlnet`  
  
Run fine-tuning:  
`torchrun --nnodes=1 --nproc_per_node=2 run_plm.py prot_xlnet.yml`  
