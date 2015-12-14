#!/bin/bash
nodes=("n0" "n1" "n2" "n3")
for node in "${nodes[@]}"
do
	echo "starting  $node..."
	docker run -d -i -t -h $node \
		--add-host n0:172.17.0.2 \
		--add-host n1:172.17.0.3 \
		--add-host n2:172.17.0.4 \
		--add-host n3:172.17.0.5 \
		-p 22 \
		--name $node ischool/hdpbase:v1
done
echo "running nodes"
docker ps

