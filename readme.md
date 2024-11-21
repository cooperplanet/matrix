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

# account creation & logging in
## create account
### preface
It is reccomended that you perform account registration on a desktop computer, but the process for mobile should be very similar.
### steps
1. visit https://app.element.io & click "Login" (don't click "Create account")
2. click "edit" under "Homeserver" to the right of "matrix.org"
3. enter "matrix.ninbura.com" into the text box & click "Continue"
4. click "Create Account" at the bottom of the page
5. fill out the form & click "Continue"
6. enter the code sent to your email & follow redirection prompts
7. Once in the web-app, click your user portrait in the top left, and then "Security & Privacy".
8. in the "Secure Backup" section click the "Set Up" button
9. choose "Generate a Security Key" & click "Continue"
10. click "Download" or "Copy" & store the key somewhere safe/redundant (DO NOT LOSE THIS)
11. click "Continue" and then "Done"

## login on mobile (Element X)
### preface
It is highly suggested that you use the Element X app as it supports E2EE (end-to-end encryption) push notifications.
### with QR (easiest)
1. on the element web app or the desktop app click your user portrait and then "Link new device"
2. On the Element X mobile app tap "Sign in with QR code", and then "Ready to scan". 
3. Grant the app camera access if neccessary, and scan the QR code.
4. enter the 2-digit code displaying on your phone into the input boxes in the Element desktop/web app
5. on the "Allow access to your account?" page in the Element desktop/web app review the details & click "Continue"
### sign in manually
1. tap the "Sign in manually" button and then "Change account provider"
2. enter "matrix.ninbura.com" into the text box & tap "Continue" twice
3. enter your Username & Password and tap "Continue" twice
4. on the "Confirm your identity" choose one of the following
    - use another device
        1. tap "Start verification"
        2. click or tap "Verify Session" on your second device and then tap "Start" on your phone
        3. Verify that the on screen emoji match on both devices, and then click/tap "They match" on each respective device.
    - use recovery key
        1. enter the security key you backed up earlier into the text box and tap "Continue"