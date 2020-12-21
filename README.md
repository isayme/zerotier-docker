# Docker for Zerotier
There not offical docker image for zerotier.

The Dockerfile modified from https://github.com/zerotier/ZeroTierOne/blob/master/ext/installfiles/linux/zerotier-containerized/Dockerfile

# How to use

```
docker run \
  --name=zerotier \
  --device=/dev/net/tun \
  --net=host \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_ADMIN \
  -d -v /var/lib/zerotier-one:/var/lib/zerotier-one \
  --restart unless-stopped \
  isayme/zerotier
```
