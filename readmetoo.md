
# update docker images
```bash
docker compose pull
```
```bash
docker pull matrixdotorg/synapse
```
```bash
docker pull alpine
```

# create matrix_authentication_service database
Sub `${POSTGRES_USER}` for real user.
```bash
docker exec -it synapse-db psql -U ${POSTGRES_USER}
```
```sql
CREATE DATABASE matrix_authentication_service
WITH OWNER = ${POSTGRES_USER}
ENCODING = 'UTF8'
LC_COLLATE = 'C'
LC_CTYPE = 'C'
TEMPLATE = template0;
```
```bash
\l matrix_authentication_service
```

# matrix authentication service configuration commands
```bash
docker exec -it matrix-authentication-service mas-cli config check
```
```bash
docker exec -it matrix-authentication-service mas-cli config sync --prune
```
```bash
docker exec -it matrix-authentication-service mas-cli config sync --prune --dryrun
```

# generate matrix authentication service templates locally
```bash
mkdir exported-mas-templates
```
```bash
docker create --name temp-mas ghcr.io/element-hq/matrix-authentication-service:latest
```
```bash
docker cp temp-mas:/usr/local/share/mas-cli/templates ./exported-mas-templates
```
```bash
docker rm temp-mas
```

# [api](https://mauth.ninbura.com/api/doc/)
Use `MAS_CLIENT_ID` & `MAS_CLIENT_SECRET` to authenticate, check the "urn:mas:admin Grant access to the admin API" box.

```
https://mauth.ninbura.com/api/doc/
```