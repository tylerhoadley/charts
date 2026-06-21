{{/*
This template serves as a blueprint for horizontal pod autoscaler objects that are created
using the common library.
*/}}
{{- define "common.classes.hpa" -}}
  {{- if .Values.autoscaling -}}
  {{- if .Values.autoscaling.enabled -}}
    {{- $hpaName := include "common.names.fullname" . -}}
    {{- $targetName := include "common.names.fullname" . }}
    {{- $api_version := include "common.capabilities.hpa.apiVersion" . }}
---

apiVersion: {{ $api_version }}
kind: HorizontalPodAutoscaler
metadata:
  name: {{ $hpaName }}
  labels: {{- include "common.labels" $ | nindent 4 }}
  annotations: {{- include "common.annotations" $ | nindent 4 }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: {{ include "common.names.controllerType" . }}
    name: {{ .Values.autoscaling.target | default $targetName }}
  minReplicas: {{ .Values.autoscaling.minReplicas | default 1 }}
  maxReplicas: {{ .Values.autoscaling.maxReplicas | default 3 }}
  metrics:
    {{- if .Values.autoscaling.targetMemoryUtilizationPercentage }}
    - type: Resource
      resource:
        name: memory
        {{- if semverCompare "<1.23-0" (include "common.capabilities.kubeVersion" .) }}
        targetAverageUtilization: {{ .Values.autoscaling.targetMemoryUtilizationPercentage }}
        {{- else }}
        target:
          type: Utilization
          averageUtilization: {{ .Values.autoscaling.targetMemoryUtilizationPercentage }}
        {{- end }}
    {{- end }}
    {{- if .Values.autoscaling.targetCPUUtilizationPercentage }}
    - type: Resource
      resource:
        name: cpu
        {{- if semverCompare "<1.23-0" (include "common.capabilities.kubeVersion" .) }}
        targetAverageUtilization: {{ .Values.autoscaling.targetCPUUtilizationPercentage }}
        {{- else }}
        target:
          type: Utilization
          averageUtilization: {{ .Values.autoscaling.targetCPUUtilizationPercentage }}
        {{- end }}
    {{- end }}
  {{- end -}}
  {{- end -}}
{{- end -}}
