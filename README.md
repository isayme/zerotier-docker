# Docker for Zerotier

![Docker Image Version (latest semver)](https://img.shields.io/docker/v/isayme/zerotier?sort=semver)
![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/isayme/zerotier?sort=semver)

There no offical docker image for zerotier.

This Dockerfile modified from https://github.com/zerotier/ZeroTierOne/blob/master/ext/installfiles/linux/zerotier-containerized/Dockerfile

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
