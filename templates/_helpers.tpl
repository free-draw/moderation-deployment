{{ define "connectionUrl.mongodb" -}}
{{- $url := urlParse .Values.mongodb.url -}}
{{- if .Values.mongodb.tls.enabled -}}
{{- $query := splitList "&" $url.query -}}
{{- $query := append $query "tls=true" -}}
{{- $query := append $query (printf "tlsCAFile=%s" (urlquery "/etc/certs/mongodb/mongodb.ca")) -}}
{{- $_ := set $url "query" (join "&" $query) -}}
{{- end -}}
{{- urlJoin $url -}}
{{- end }}

{{ define "connectionUrl.redis" -}}
{{- .Values.redis.url -}}
{{- end }}

{{ define "certificateSource.type" -}}
{{- if .enabled -}}
{{- if .configMap -}}
{{- if .secret -}}
{{- fail "configMap and secret cannot be defined simultaneously" -}}
{{- end -}}
{{- print "configMap" -}}
{{- else if .secret }}
{{- print "secret" -}}
{{ else }}
{{- print "none" -}}
{{- end -}}
{{- else -}}
{{- print "none" -}}
{{- end -}}
{{- end }}

{{ define "certificateSource.name" -}}
{{- $sourceType := include "certificateSource.type" . -}}
{{- if (eq $sourceType "configMap") -}}
{{- print .configMap.name -}}
{{- else if (eq $sourceType "secret") -}}
{{- print .secret.name -}}
{{- end -}}
{{- end }}

{{ define "certificateSource.key" -}}
{{- $sourceType := include "certificateSource.type" . -}}
{{- if (eq $sourceType "configMap") -}}
{{- print .configMap.key -}}
{{- else if (eq $sourceType "secret") -}}
{{- print .secret.key -}}
{{- end -}}
{{- end }}

{{ define "volumes.certs.mongodb" -}}
{{- $sourceType := include "certificateSource.type" .Values.mongodb.tls -}}
{{- if (ne $sourceType "none") -}}
{{- $sourceName := include "certificateSource.name" .Values.mongodb.tls -}}
{{- $sourceKey := include "certificateSource.key" .Values.mongodb.tls -}}
- name: mongodb-cert
{{- if (eq $sourceType "configMap") }}
  configMap:
    name: {{ $sourceName }}
{{- else if (eq $sourceType "secret") }}
  secret:
    secretName: {{ $sourceName }}
{{- end }}
    items:
    - key: {{ $sourceKey }}
      path: mongodb.ca
{{- end -}}
{{- end }}

{{ define "volumeMounts.certs.mongodb" -}}
{{- $sourceType := include "certificateSource.type" .Values.mongodb.tls -}}
{{- if (ne $sourceType "none") -}}
- name: mongodb-cert
  mountPath: "/etc/certs/mongodb"
  readOnly: true
{{- end }}
{{- end }}