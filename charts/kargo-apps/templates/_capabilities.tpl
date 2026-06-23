{{/* Allow KubeVersion to be overridden. */}}
{{- define "common.capabilities.ingress.kubeVersion" -}}
  {{- default .Capabilities.KubeVersion.Version .Values.kubeVersionOverride -}}
{{- end -}}

{{/* Return the appropriate apiVersion for Ingress objects */}}
{{- define "common.capabilities.ingress.apiVersion" -}}
  {{- print "networking.k8s.io/v1" -}}
  {{- if semverCompare "<1.19" (include "common.capabilities.ingress.kubeVersion" .) -}}
    {{- print "beta1" -}}
  {{- end -}}
{{- end -}}

{{/* Check Ingress stability */}}
{{- define "common.capabilities.ingress.isStable" -}}
  {{- if eq (include "common.capabilities.ingress.apiVersion" .) "networking.k8s.io/v1" -}}
    {{- true -}}
  {{- end -}}
{{- end -}}
{{/* vim: set filetype=mustache: */}}

{{/* Allow KubeVersion to be overridden. */}}
{{- define "common.capabilities.httproute.kubeVersion" -}}
  {{- default .Capabilities.KubeVersion.Version .Values.kubeVersionOverrideHTTPRoute -}}
{{- end -}}

{{/* Return the appropriate apiVersion for Ingress objects */}}
{{- define "common.capabilities.httproute.apiVersion" -}}
  {{- print "gateway.networking.k8s.io/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for Ingress objects */}}
{{- define "common.capabilities.kargo.apiVersion" -}}
  {{- print "kargo.akuity.io/v1alpha1" -}}
{{- end -}}

{{/* Check Ingress stability */}}
{{- define "common.capabilities.httproute.isStable" -}}
  {{- if eq (include "common.capabilities.httproute.apiVersion" .) "gateway.networking.k8s.io/v1" -}}
    {{- true -}}
  {{- end -}}
{{- end -}}
{{/* vim: set filetype=mustache: */}}

{{/*
Return the target Kubernetes version
*/}}
{{- define "common.capabilities.kubeVersion" -}}
{{- if .Values.global }}
    {{- if .Values.global.kubeVersion }}
    {{- .Values.global.kubeVersion -}}
    {{- else }}
    {{- default .Capabilities.KubeVersion.Version .Values.kubeVersion -}}
    {{- end -}}
{{- else }}
{{- default .Capabilities.KubeVersion.Version .Values.kubeVersion -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for poddisruptionbudget.
*/}}
{{- define "common.capabilities.policy.apiVersion" -}}
{{- if semverCompare "<1.21-0" (include "common.capabilities.kubeVersion" .) -}}
{{- print "policy/v1beta1" -}}
{{- else -}}
{{- print "policy/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for networkpolicy.
*/}}
{{- define "common.capabilities.networkPolicy.apiVersion" -}}
{{- if semverCompare "<1.7-0" (include "common.capabilities.kubeVersion" .) -}}
{{- print "extensions/v1beta1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for cronjob.
*/}}
{{- define "common.capabilities.cronjob.apiVersion" -}}
{{- if semverCompare "<1.21-0" (include "common.capabilities.kubeVersion" .) -}}
{{- print "batch/v1beta1" -}}
{{- else -}}
{{- print "batch/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for daemonset.
*/}}
{{- define "common.capabilities.daemonset.apiVersion" -}}
{{- if semverCompare "<1.14-0" (include "common.capabilities.kubeVersion" .) -}}
{{- print "extensions/v1beta1" -}}
{{- else -}}
{{- print "apps/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for deployment.
*/}}
{{- define "common.capabilities.deployment.apiVersion" -}}
{{- if semverCompare "<1.14-0" (include "common.capabilities.kubeVersion" .) -}}
{{- print "extensions/v1beta1" -}}
{{- else -}}
{{- print "apps/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for statefulset.
*/}}
{{- define "common.capabilities.statefulset.apiVersion" -}}
{{- if semverCompare "<1.14-0" (include "common.capabilities.kubeVersion" .) -}}
{{- print "apps/v1beta1" -}}
{{- else -}}
{{- print "apps/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for ingress.
*/}}
{{/*

{{- define "common.capabilities.ingress.apiVersion" -}}
{{- if .Values.ingress -}}
{{- if .Values.ingress.apiVersion -}}
{{- .Values.ingress.apiVersion -}}
{{- else if semverCompare "<1.14-0" (include "common.capabilities.kubeVersion" .) -}}
{{- print "extensions/v1beta1" -}}
{{- else if semverCompare "<1.19-0" (include "common.capabilities.kubeVersion" .) -}}
{{- print "networking.k8s.io/v1beta1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1" -}}
{{- end }}
{{- else if semverCompare "<1.14-0" (include "common.capabilities.kubeVersion" .) -}}
{{- print "extensions/v1beta1" -}}
{{- else if semverCompare "<1.19-0" (include "common.capabilities.kubeVersion" .) -}}
{{- print "networking.k8s.io/v1beta1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1" -}}
{{- end -}}
{{- end -}}
*/}}


{{/*
Return the appropriate apiVersion for RBAC resources.
*/}}
{{- define "common.capabilities.rbac.apiVersion" -}}
{{- if semverCompare "<1.17-0" (include "common.capabilities.kubeVersion" .) -}}
{{- print "rbac.authorization.k8s.io/v1beta1" -}}
{{- else -}}
{{- print "rbac.authorization.k8s.io/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for CRDs.
*/}}
{{- define "common.capabilities.crd.apiVersion" -}}
{{- if semverCompare "<1.19-0" (include "common.capabilities.kubeVersion" .) -}}
{{- print "apiextensions.k8s.io/v1beta1" -}}
{{- else -}}
{{- print "apiextensions.k8s.io/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for APIService.
*/}}
{{- define "common.capabilities.apiService.apiVersion" -}}
{{- if semverCompare "<1.10-0" (include "common.capabilities.kubeVersion" .) -}}
{{- print "apiregistration.k8s.io/v1beta1" -}}
{{- else -}}
{{- print "apiregistration.k8s.io/v1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for Horizontal Pod Autoscaler.
*/}}
{{- define "common.capabilities.hpa.apiVersion" -}}
{{- if semverCompare "<1.23-0" (include "common.capabilities.kubeVersion" .) -}}
{{- print "autoscaling/v2beta1" -}}
{{- else -}}
{{- print "autoscaling/v2" -}}
{{- end -}}
{{- end -}}



{{/*
Return the appropriate apiVersion for Vertical Pod Autoscaler.
*/}}
{{- define "common.capabilities.vpa.apiVersion" -}}
{{- if semverCompare "<1.23-0" (include "common.capabilities.kubeVersion" .context) -}}
{{- if .beta2 -}}
{{- print "autoscaling/v2beta2" -}}
{{- else -}}
{{- print "autoscaling/v2beta1" -}}
{{- end -}}
{{- else -}}
{{- print "autoscaling/v2" -}}
{{- end -}}
{{- end -}}

{{/*
Returns true if the used Helm version is 3.3+.
A way to check the used Helm version was not introduced until version 3.3.0 with .Capabilities.HelmVersion, which contains an additional "{}}"  structure.
This check is introduced as a regexMatch instead of {{ if .Capabilities.HelmVersion }} because checking for the key HelmVersion in <3.3 results in a "interface not found" error.
**To be removed when the catalog's minimun Helm version is 3.3**
*/}}
{{- define "common.capabilities.supportsHelmVersion" -}}
{{- if regexMatch "{(v[0-9])*[^}]*}}$" (.Capabilities | toString ) }}
  {{- true -}}
{{- end -}}
{{- end -}}




{{/*
Returns the suspend option if proper version and is set
*/}}
{{- if semverCompare ">1.21-0" (include "common.capabilities.kubeVersion" .) }}
{{- if .Values.suspend }}  
suspend: {{ .Values.suspend }}  
{{- else }}  
suspend: false
{{- end }}
{{- end }}