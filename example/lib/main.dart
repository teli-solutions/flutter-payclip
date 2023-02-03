import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_payclip/flutter_payclip.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _email = TextEditingController(text: '');
  final _password = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        title: const Text('SDK Clip'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              MaterialButton(
                minWidth: double.infinity,
                color: Colors.orange[800],
                textColor: Colors.white,
                onPressed: () {
                  FlutterPayClip.init();
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    text: 'SDK inicializado',
                    autoCloseDuration: const Duration(seconds: 5),
                  );
                },
                child: const Text('INICIALIZAR'),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: _password,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                ),
              ),
              const SizedBox(height: 10),
              MaterialButton(
                minWidth: double.infinity,
                color: Colors.orange[800],
                textColor: Colors.white,
                onPressed: () {
                  FlutterPayClip.login(email: _email.text, password: _password.text).then((response) => {
                    if (response){
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        text: 'Sesion Iniciada',
                        autoCloseDuration: const Duration(seconds: 2),
                      )
                    }else{
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        text: 'Ocurrio un error al iniciar la sesion',
                        autoCloseDuration: const Duration(seconds: 2),
                      )
                    }
                  });
                },
                child: const Text('INICIAR SESION'),
              ),
              MaterialButton(
                minWidth: double.infinity,
                color: Colors.orange[800],
                textColor: Colors.white,
                onPressed: () {
                  FlutterPayClip.logout().then((success) => {
                    if(success){
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        text: 'Sesion Cerrada',
                        autoCloseDuration: const Duration(seconds: 5),
                      )
                    }else{
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        text: 'Ocurrio un error al cerrar la sesion',
                        autoCloseDuration: const Duration(seconds: 5),
                      )
                    }
                  });
                },
                child: const Text('CERRAR SESION'),
              ),
              const SizedBox(height: 30),
              MaterialButton(
                minWidth: double.infinity,
                color: Colors.orange[800],
                textColor: Colors.white,
                onPressed: () {
                  FlutterPayClip.settings(
                      loginEnabled: false, logoutEnabled: false);
                },
                child: const Text('ABRIR AJUSTES'),
              ),
              MaterialButton(
                minWidth: double.infinity,
                color: Colors.orange[800],
                textColor: Colors.white,
                onPressed: () {
                  FlutterPayClip.payment(
                          amount: 1.00,
                          enableContactless: true,
                          enableTips: true,
                          roundTips: true,
                          enablePayWithPoints: false,
                          customTransactionId: "123123")
                      .then((response) => {
                            if (response == -1)
                              {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  text: 'Cobro realizado exitosamente',
                                  autoCloseDuration: const Duration(seconds: 2),
                                )
                              }
                          });
                },
                child: const Text('CREAR PAGO'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
