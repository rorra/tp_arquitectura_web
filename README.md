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

8. Para probar una compra

   Probar las compras con los datos de prueba de mercadolibre:

   * Mastercard
       - 5031 7557 3453 0604
       - 123
       - 11/25
   * Visa
       - 4509 9535 6623 3704
       - 123
       - 11/25
   * American Express
       - 3711 803032 57522
       - 1234
       - 11/25

   Para el nombre, usar alguno de los provistos por mercadolibre

   * APRO
     - Pago aprobado
     - (DNI) 12345678
   * OTHE
     - Rechazado por error general
     - (DNI) 12345678

9. Reporte

En el administrador (/admin), aparece el reporte de ordenes pendientes de envío (/admin/paid_orders_report)
