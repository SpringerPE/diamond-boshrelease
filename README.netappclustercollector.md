# BOSH Release for diamond

https://github.com/python-diamond/


## Usage

To use this bosh release, first upload it to your bosh:

```
bosh target BOSH_HOST
git clone https://github.com/springerpe/diamond-boshrelease.git
cd diamond-boshrelease
bosh upload release releases/diamond-1.yml
```

### Setup

Example, to send metrics to graphite using OntaClusterCollector:
https://github.com/SpringerPE/diamond-ontapclustercollector


```
properties:
  diamond.handlers:
      diamond.handler.graphite.GraphiteHandler:
        host: 127.0.0.1
        port: 2003
        timeout: 15
        batch: 1
  diamond.collector.hostname: netappcollector
  diamond.collector.interval: 60
  diamond.collectors_config:
      OntaClusterCollector: |
        enabled = True
        path_prefix = netapp
        reconnect = 60
        hostname_method = none
        splay = 15
        interval = 45
        [devices]
            [[cluster]]
            ip = 127.0.0.1
            user = admin
            password = admin
            publish = 1

                [[[aggregate=nodes.${node_name}.aggr.${instance_name}]]]
                total_transfers = rate_ops
                user_reads = rate_ops_reads
                user_writes = rate_ops_writes
                cp_reads = rate_ops_cp_reads
                user_reads_ssd = rate_ops_reads_ssd
                user_writes_ssd = rate_ops_writes_sdd
                cp_reads_sdd = rate_ops_cp_reads_sdd
                user_read_blocks = rate_blocks_user_reads
                user_write_blocks = rate_blocks_user_writes
                cp_read_blocks = rate_blocks_cp_reads
                user_read_blocks_ssd = rate_blocks_user_reads_sdd
                user_write_blocks_ssd = rate_blocks_user_writes_sdd
                cp_read_blocks_ssd = rate_blocks_cp_reads_ssd
                wv_fsinfo_blks_used = blocks_used
                wv_fsinfo_blks_total = blocks_total

                [[[disk=nodes.${node_name}.aggr.${raid_group}.${instance_name}]]]
                disk_speed = rpm
                total_transfers = rate_iops
                user_reads = rate_ops_reads
                user_writes = rate_ops_writes
                cp_reads = rate_read_cp
                disk_busy = pct_busy
                io_pending = avg_iops_pending
                io_queued = avg_iops_queued
                user_write_blocks = rate_blocks_write
                user_write_latency = avg_latency_micros_write
                user_read_blocks = rate_blocks_read
                user_read_latency = avg_latency_micros_read
                cp_read_blocks = rate_blocks_cp_read
                cp_read_latency = avg_latency_micros_cp_read
                [[[processor=nodes.${node_name}.processor.${instance_name}]]]
                processor_busy = pct_busy
                processor_elapsed_time = time_elapsed
                domain_busy = -

                [[[system:node=nodes.${instance_name}.system]]]
                nfs_ops = rate_ops_nfs
                cifs_ops = rate_ops_cifs
                fcp_ops = rate_ops_fcp
                iscsi_ops = rate_ops_iscsi
                read_ops = rate_ops_read
                write_ops = rate_ops_write
                iscsi_data_recv = rate_kbytes_iscsi_recv
                iscsi_data_sent = rate_kbytes_iscsi_sent
                net_data_recv = rate_kbytes_net_recv
                net_data_sent = rate_kbytes_net_sent
                fcp_data_recv = rate_kbytes_fcp_recv
                fcp_data_sent = rate_kbytes_fcp_sent
                read_data = rate_kbytes_disk_read
                write_data = rate_kbytes_disk_written
                ssd_data_read = rate_kbytes_ssd_data_read
                ssd_data_written = rate_kbytes_ssd_data_written
                total_data = rate_kbytes_total_data
                write_latency = avg_latency_ms_write
                read_latency = avg_latency_ms_read
                total_latency = avg_latency_ms
                total_ops = rate_ops
                memory = total_memory
                idle = pct_cpu_idle
                cpu_busy = pct_cpu_busy
                cpu_elapsed_time = base_time_cpu_elapsed
                avg_processor_busy = pct_processors_all_avg_busy
                total_processor_busy = pct_processors_all_total_busy

                [[[ip=nodes.${node_name}.ip.${instance_name}]]]
                sent_packets = pkts_sent
                recv_packets = pkts_recv
                recv_bad_checksum = pkts_bad_checksum_recv
                reassembly_queue_overflow = pkts_overflow_dropped
                fragments_drops = fragments_dropped

                [[[fcp_port=nodes.${node_name}.fc.${instance_name}]]]
                avg_read_latency = avg_latency_micros_read
                avg_write_latency = avg_latency_micros_write
                queue_full = delta_queue_full

                [[[lif=nodes.${node_name}.net.${instance_name}]]]
                recv_packet = rate_pkts_recv
                recv_errors = rate_recv_errors
                sent_packet = rate_pkts_sent
                sent_errors = rate_sent_errors
                recv_data = rate_bytes_recv
                sent_data = rate_bytes_sent

                [[[client=nodes.${node_name}.client.${instance_name}]]]
                rx_data = rate_bytes_rx
                rx_packets = packets_rx
                tx_data = rate_bytes_tx
                tx_packets = packets_tx

                [[[ext_cache_obj=nodes.${node_name}.ext_cache.${instance_name}]]]
                usage = pct_usage_blocks
                accesses = cnt_delta_accesses
                blocks = cnt_blocks
                disk_reads_replaced = rate_disk_replaced_readio
                hit = rate_hit_buffers
                hit_flushq = rate_flushq_hit_buffers
                hit_once = rate_once_hit_buffers
                hit_age = rate_age_hit_buffers
                miss = rate_miss_buffers
                miss_flushq = rate_flushq_miss_buffers
                miss_once = rate_once_miss_buffers
                miss_age = rate_age_miss_buffers
                hit_percent = pct_hit
                inserts = rate_inserts_buffers
                inserts_flushq = rate_flushq_inserts_buffers
                inserts_once = rate_once_inserts_buffers
                inserts_age = rate_age_inserts_buffers
                reuse_percent = pct_reuse
                evicts = rate_evicts_blocks
                evicts_ref = rate_ref_evicts_blocks
                invalidates = rate_invalidates_blocks

                [[[wafl=nodes.${node_name}.${instance_name}]]]
                name_cache_hit = rate_cache_hits
                total_cp_msecs = cnt_msecs_spent_cp
                wafl_total_blk_writes = rate_blocks_written
                wafl_total_blk_readaheads = rate_blocks_readaheads
                wafl_total_blk_reads = rate_blocks_read

                # New object
                [[[workload_volume=vservers.${data_object_type}.${data_object_name}]]]
                ops = rate_ops
                read_data = rate_bytes_read
                read_latency = avg_latency_micros_read
                read_ops = rate_ops_read
                read_io_type_base = -
                write_data = rate_bytes_write
                write_latency = avg_latency_micros_write
                write_ops = rate_ops_write

                [[[nfsv4=vservers.${instance_name}.nfsv4]]]
                write_avg_latency = avg_latency_micros_write
                read_avg_latency = avg_latency_micros_read
                total_ops = rate_ops
                nfsv4_ops = rate_nfsv4_ops
                nfs4_read_throughput = rate_throughput_nfs4_read
                nfs4_write_throughput = rate_throughput_nfs4_write
                read_percent = pct_read_ops
                write_percent = pct_write_ops

                [[[nfsv4_1=vservers.${instance_name}.nfsv41]]]
                write_avg_latency = avg_latency_micros_write
                read_avg_latency = avg_latency_micros_read
                total_ops = rate_ops
                nfsv4_1_ops = rate_nfsv41_ops
                nfs41_read_throughput = rate_throughput_nfs41_read
                nfs41_write_throughput = rate_throughput_nfs41_write
                read_percent = pct_read_ops
                write_percent = pct_write_ops

                [[[nfsv3=vservers.${instance_name}.nfsv3]]]
                nfsv3_ops = rate_ops_nfsv3
                nfsv3_read_ops = rate_ops_nfsv3_read
                nfsv3_write_ops = rate_ops_nfsv3_write
                read_total = cnt_ops_read
                write_total = cnt_ops_write
                write_avg_latency = avg_latency_micros_nfsv3_write
                read_avg_latency = avg_latency_micros_nfsv3_read
                nfsv3_write_throughput = rate_throughput_nfsv3_write
                nfsv3_read_throughput = rate_throughput_nfsv3_read
                nfsv3_throughput = rate_throughput_nfsv3
                nfsv3_dnfs_ops = rate_ops_nfsv3_oracle

                [[[iscsi_lif:vserver=vservers.${instance_name}.iscsi]]]
                iscsi_read_ops = rate_ops_iscsi_read
                iscsi_write_ops = rate_ops_iscsi_write
                avg_write_latency = avg_latency_micros_iscsi_write
                avg_read_latency = avg_latency_micros_iscsi_read
                avg_latency = avg_latency_micros_iscsi
                data_in_sent = cnt_blocks_recv
                data_out_blocks = cnt_blocks_sent

                [[[cifs=vservers.${instance_name}.cifs]]]
                cifs_ops = rate_ops_cifs
                cifs_read_ops = rate_ops_cifs_read
                cifs_write_ops = rate_ops_cifs_write
                cifs_latency = avg_latency_micros_cifs
                cifs_write_latency = avg_latency_micros_cifs_write
                cifs_read_latency = avg_latency_micros_cifs_read
                connected_shares = cnt_cifs_connected_shares
                reconnection_requests_total = cnt_cifs_reconnection_requests_total

```


For [bosh-lite](https://github.com/cloudfoundry/bosh-lite), you can quickly create a deployment manifest & deploy the release:

```
templates/make_manifest warden
bosh -n deploy
```

For AWS EC2, create a single VM:

```
templates/make_manifest aws-ec2
bosh -n deploy
```

For OpenStack, create a single VM:

```
templates/make_manifest openstack templates/example-properties.yml
bosh -n deploy
```

