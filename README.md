An environment (variable) friendly, dockerized SSH tunnel. Intended for use with Docker Compose. Useful for when you need set up a tunnel to access a service (for instance a database) which is otherwise not accessible from your Docker network.

You can set up multiple forward/reverse tunnels to a single remote endpoint. If you need multiple endpoints then you need to run multiple containers.

You will need to expose the relevant ports in your `docker-compose.yml` file.

Please refer to `run.sh` to see which environment variables you have to set.
