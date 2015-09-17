## Dockerfile for `radiant-mod`

Dockerfile for [radiant-mod](https://github.com/warmdev/radiant-mod)

The Dockerfile is inspired by the `rocker/shiny` image and uses the `shiny-server.sh` startup script from https://github.com/rocker-org/shiny.

### Usage

```
git clone https://github.com/warmdev/radiant-mod-docker.git
cd radiant-mod-docker
sudo docker build -t radiant-mod .
sudo docker run -d -p 3838:3838 -v {host_data_folder}:/srv/shiny-server/data radiant-mod
```

`Radiant` will be live at `http://localhost:3838/marketing`. 

### Version information

* OS: CentOS 7
* R: Revolutionary R Open 3.2.1
* Shiny Server: 1.4.0.721
* Radiant: 0.3.17