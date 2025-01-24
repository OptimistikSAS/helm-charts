# oibus

![Version: 3.5.7](https://img.shields.io/badge/Version-3.5.7-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v3.4.6](https://img.shields.io/badge/AppVersion-v3.4.6-informational?style=flat-square)

OIBus - Data collection solution

**Homepage:** <https://github.com/OptimistikSAS/OIBus>

## Installation

### Add Helm repository

```shell
helm repo add optimistik https://optimistiksas.github.io/helm-charts
helm repo update
```

## Install OIBus chart

```bash
helm install --generate-name optimistik/oibus
```

## Configuration

The following table lists the configurable parameters of the chart and the default values.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/optimistiksas/oibus"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | string | `nil` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.httpGet.path | string | `"/api/status"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| livenessProbe.initialDelaySeconds | int | `3` |  |
| livenessProbe.periodSeconds | int | `3` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| oibus.persistence | object | `{"data":{"enabled":true,"labels":{},"storageClass":"","storageSize":"1Gi","volumeName":""}}` | Options related to persistence |
| oibus.persistence.data.enabled | bool | `true` | Allow the data to persist between pod renewal |
| oibus.persistence.data.labels | object | `{}` | Labels to set on the data PVC |
| oibus.persistence.data.storageClass | string | `""` | Storage class of the data PVC |
| oibus.persistence.data.storageSize | string | `"1Gi"` | Storage size of the data PVC Mi or Gi |
| oibus.persistence.data.volumeName | string | `""` | Existing volume, enables binding the pvc to an existing volume |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| readinessProbe.httpGet.path | string | `"/api/status"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| readinessProbe.initialDelaySeconds | int | `10` |  |
| readinessProbe.periodSeconds | int | `3` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.port | int | `2223` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automount | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |

## Upgrading

A major chart version change can indicate that there is an incompatible breaking change needing manual actions.

_No recent breaking changes needing manual actions._
