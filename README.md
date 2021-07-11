Install with [Helm](https://helm.sh/).

```
helm install moderation . --namespace moderation \
	--set discord.oauth2.id=APPLICATION_ID_HERE \
	--set discord.oauth2.secret=APPLICATION_SECRET_HERE \
	--set redis.url=REDIS_URL_HERE \
	--set mongodb.url=MONGODB_URL_HERE
```

## Redis

```
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install redis bitnami/redis --namespace moderation \
	--set sentinels.enabled=true \
	--set metrics.enabled=true \
	--set master.persistence.enabled=false \
	--set replica.persistence.enabled=false
```