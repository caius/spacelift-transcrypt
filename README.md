# Spacelift Transcrypt

Spacelift plus [Transcrypt][], for decrypting secret things in your git repo.

Based on the base AWS spacelift image, with transcrypt & dependencies added to save re-downloading every run.

## Usage

The Spacelift Stack needs a couple of configuration options setting to have the decrypted files available in your runs. These settings can be configured from:

- [Runtime Configuration] using `spacelift/config.yml` in the repo
- Spacelift Context attached to your stack
- Spacelift UI -> Stack -> Settings -> Behaviour page (click Advanced for phase hooks)
- Spacelift's Terraform Provider / API, in the `spacelift_stack` resource

[Runtime Configuration]: https://docs.spacelift.io/concepts/configuration/runtime-configuration/

Setting it via the `config.yml` is most flexible, because you can test out changes in pull requests before merging down. (As suggested by the [Spacelift docs][runtime config suggestion].)

[runtime config suggestion]: https://docs.spacelift.io/concepts/configuration/runtime-configuration/#purpose-of-runtime-configuration

Firstly the `runner_image` needs setting to `ghcr.io/caius/spacelift-transcrypt:latest` (or pin a specific SHA[^1] instead of `latest` to control updates.)

[^1]: <https://github.com/caius/spacelift-transcrypt/pkgs/container/spacelift-transcrypt/versions?filters%5Bversion_type%5D=tagged> lists all available SHA tags for the image.

Secondly, the `before_init` hook needs the transcrypt hydration command adding from `transcrypt --display` in your repo locally. For example, with the default cipher:

```shell
transcrypt -c aes-256-cbc -p $TRANSCRYPT_PASSWORD
```

The `TRANSCRYPT_PASSWORD` environment variable needs setting in the Spacelift stack, either directly on the Stack or via an attached Context.

## License

See [LICENSE](./LICENSE) file.
