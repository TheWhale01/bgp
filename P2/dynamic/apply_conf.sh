#/bin/bash

container_ids=$(docker ps -q)

for id in $container_ids; do
	hostname=$(docker inspect --format '{{ .Config.Hostname }}' "$id")
	file="$PWD/${hostname}.sh"
	if [ -f "$file" ]; then
		echo "Applying config $file config file."
		docker cp "$file" "$id:/" 
		docker exec "$id" sh /"${hostname}.sh"
	else
		echo "Could not find file: $file"
	fi
done
