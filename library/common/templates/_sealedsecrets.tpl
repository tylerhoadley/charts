{{/*
The Secret object to be created.
*/}}
{{- define "common.sealedsecrets" }}
---
apiVersion: bitnami.com/v1alpha1
kind: SealedSecret
metadata:
  name: {{ include "common.names.fullname" . }}
  labels: {{- include "common.labels" $ | nindent 4 }}
  annotations: {{- include "common.annotations" $ | nindent 4 }}
    sealedsecrets.bitnami.com/cluster-wide: "true"
spec:
  encryptedData:
  {{- range $key, $val := .Values.sealedSecrets }}
    {{ $key }}: {{ $val | quote }}
  {{- end }}
  template:
    data: null
    metadata:
      labels:
        {{- include "common.labels" . | nindent 8 }}
      annotations:
        {{- include "common.annotations" . | nindent 8 }}
        sealedsecrets.bitnami.com/cluster-wide: "true"
      creationTimestamp: null
      name: {{ include "common.names.fullname" . }}-sealed-secrets

{{- end }}
