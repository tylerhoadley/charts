{{- /* The main container included in the controller */ -}}
{{- define "common.controller.replicas" -}}
{{- if or (not .Values.replicas) (.Values.replicas) }}
{{- if or (not .Values.autoscaling) (.Values.autoscaling) }}
{{- if not .Values.autoscaling.enabled }}
replicas: {{ .Values.controller.replicas }}
{{- end }}
{{- end }}
{{- end }}
{{- end -}}
