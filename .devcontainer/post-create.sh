#!/usr/bin/env bash
# Installs the chart-authoring CLIs used by this repo's CI (.github/workflows/ci.yaml,
# .github/helm-docs.sh) so they're available inside the devcontainer.
set -euxo pipefail

case "$(uname -m)" in
  x86_64) HELM_DOCS_ARCH=x86_64; CT_ARCH=amd64 ;;
  aarch64 | arm64) HELM_DOCS_ARCH=arm64; CT_ARCH=arm64 ;;
  *) echo "Unsupported architecture: $(uname -m)" >&2; exit 1 ;;
esac

# renovate: datasource=github-releases depName=helm-docs packageName=norwoodj/helm-docs
HELM_DOCS_VERSION=1.14.2

# renovate: datasource=github-releases depName=chart-testing packageName=helm/chart-testing
CHART_TESTING_VERSION=3.11.0

curl --silent --show-error --fail --location \
  "https://github.com/norwoodj/helm-docs/releases/download/v${HELM_DOCS_VERSION}/helm-docs_${HELM_DOCS_VERSION}_Linux_${HELM_DOCS_ARCH}.tar.gz" \
  | sudo tar -C /usr/local/bin -xz helm-docs

curl --silent --show-error --fail --location \
  --output /tmp/chart-testing.tar.gz \
  "https://github.com/helm/chart-testing/releases/download/v${CHART_TESTING_VERSION}/chart-testing_${CHART_TESTING_VERSION}_linux_${CT_ARCH}.tar.gz"
sudo tar -C /usr/local/bin -xz -f /tmp/chart-testing.tar.gz ct
# ct looks up chart_schema.yaml/lintconf.yaml in cwd, $HOME/.ct, or /etc/ct (in that order)
sudo mkdir -p /etc/ct
sudo tar -C /etc/ct -xz -f /tmp/chart-testing.tar.gz --strip-components=1 etc/chart_schema.yaml etc/lintconf.yaml
rm /tmp/chart-testing.tar.gz

helm-docs --version
ct version
helm version
