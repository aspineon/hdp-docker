#!/bin/bash
nodes=("n0" "n1" "n2" "n3")
for node in "${nodes[@]}"
do
	echo "stopping $node..."
	docker rm -f $node
done

