Install with [Helm](https://helm.sh/).

```
helm install moderation . \
	--set discord.oauth2.id=APPLICATION_ID_HERE \
	--set discord.oauth2.secret=APPLICATION_SECRET_HERE \
	--set redis=REDIS_URL_HERE \
	--set mongodb=MONGODB_URL_HERE
```
