Openwrt/LEDE image builder for ar71xx/nand
===

## Run

```
docker run -it \
       --dns=[DNS ADDRESS] \
       --rm \
       -v $PWD/output:/build_root/bin/targets/ar71xx/nand/ \
       -v $PWD/cust_cfg:/build_root/cust_cfg \
       -v $PWD/files:/build_root/files \
       jemyzhang/lede-imagebuilder-ar71xx-nand
```
