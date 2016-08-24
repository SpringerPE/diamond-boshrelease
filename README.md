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

To test this bosh release (in warden), first upload it to your bosh:

```
bosh target BOSH_HOST
git clone https://github.com/springerpe/diamond-boshrelease.git
cd diamond-boshrelease
bosh_prepare
bosh create release --force
bosh upload release
```

Then define some configuration properties, Diamond has a lot of different handlers 
to send metrics to, in this case we define Graphite and we enable the default
collectors:

```
  properties:
    diamond:
      collector:
        hostname: collector1
        interval: 60
      handlers:
        diamond.handler.graphite.GraphiteHandler:
          batch: 1
          host: "graphite.example.com"
          port: 2003
          timeout: 15
      collectors:
        CPUCollector:
          enabled: True
        DiskSpaceCollector:
          enabled: True
        DiskUsageCollector:
          enabled: True
        LoadAverageCollector:
          enabled: True
        MemoryCollector:
          enabled: True
        VMStatCollector:
          enabled: True
        NetworkCollector:
          enabled: True
```
and deploy it (run `templates/make_manifest warden` or use manifest v2).


A specialized collector is a collector with its own configuration file, with the
same file name as the collector class, for that reason the name of the keys of the
hash in `collectors_config` is important, for example:

```
      collectors_config:
        OntapClusterCollector:
           ...
```

Will create a configuration file called `OntapClusterCollector.conf` with the
rest of properties defined there. You can define as many configurations as you
want.

As example of specialized collector, this is how to define the
[OntapClusterCollector](https://github.com/SpringerPE/diamond-boshrelease/blob/master/README.netappclustercollector.md)


# Author

José Riguera López (SpringerNature) (jose.riguera@springer.com)


# License

MIT License

