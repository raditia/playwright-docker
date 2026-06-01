# playwright-chromium-image

Custom Docker image for running Playwright + Chromium in CI with consistent pixel rendering across macOS and Linux.

**Why:** Chromium renders fonts and anti-aliasing differently per OS. Running tests inside this image ensures snapshots created on macOS match what CI produces on Linux — zero false diffs.

## Image

```
ghcr.io/raditia/playwright-chromium-image:latest
ghcr.io/raditia/playwright-chromium-image:1.54.1
```

## What's inside

| Component | Version |
|-----------|---------|
| Playwright | 1.54.1 |
| Chromium | bundled with Playwright |
| Base OS | Ubuntu Jammy (22.04) |
| Node.js | bundled with base image |
| pnpm | 9.15.0 |

## Usage in GitHub Actions

```yaml
jobs:
  visual-regression:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/raditia/playwright-chromium-image:latest
    steps:
      - uses: actions/checkout@v4
      - run: pnpm install --frozen-lockfile
      - run: pnpm test:visual
```

## Bumping Playwright version

1. Update `PLAYWRIGHT_VERSION` in `.github/workflows/publish.yml` and `Dockerfile`
2. Push a new tag: `git tag v<new-version> && git push origin v<new-version>`
3. GHA builds and pushes updated image to `ghcr.io`

## Local build

```bash
docker build \
  --build-arg PLAYWRIGHT_VERSION=1.54.1 \
  --build-arg PNPM_VERSION=9.15.0 \
  -t playwright-chromium-image .
```
