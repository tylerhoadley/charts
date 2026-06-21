{{- define "common.affinities.pods.soft" -}}
preferredDuringSchedulingIgnoredDuringExecution:
  - podAffinityTerm:
     labelSelector:
       matchLabels:
         {{- include "common.labels.selectorLabels" . | nindent 12 }}
      topologyKey:  {{ .topologyKey | default "kubernetes.io/hostname" -}}
    weight: 1
{{- end -}}

{{- define "common.affinities.pods.hard" -}}
requiredDuringSchedulingIgnoredDuringExecution:
 - labelSelector:
     matchLabels:
       {{- include "common.labels.selectorLabels" . | nindent 12 }}
    topologyKey:  {{ .topologyKey | default "kubernetes.io/hostname" -}}

{{- end -}}

{{- define "common.affinities.pods" -}}
  {{- if eq .type "soft" }}
    {{- include "common.affinities.pods.soft" . -}}
  {{- else if eq .type "hard" }}
    {{- include "common.affinities.pods.hard" . -}}
  {{- end -}}
{{- end -}}