The service handling moderation for all projects under the Free Draw name.

# Configuration

## Options

Name | Description | Default | Required
--- | --- | --- | ---
host | Host to configure built-in ingress to use | *null* | No
jwt | JWT override | *null* | No
discord.clientId | Discord client ID | *null* | **Yes**
discord.clientSecret | Discord client secret | *null* | **Yes**
discord.token | Discord bot token | *null* | **Yes**
discord.redirectUrl | Discord OAuth2 redirect URL | *null* | **Yes**

## MongoDB Connection Options

Name | Description | Default | Required
--- | --- | --- | ---
mongodb.url | URL to use to connect to MongoDB | *null* | **Yes**
mongodb.tls.enabled | Should TLS be used to connect to MongoDB? | `false` | No
mongodb.tls.configMap.name | TLS certificate ConfigMap name | *null* | No
mongodb.tls.configMap.key | TLS certificate ConfigMap key | *null* | No
mongodb.tls.secret.name | TLS certificate Secret name | *null* | No
mongodb.tls.secret.key | TLS certificate Secret key | *null* | No
mongodb.ssl.enabled | Should SSL be used to connect to MongoDB? | `false` | No

## Redis Connection Options

Name | Description | Default | Required
--- | --- | --- | ---
redis.url | URL to use when connecting to Redis | *null* | **Yes**

# Provisioning

TODO

```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install redis bitnami/redis \
	--set master.persistence.enabled=false \
	--set replica.persistence.enabled=false \
	--set metrics.enabled=true \
	--set sentinels.enabled=true
helm install moderation . -f release.yaml
```