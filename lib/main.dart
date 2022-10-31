import 'package:flutter/material.dart';
import 'package:produtos_app/screens/screens.dart';
import 'package:provider/provider.dart';

import 'services/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.debugCheckInvalidValueType = null;
    return Provider(
      create: (context) => AuthService(),
      child: MaterialApp(
        scaffoldMessengerKey: NotificationsService.messengerKey,
        //no necesito estanciar el notificacionService porque es una propiedad estatica
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (_) => LoginScreen(),
          'home': (_) => HomeScreen(),
          'register': (_) => RegisterScreen(),
          'checking': (_) => CheckAuthScreenScreen(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
