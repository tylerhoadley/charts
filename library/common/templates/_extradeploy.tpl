{{/*
The Secret object to be created.
*/}}
{{- define "common.extradeploy" }}
{{- range .Values.extraDeploy -}}
---
{{ toYaml . }}
---
{{- end -}}


{{- end }}
