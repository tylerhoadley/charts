{{/*
This template serves as a blueprint for horizontal pod autoscaler objects that are created
using the common library.
*/}}
{{- define "common.classes.pdb" -}}
  {{- if .Values.pdb -}}
  {{- if .Values.pdb.enabled -}}
    {{- $pdbName := include "common.names.fullname" . -}}
    {{- $targetName := include "common.names.fullname" . }}
---
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: {{ $pdbName }}
  labels: {{- include "common.labels" $ | nindent 4 }}
  annotations: {{- include "common.annotations" $ | nindent 4 }}
spec:
  {{- if and .Values.pdb.maxUnavailable (not .Values.pdb.minAvailable) }}
  maxUnavailable: {{ .Values.pdb.maxUnavailable }}
  {{- else }}
  minAvailable: {{ .Values.pdb.minAvailable | default "1" }}
  {{- end }}
  selector:
    matchLabels:
      app.kubernetes.io/name: {{ include "common.names.fullname" . }}
  {{- end -}}
  {{- end -}}
{{- end -}}
