# BOSH Release for diamond

https://github.com/python-diamond/Diamond


The purpose of this release is running some specialized collectors to send metrics
to different systems. For regular monitoring collectd is better. 

Specialized collectors are:

 * Ontapclustercollector, to be able to collect metrics for NetAPP
 * VMWARE collector to get metrics from VCenter.


## Usage

Put your collectors and user_scripts in `src` folder and create a bosh release.
We are using submodules, so you have to run:

```
git submodule init
git submodule update
```

By default all collectors shipped with Diamond are available.


To use this bosh release, first upload it to your bosh:

```
bosh target BOSH_HOST
git clone https://github.com/springerpe/diamond-boshrelease.git
cd diamond-boshrelease
bosh upload release releases/diamond-1.yml
```

