import 'package:flutter/material.dart';
import 'package:produtos_app/screens/screens.dart';
import 'package:produtos_app/services/auth_service.dart';
import 'package:provider/provider.dart';

class CheckAuthScreenScreen extends StatelessWidget {
  const CheckAuthScreenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    /*No necesito redibujar el widget nunca por eso pongo el liste en false para que
    no esté escuchando ningun cambio que se haga en ese AuthService
    */
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: authService.readToken(),
              //Future: pide le future que se va a mandar a llamar, en este caso es el readToken
              builder: (context, AsyncSnapshot<String> snapshot) {
                // if (!snapshot.hasData)  <---??? para que yo voy a utilizar eso? no se
//si no recibo data del snapshot [que seria el  key 'token'] entonces redireccionalo para el login.
//
//
//
//
// ============================================================================================================
                // El microtask es una funcion que se va a ejecutar despues que el builder termine
                if (snapshot.data == '') {
                  Future.microtask(() {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => LoginScreen(),
                          transitionDuration: Duration(seconds: 0),
                        ));
                  });
                } else {
                  Future.microtask(() {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => HomeScreen(),
                          transitionDuration: Duration(seconds: 0),
                        ));
                  });
                }
/* Ese aqui es toda la navegacion y condicional basicamente imporante de este screen, donde dice que si no tiene
el token se va para el login, y si lo tiene va para el HomeScreen, todo utilizando el microtask */
// ==========================================================================================================
//
//
//
                return Container();
              })),
    );
  }
}
