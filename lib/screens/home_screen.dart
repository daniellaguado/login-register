import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('Produtos'), actions: [
        IconButton(
          icon: Icon(Icons.login_outlined),
          onPressed: () {
            authService.logout();
            //se ejecuta la funcion de logout
            Navigator.pushReplacementNamed(context, 'login');
            // no destruye el token?????????????? DUDAAA! <<<<=== no es una nota
          },
        ),
      ]),
      body: Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}
