import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  String email = ''; // ==> Atributos de la clase
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  // value = _isLoading;  <-- hacer test, si colocandolo invertido sirve

  GlobalKey<FormState> formKey = GlobalKey(); //  --> Constructor
  /* Permite jugar con los keys, que es una referencia a ese widget especifico, y ese global key 
  necesita una referencia, como en el caso ese key va a ser utilizado dentro de un From entonces
  es FormState, si es de Scafold entonces seria ScafoldState  */

  bool isValidForm() {
    // Metodo
    /* Dentro de este metodo creado por mi llamado isValidForm, lo que se hizo fue
    llamar al constructor y dentro de Globalkey tiene un get, el cual fue utilizado llamado: 'currentState',
    despues de utilizar el get, ese get utilizamos un metodo del FormState llamado 'validate'
    en conclusion se hizo algo asi:
    constructor + get (GlobalKey) + metodo (FormState)
    */
    print(formKey.currentState?.validate());
    print('$email - $password');

    return formKey.currentState?.validate() ?? false;
    /* 
          ** EXPLICACION DE LA FUNCION EN CONJUNTO CON LO QUE SE HA CREADO EN EL LOGIN SCREEN**


    Lo que hace esta fucnion es que validate() retorna un true si los campos del formulario
    estan bien, la excepcion que se colocó, es que si no estan bien retorne un false.
    
    Dentro de su funcion el validate esta vinculado con el validate del Form, por lo cual se comunican entre ellos

    Dentro del login_screen tengo esta funcion:

       if (!loginForm.isValidForm()) return;
                          Navigator.pushReplacementNamed(context, 'home');


      Lo que me dice entonces es: 

      Utilizo el final para poder usar la propiedad, que dice: que hay un formulario que esta siendo validado
      y si es diferente a "true" (que dentro de este formKey se creo un metodo que el formulario si esta bien retorna un true)
      entonces no retorna nada, ahora si es true navega hacia el home. 

    
     */

    /* Me leí el FormState para saber sus get, despues de los get me leí que tipo de funciones manejaba ese 
    get de FormState, y ahi consegui la de validate, que es la que me interesa... es interesante
    el saber que primeramente el currentstate puede ser nulo, y a medida que se va leyendo la descripcion
    se va entendiendo, y el validate retorna un true, que lo que haces validar y hay que manejar
    la excepcion, esa excepcion es dicha en la misma descripcion algo asi como "bool?' ya ahi
    se sabe que puede venir nulo y da para manejarlo" */
  }
}
