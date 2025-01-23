group "default" {
    targets = ["amd64", "arm64"]
}

target "amd64" {
    context = "amd64"
    dockerfile = "Dockerfile"
    platforms = ["linux/amd64"]
    tags = ["ghcr.io/linkinghack/tools/cj-sdk:0.53.13"]
}

target "arm64" {
    context = "arm64"
    dockerfile = "Dockerfile"
    platforms = ["linux/arm64"]
    tags = ["ghcr.io/linkinghack/tools/cj-sdk:0.53.13"]
}
