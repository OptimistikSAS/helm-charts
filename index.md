# Optimistik

[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/optimistiksas/helm-charts?style=for-the-badge)](https://github.com/optimistiksas/helm-charts/releases/latest)
[![GitHub License](https://img.shields.io/github/license/optimistiksas/helm-charts?style=for-the-badge)](https://github.com/OptimistikSAS/helm-charts/raw/refs/heads/main/LICENSE)


This repository hosts Optimistik's [Helm](https://helm.sh) charts. Chart documentation is automatically generated using [helm-docs](https://github.com/norwoodj/helm-docs)

## Add Helm repository

```bash
helm repo add optimistik https://optimistiksas.github.io/helm-charts
helm repo update
```

## Install chart

### OIBus

```bash
helm install --generate-name optimistik/oibus
```
