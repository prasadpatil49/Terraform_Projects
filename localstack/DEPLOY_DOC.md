### Setup local AWS emulator using Podman:

Run local stack on podman
```
podman run --rm -it -p 4566:4566 -p 4510-4559:4510-4559 localstack/localstack
```

Verify local stack API
```
aws --endpoint-url=http://localhost:4566  s3 ls
```
