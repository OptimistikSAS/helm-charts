# Building & Releasing

This repo hosts Helm charts (currently [charts/oibus](charts/oibus)) published via
[chart-releaser](https://github.com/helm/chart-releaser) to GitHub Pages/Releases.

## Prerequisites

- [Helm](https://helm.sh/) 3.16.1 (pinned to match CI, see `.github/workflows/ci.yaml`)
- [helm-docs](https://github.com/norwoodj/helm-docs) 1.14.2 — regenerates each chart's `README.md`
- [chart-testing (ct)](https://github.com/helm/chart-testing) 3.11.0 — lint/install checks

The easiest way to get all of these is the devcontainer (see below). If you'd rather install
them locally, `.devcontainer/post-create.sh` shows the exact download commands and versions.

## Using the devcontainer

Open the repo in VS Code and choose **Reopen in Container** (or use the GitHub Codespaces /
`devcontainer up` CLI). `.devcontainer/devcontainer.json` provisions:

- A Python 3.13 base image
- Helm 3.16.1 (via the `kubectl-helm-minikube` devcontainer feature)
- `helm-docs` and `ct`, installed by `.devcontainer/post-create.sh` on container creation

Once the container is built, `helm`, `helm-docs` and `ct` are all on `PATH`.

### Regenerating chart docs

Each chart's `README.md` is generated from `README.md.gotmpl` + `Chart.yaml` + `values.yaml`
(with comments in `values.yaml` feeding the parameters table). After changing any of those
files, regenerate the docs from the repo root:

```bash
helm-docs
```

This rewrites `charts/oibus/README.md` in place. Commit the regenerated file — CI's `lint-docs`
job (`.github/helm-docs.sh`) runs the same command and fails the build if `README.md` is out of
date (`git diff --exit-code` after running `helm-docs`).

### Linting and testing a chart locally

These mirror the `ci.yaml` workflow and are useful before opening a PR:

```bash
# Lint (chart-testing)
ct lint --config .github/ct.yaml

# Render templates and validate against the Kubernetes API schema
helm template charts/oibus --values charts/oibus/ci/<some-values-file>.yaml

# Full install test against a local kind cluster (requires kind)
ct install --config .github/ct.yaml --all
```

## Creating a new release

Releases are automated by `.github/workflows/release.yaml` (chart-releaser-action) and require
no manual tagging or GitHub release creation — you only need to bump the chart version:

1. Make your chart changes (templates, `values.yaml`, etc.) on a branch/PR.
2. Bump `version` in `charts/oibus/Chart.yaml` (follow semver; bump `appVersion` too if the
   underlying OIBus image version changed).
3. Regenerate docs if `values.yaml` changed:
   ```bash
   helm-docs
   ```
4. Commit the version bump (and regenerated `README.md`) and open a PR against `main`.
5. Once the PR is merged to `main` (and the change touches `charts/**`), the **Release Charts**
   workflow runs automatically:
   - Builds chart dependencies (`helm dependency build`)
   - Packages the chart and publishes it as a GitHub Release using `chart-releaser`
   - Updates the Helm repo index consumed by users via `helm repo add`

You can also trigger the release workflow manually from the **Actions** tab
(`workflow_dispatch`) if needed, e.g. to re-run a publish for an existing tag
(`CR_SKIP_EXISTING: true` means it won't fail if that chart version was already released).

> Note: chart-testing's `check-version-increment` is disabled in `.github/ct.yaml`, so CI will
> not stop you from forgetting to bump the version — double-check `Chart.yaml` before merging.
