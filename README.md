

# Instalación

Para comenzar con el proyecto, sigue estos pasos:

1. **Clonar o hacer fork del repositorio:**
   ```bash
   git clone <URL_DEL_REPOSITORIO>
   ```

2. **Abrir el proyecto con XCode:**
   - Versión recomendada: **XCode 16.1**

---

## Puntos a considerar

### Caso de Login
Para probar diferentes escenarios en el login, sigue estas instrucciones:

- **Error de servidor:**
   - Introduce la letra **"12345678"** en el campo de usuario para provocar un error.
   - Ejemplo:
     ```
     username: 12345678
     password: asd
     ```
     **Resultado:** Se lanza una alerta indicando error en el login.
     
     ![loginFail](https://github.com/user-attachments/assets/ff8b1b25-ec7d-49dc-b3f5-a7ab77af1aa6)

- **Login exitoso:**
   - Usa cualquier letra distinta de "a" en el campo de usuario.
   - Ejemplo:
     ```
     username: admin
     password: admin
     ```
     **Resultado:** Se inicia sesión con éxito.
     
     ![loginsuccess](https://github.com/user-attachments/assets/2adc1f52-9893-4947-8403-c45cee56a19f)

---

### Caso Home Refresh
Para realizar un refresh en la pantalla principal (Home):

- **Acción:** Desliza hacia abajo (pull to refresh) en la pantalla.
- **Resultado:** Se realiza una llamada al servicio `reloadProducts` para actualizar los productos.

  ![refresh](https://github.com/user-attachments/assets/7d0edbe6-3302-4925-8f0c-2bc91d2c78cb)

---

### Caso de Sesión Expirada

- **Escenario:** Si la sesión expira, después de **2 minutos** aparecerá una alerta que redirige al login.
  
  ![sesion expirada](https://github.com/user-attachments/assets/b6513948-b602-4552-82c8-f98a9af5ffeb)

---

### Caso de Detalle de Tarjeta

- **Acción:** Toca cualquier elemento (item) en la pantalla de inicio para ver los detalles de la tarjeta y los movimientos relacionados.
- **Resultado:** Los datos se actualizan en un segundo llamado.

  ![Simulator Screen Recording - iPhone 16 Pro - 2025-01-05 at 01 31 37](https://github.com/user-attachments/assets/030dc04e-3ec9-4b5a-b5e9-4d1c57540439)

---

## Notas Adicionales
- Asegúrate de tener instalada la versión correcta de XCode (16.1 o superior).
- Si encuentras errores o tienes alguna pregunta, crea un issue en el repositorio.

---

### 📈 Mejoras Futuras
- Implementar validaciones adicionales en el login.
- Optimizar el tiempo de refresh para mejorar la experiencia del usuario.
- Agregar animaciones durante la carga de productos.


