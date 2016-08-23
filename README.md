# BOSH Release for [Diamond](https://github.com/python-diamond/Diamond)

The purpose of this release is running some specialized collectors to gather metrics from
external platforms and send them to different systems. For regular monitoring of the vms, 
collectd is better. 

Specialized collectors are:

 * Ontapclustercollector, to be able to collect metrics from NetAPP
 * VMWARE collector to gather VCenter metrics.


## Usage

By default all collectors shipped with Diamond are available, but you can
add your own collectors and user_scripts via `src` folder and create a new
BOSH Release. We are using submodules, so you have to run:

```
git submodule init
git submodule update
```

To use this bosh release, first upload it to your bosh:

```
bosh target BOSH_HOST
git clone https://github.com/springerpe/diamond-boshrelease.git
cd diamond-boshrelease
bosh upload release releases/diamond-1.yml
```

As example, this is how to define the 
[OntapClusterCollector](https://github.com/SpringerPE/diamond-boshrelease/blob/master/README.netappclustercollector.md)
