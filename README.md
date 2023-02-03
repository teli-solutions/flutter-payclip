# flutter_payclip


El SDK de Clip es una librería que extiende las capacidades de tu aplicación de punto de venta.

Permite que los desarrolladores puedan crear aplicaciones móviles personalizadas para tomar pagos con tarjetas de crédito y débito.

## ¿Qué puedo hacer con el SDK de Pagos de Clip?

El SDK te da la posibilidad de integrar el flujo de cobro dentro de tu app, ofreciendo una interfaz de usuario amigable que guía a tu cliente a través del proceso.

Con el SDK de Pagos tu sistema será capaz de:

- Aceptar pagos con tarjeta de crédito o débito con pantallas de cobro predefinidas.
- Obtener el historial de transacciones del mismo día.
- Iniciar y cerrar la sesión de Clip desde tu aplicación.
- Configurar los ajustes del dispositivo.
- Crear enlaces para pagos a distancia y compartirlos al usuario final.

## ¿Cómo funciona el SDK de Clip?

La integración con dispositivos móviles extiende su uso a celulares y tabletas Android, así como iPhone y iPad de iOS, ofreciendo versatilidad en la experiencia del usuario.

Usando el SDK de Clip, es muy fácil generar enlaces de pago remotos. Una vez que Pagos a Distancia se incluye como opción de pago dentro de una app, el SDK de Clip se encargará de guiar al usuario por el proceso para generar y compartir el enlace.

El proceso para integrar los pagos con tarjeta es el siguiente:

- Crea tu propia aplicación de Punto de Venta
- Integra las librerías de Clip para tomar pagos con tarjeta, las pantallas de flujo ya están predefinidas
- Continua el flujo de finalización del pago en tu aplicación

![alt text](https://files.readme.io/7f985c4-sdk.png)

## ¿Qué necesito antes de empezar?

Para poder desarrollar con el SDK de Pagos de Clip requieres:

- Un dispositivo Clip Plus o Clip Plus 2.
- Una cuenta Clip activa
- Una aplicación Android o iOS que sea compatible con los requisitos del desarrollo.

## Funciones soportadas actualmente
- Iniclizar SDK
- Configurar los ajustes del dispositivo
- Recibir pagos con tarjeta

## Uso

Start by adding the library as a dependency to your project.
```yaml
dependencies:
  flutter_payclip: <latest version>
```

Importar
```dart
import 'package:flutter_payclip/flutter_payclip.dart';
```

- **Initilize the SDK**
```dart
bool result = await FlutterPayClip.init();
```

- **Inicialir sesion y conectar terminal**
```dart
bool result = await FlutterPayClip.settings(
  loginEnabled: true, 
  logoutEnabled: true
);
```

- **Crear un nuevo pago**
```dart
int result = await FlutterPayClip.payment(
  amount: 133.28, 
  enableContactless: true, 
  enableTips: true, 
  roundTips: true, 
  enablePayWithPoints: false, 
  customTransactionId: "123123"
);
```