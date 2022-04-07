# RKE2 ETCD Snapshotting

When would you want to use the cluster reset feature? The docs seem to indicate that this should only be used in the event of a quorum loss. 

## Snapshots

Created by default and stored on etcd nodes at regular intervals here: `/var/lib/rancher/rke2/server/db/snapshots`

### S3 Support

https://docs.rke2.io/backup_restore/#s3-compatible-api-support

Performing an on-demand snapshot to s3 creates a local snapshot in addition to writing to an s3 bucket. If you'd like to just craete a local on-demand snapshot, simply run: `rke2 etcd-snapshot`

Resources: 
- https://docs.rke2.io/backup_restore/

