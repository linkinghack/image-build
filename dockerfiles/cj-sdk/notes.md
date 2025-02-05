## 构建方式

hcl 是docker buildx bake 的构建编排配置，但是Docker构建的结果中没有正确处理每个镜像最终的结果，单个arch在仓库中的描述也是一个数组。

最终使用podman 分别对arm64和amd64 结构的镜像进行单独构建。最后手动创建multiarch 镜像的manifest。