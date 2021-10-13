# DiscoverDocker   

## Description   
Docker-based implementation of the [Discover1.1](https://github.com/lucadesabato/Discover1.1) pipeline for bacterial characterization.
   
## Installation   
<code>git clone https://github.com/garcia-nacho/DiscoveryDocker </code>  
<code> cd DiscoveryDocker </code>   
<code> docker build -t garcianacho/discoveryfhi . </code>
    
Alternativetly, it is posible to *pull* updated builds from [Dockerhub](https://hub.docker.com/repository/docker/garcianacho/discoveryfhi):
   
<code>docker pull garcianacho/discoveryfhi</code>
   
## Running the pipeline   
Navigate to the folder where the fastq files are located and run the following command
   
<code>docker run -it --rm -v $(pwd):/home/docker/Discovery/Fastq garcianacho/discoveryfhi</code>
   
Old versions of docker might require the flag *--privileged* to run    
Multiuser systems might require the flag *-u 1000* (or other uid) to run   

### Note that the current version supports only illumina sequences.
