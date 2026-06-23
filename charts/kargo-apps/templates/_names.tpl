{{/* Expand the name of the chart */}}
{{- define "common.names.name" -}}
  {{- $globalNameOverride := "" -}}
  {{- if hasKey .Values "global" -}}
    {{- $globalNameOverride = (default $globalNameOverride .Values.global.nameOverride) -}}
  {{- end -}}
  {{- default .Chart.Name (default .Values.nameOverride $globalNameOverride) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "common.names.fullname" -}}
  {{- $name := include "common.names.name" . -}}
  {{- $globalFullNameOverride := "" -}}
  {{- if hasKey .Values "global" -}}
    {{- $globalFullNameOverride = (default $globalFullNameOverride .Values.global.fullnameOverride) -}}
  {{- end -}}
  {{- if or .Values.fullnameOverride $globalFullNameOverride -}}
    {{- $name = default .Values.fullnameOverride $globalFullNameOverride -}}
  {{- else -}}
    {{- if contains $name .Release.Name -}}
      {{- $name = .Release.Name -}}
    {{- else -}}
      {{- $name = printf "%s-%s" .Release.Name $name -}}
    {{- end -}}
  {{- end -}}
  {{- trunc 63 $name | trimSuffix "-" -}}
{{- end -}}

{{/* Create chart name and version as used by the chart label */}}
{{- define "common.names.chart" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Create the name of the ServiceAccount to use */}}
{{- define "common.names.serviceAccountName" -}}
  {{- if .Values.serviceAccount.create -}}
    {{- default (include "common.names.fullname" .) .Values.serviceAccount.name -}}
  {{- else -}}
    {{- default "default" .Values.serviceAccount.name -}}
  {{- end -}}
{{- end -}}

{{/*
Determine the deterministic Project Name boundary.
- If the current key is literal "kargo-project", it uses .Release.Name as the baseline.
- It then appends any local suffix/prefix specified under the project configuration map.
- Respects explicit global or local overrides if defined.
*/}}
{{- define "common.names.kargoProjectName" -}}
  {{- $root := index . 0 -}}
  {{- $currentKey := index . 1 -}}
  
  {{- $computedName := $currentKey -}}
  {{- if eq $currentKey "kargo-project" -}}
    {{- $projectData := index $root.Values.project $currentKey -}}
    {{- $prefix := default "" $projectData.namePrefix -}}
    {{- $suffix := default "" $projectData.nameSuffix -}}
    {{- $computedName = printf "%s%s%s" $prefix $root.Release.Name $suffix -}}
  {{- end -}}
  
  {{- $globalOverride := "" -}}
  {{- if hasKey $root.Values "global" -}}
    {{- $globalOverride = (default $globalOverride $root.Values.global.kargoProjectNameOverride) -}}
  {{- end -}}
  
  {{- default $computedName (default $root.Values.kargoProjectNameOverride $globalOverride) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
