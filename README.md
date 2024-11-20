# Setup
1. Instalar ruby 3.3.5

```bash
rvm install 3.3.5
```

2. Activar ruby 3.3.5 e instalar las librerias

```bash
rvm use
bundle install
```

3. Crear la base de datos

```bash
bundle exec rails db:create
bundle exec rails db:migrate
```

4. Configurar las credenciales

```bash
EDITOR=vim bundle exec rails credentials:edit
```

Las credenciales deben tener la siguiente estructura:

```yaml
secret_key_base: SECRET_KEY_BASE

google_oauth_client_id: GOOGLE_OAUTH_CLIENT_ID
google_oauth_client_secret: GOOGLE_OAUTH_CLIENT_SECRET

mercadopago_access_token: MERCADOPAGO_ACCESS_TOKEN
```

5. Iniciar los datos de la base de datos

```bash
bundle exec rails db:seed
```

6. Iniciar el servidor

```bash
bundle exec rails server
```

7. Para correr los tests

```bash
bundle exec rspec
```
