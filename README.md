Install with [https://helm.sh/](Helm).

```
helm dependency update
helm install moderation . \
	--set discord.oauth2.id=APPLICATION_ID_HERE \
	--set discord.oauth2.secret=APPLICATION_SECRET_HERE
```