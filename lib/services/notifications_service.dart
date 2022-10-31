import 'package:flutter/material.dart';

class NotificationsService {
  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static showSnackbarMessage(String message) {
    final snackBar = SnackBar(
        content: Text(
      message,
      style: TextStyle(color: Colors.white, fontSize: 30),
    ));

    messengerKey.currentState!.showSnackBar(snackBar);

    /*
    
    Quizás es un punto de vista al verlo asi y no sea el funcioanmiento 100% correcto pero mas o menos el funcionamiento
    debe ser algo asi: se crea una clase la cual tiene un GlobalKey llamado messegerKey, ese globalKey que es tipo 
    ScaffoldMessergerState, es para crear notificaciones cuando cambia el estado, para poder utilizarlo
    debo utilizar una de los atributos o propiedades dentro del scaffold mismo que se encuentra en el main
    
       -> scaffoldMessengerKey: NotificationsService.messengerKey, <-
    
    ese scaffold tiene que recibir algo tipo ScaffoldMessergerState, por eso cree esta clase aqui, la cual tiene
    una propiedad y eso es lo que le voy a mandar al main.

    Proseguiendo despues que le mande algo al scaffoldMessengerKey del main:
    
    cree una propiedad statica tipo constructor para poder almacenar el mensaje y ese mensaje que reciba va a 
    ejecutarse dentro de una variable final llamada snackbar, que esa funcion lo que hace es reicibir
    el mensaje que sea almacenado dentro del constructor.

    Una vez que la informacion sea almacenada dentro del constructor se va a disparar la funcion y va a ejecutarse
    el snackBar con esa informacion; asi que esa informacion sea ejecutada necesitará mostrarse al usuario 
    para eso necsitare crear tipo un Listener pero en el caso de los GlobalKey es llamado como una propiedad
    y se llama 'currentState' (propiedad del estado actual), lo que quiere decir que al cambiarse la propiedad del 
    estado actual va a mostrar el showSnackBar, que recibe un snackbar como informacion para poder mostrar

    Conclusion:
-----------------
    messengerKey va a cambiar de estado -> ! <- seguro y en ese momento va a mostrar un snackbar que va a 
    recibir el 'snackbar' ya creado como argumento, eso es lo que yo entiendo que dice
    el codigo aqui abajo
    
    messengerKey.currentState!.showSnackBar(snackBar);
    
    ya que messengerKey es un statefullwidget necesita redibujarse mediante ese get (currentstate)
    y por eso es que se puede mostrar.


    POSTDATA: Cuando le quite esa ultima linea de codigo:  
    messengerKey.currentState!.showSnackBar(snackBar); resulta que no se dibujaba el snackbbar, si consegui
    mandar un print

     */
  }
}
