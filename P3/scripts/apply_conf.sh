#/bin/bash

container_ids=$(docker ps -q)

for id in $container_ids; do
	hostname=$(docker inspect --format '{{ .Config.Hostname }}' "$id")
	file="$PWD/${hostname}"
	if [ -f "$file" ]; then
		echo "Applying config $file config file."
		while IFS= read -r line; do
			echo "$line"
			docker exec "$id" $line
		done < "$file"
	else
		echo "Could not find file: $file"
	fi
done
