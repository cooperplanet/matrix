# account registration
### preface
- It is reccomended that you perform account registration on a desktop computer, but the process for mobile should be very similar.
- On mobile **I recommend using Element Messenger** over using Element X for now, Element Messenger is more stable and has significantly more features (threads, channel discovery, additional settings, etc).
### steps
1. visit https://app.element.io & click "Login" (don't click "Create account")
2. click "edit" under "Homeserver" to the right of "matrix.org"
3. enter "matrix.ninbura.com" into the text box & click "Continue" ("Continue with SSO" on iOS)
4. click "Create Account" at the bottom of the page
5. fill out the form & click "Continue"
6. enter the code sent to your email & follow redirection prompts
7. Once in the web-app, click your user portrait in the top left, and then "Security & Privacy".
8. in the "Secure Backup" section click the "Set Up" button (security key)
9. choose "Generate a Security Key" & click "Continue"
10. click "Download" or "Copy" & store the key somewhere safe/redundant (DO NOT LOSE THIS)
11. click "Continue" and then "Done"

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