# Build vagrant baseboxes using packer

## Currently supported

- Debian Jessie
- qemu and virtualbox

## Customization

- puppet, facter are pre-installed

## Building locally

This example builds only for the qemu provider.

    packer build -only=qemu jessie.json


### Issues

#### not enough space in /tmp

The vagrant post-processor uses `/tmp` as default temp dir, and needs ~10gb of diskspace,
otherwise it will fail like this:

    Post-processor failed: write /tmp/packer845144867/box.img: no space left on device

You can circumvent this problem exporting this variable before building:

    export PACKER_TMP=.

BUT you need to build packer itself from source because this variable isn't read by the latest packer available as package (0.8.6).
I only got latest packer HEAD compiled after a [dirty hack i documented here](https://github.com/mitchellh/packer/issues/3086).

#### Atlas post-processors fail without Atlas API token

You need to `remove both atlas post-processors` in the `jessie.json` file if you have not configured any Atlas API token.
