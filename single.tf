# Configure the Docker provider
provider "docker" {
	host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nginx" {
    name = "nginx:1.11.1"
}

# Create a container
resource "docker_container" "backend" {
count = 2
    image = "${docker_image.nginx.latest}"
    name = "touchy-feely-${format("%02d", count.index+1)}"

    ports {
    	external = 9090
    	internal = 80
    }

    volumes {
		container_path  = "/usr/share/nginx/html"
		host_path = "/home/dmportella/_volumes/nginx/touchy-feely"
		read_only = true
	}
}