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