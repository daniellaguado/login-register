import 'package:flutter/material.dart';
import 'package:produtos_app/providers/login_form_provider.dart';
import 'package:produtos_app/ui/input_decorations.dart';
import 'package:produtos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            CardCointainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 30),
                  /* El ChangeNotifierProver es igual al Multiprovider solo que es solo para cuando tenemos 1 */
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    /* esta es la instancia de la clase antes creada extendida de provider
                        y para poder instanciarla tengo que llamar primero la clase de ChangeNotifierProvider para
                        conseguir el acceso a ella*/
                    child: _LoginForm(),
                    /* Una vez que ya instanciamos la clase de LoginFormProvider que ahora va a vivir dentro de LoginForm
                    vamos a _LoginForm y ahi continuamos */
                  )
                ],
              ),
            ),
            const SizedBox(height: 50),
            TextButton(
              onPressed: (() =>
                  Navigator.pushReplacementNamed(context, 'register')),
              style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(StadiumBorder())),
              child: Text(
                'Crear una nueva cuenta',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      )),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    /* Una vez que tengamos ya la instancia creamos un final que va a venir de 
    provider, provider lo que va a buscar es en el arbol de widget y se va a ubicar
    en LoginFormProvider (que es la antes instanciada) y traemos el contexto de lo que 
    tiene esa clase. Ya con eso tendremos todos los metodos y atributos ahi especificados*/
    return Container(
      child: Form(
          key: loginForm.formKey,
          /* En este caso de loginForm (que es el nombre del final) lo utilice
          para asociarlo al formKey (el constructor) y el tiene aquellos metodos de validacion dentro de el;
          
          En el cual dice que si el formulario es valido retorna un true
          
        
          
         */
          autovalidateMode: AutovalidateMode
              .onUserInteraction, //este es el activador para validar el formulario
          child: Column(
            children: [
              TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: 'john.doe@gmail.com',
                      labelText: 'Correo electrónico',
                      prefixIcon: Icons.alternate_email_sharp),
                  onChanged: (value) => loginForm.email = value,
                  /* el onChanged me dice cuando el valor ha sido cambiado, es como un ChangeNotifier de los formularios,
                  ademas, la funcion cuenta con el campo value para poder ser trabajado, lo que se hace es 
                  retornar en este caso dle loginForm el password y asociarlo al value.
                  En pocas palabras el onChanged es un string, y cuando cambia, sea lo que sea que se reciba se lo voy
                  a establecer al value*/
                  validator: (value) {
                    //este aqui es la expresion para validar el formulario y las condiciones
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp = RegExp(pattern);

                    return regExp.hasMatch(value ??
                            '') //segun el 'value' que esta arriba, es un String? y como puede ser opcional se tiene que manejar esa condicion, entonces si no viene el value me manda un String vacio ('')
                        ? null //Aparte de eso tengo que retornar un valor booleano, si el codigo de arriba hace match entonces voy a regresar un null (que es cuando el mensaje se quita)
                        : 'El valor ingresado no es correcto'; //caso contrario mandar este mensaje
                  }),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                  autocorrect: false,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecorations.authInputDecoration(
                      hintText: '*********',
                      labelText: 'Password',
                      prefixIcon: Icons.lock_outline),
                  onChanged: (value) => loginForm.password = value,
                  /* el onChanged me dice cuando el valor ha sido cambiado, es como un ChangeNotifier de los formularios,
                  ademas, la funcion cuenta con el campo value para poder ser trabajado, lo que se hace es 
                  retornar en este caso dle loginForm el password y asociarlo al value.
                  En pocas palabras el onChanged es un string, y cuando cambia, sea lo que sea que se reciba se lo voy
                  a establecer al value*/
                  validator: (value) {
                    /* la condicion aqui es la siguiente: retornamos un condicional de que si el value
                    es diferente de null (o sea si tiene informacion el label) y es mayor o igual a 6 caracteres
                    entonces retorna un null (o sea no va a retornar un validator)
                    caso contrario mandar el string */
                    return (value != null && value.length >= 6)
                        ? null
                        : 'La contrasena debe de ser de 6 caracteres';
                  }),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.deepPurple,
                  onPressed: loginForm.isLoading
                      ? null
                      : () async {
                          /* en cuanto el OnPressed: el loginForm.isLoading es true? entonces
                      retorna un null, si no esta en false entonces ejecuta la funcion */

                          FocusScope.of(context)
                              .unfocus(); //para quitar el teclado
                          // Utilizamos el loginform junto con el metodo isValidForm (que es el formKey del costructor [provider])
                          if (!loginForm.isValidForm()) return;
                          /* Si el loginform.isvalidForm es true entonces navega para home */
                          loginForm.isLoading = true;
                          /* Este isLoading = true sirve para especialmente colocar el boton en null, en la funcion que esta
                          en el onPressed, me dice que si isLoading esta en true me retorne el boton en null, caso contrario
                          ejecuta la funcion.*/
                          // await Future.delayed(Duration(seconds: 2));

                          final authService =
                              Provider.of<AuthService>(context, listen: false);
                          final String? errorMessage = await authService.login(
                              loginForm.email, loginForm.password);
                          if (errorMessage == null) {
                            Navigator.pushReplacementNamed(context, 'home');
                          } else {
                            //Mostrar error en pantalla
                            // print(errorMessage);
                            NotificationsService.showSnackbarMessage(
                                errorMessage);
                            loginForm.isLoading = false;
                          }
                        },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text(
                      loginForm.isLoading ? 'Espere' : 'Ingresar',
                      /* En este caso: si isLoading  esta en false? -> espere
                      sino: aparece ingresar */
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
            ],
          )),
    );
  }
}
