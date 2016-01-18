# Build vagrant baseboxes using packer

## Currently supported

- Debian Jessie (8.2)
- qemu (working) and virtualbox (WIP)

## Customization

- puppet, facter are pre-installed

## Building locally

This example builds only for the qemu provider.

    packer build  -only=qemu jessie.json


### Issues

The vagrant post-processor uses `/tmp` as default temp dir, and needs ~10gb of diskspace,
otherwise is will fail like this:

    Post-processor failed: write /tmp/packer845144867/box.img: no space left on device

You can circumvent this problem exporting this variable before building, but you need to build packer itself from
source because this variable isn't read by the latest packer available as package (0.8.6):

    export PACKER_TMP=.


You also need to `remove both atlas postprocessors` in the `jessie.json` file if you have not configured any Atlas API token.
