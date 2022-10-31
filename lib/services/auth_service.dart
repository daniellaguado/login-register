import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCUX2HeAd29n7Un-y6wX1LjUrEr6VhgGJQ';
  //firebaseToken: Este no es el token de los usuarios, es el token de acceso al API de firebase
  final storage = FlutterSecureStorage();

// ESTE AQUI ES PARA EL REGISTRO ---------------------------------------------
  Future<String?> createUser(String email, String password) async {
    //auth de authentication => datos de autenticación: email y password
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken,
      'auth': await storage.read(key: 'token') ?? ''
    });

    final resp = await http.post(url, body: json.encode(authData));
    //la respuesta es http -> pero post
    //encode = codificarlo -> en formato json

    /*

    Lo que entiendo que esta haciendo es que dentro de la variable 'resp' esta la 
    variable 'url' que contiene todo la url, entonces dice:
    en la variable 'resp' contiene la url y el body, el body de 'resp' es la codificacion del json
    que se encuentra dentro de 'authData' lo que esta haciendo es que convierte el authData 
    que en este caso es el email y password recibidos en un objeto Json

    */
    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    /* 
    
    Este decodeResp es Map <String dynamic> porque el json viene en forma de mapa y a veces tiene un int
    en el el value, por lo que se pone dynamic.

    Aqui lo que esta haciendo es que los datos recibidos de la API son almacenados dentro de la 'resp' entonces
    ya que pude leer y obtener la informacion del Json de la API y esta almacenada dentro de la variable 'resp'
    ahora el siguiente paso es agarrar esa informacion (resp.body) <- o sea el 'body' de la variable 'resp'
    decodificarla y almacenarla en una variable que es decodeResp'
    
     */
    print(decodeResp);

    //Si retornamos algo es un error, sino, todo bien
    if (decodeResp.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodeResp['idToken']);
      //Token hay que guardarlo en un lugar seguro
      // return decodeResp['idToken'];
      return null;
    } else {
      return decodeResp['error']['message'];
    }
  }

// ESTE AQUI ES PARA EL LOGIN ---------------------------------------------

  Future<String?> login(String email, String password) async {
    //auth de authentication => datos de autenticación: email y password
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken,
      'auth': await storage.read(key: 'token') ?? ''
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodeResp['idToken']);
      return null;
    } else {
      return decodeResp['error']['message'];
      //dentro de error voy a buscar el mensaje o sea va aparecer "email_not_found"
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';

    /* 
    
    el storage.read pide que el String sea opcional <String?> poque puede venir
    un string o puede ser null, pero el problema de hacerlo con un string opcional es que como
    el readToken va a terminar conectandolo a un Future Builder, un return null va a ser considerado
    como si no tiene data.

    Por eso se maneja la excepcion diciendo de que si no consigue una llave (key [en el json])con ese 
    nombre ('token'), mande un string vacio

    ------

    Ahorita construyendo el FutureBuilder me doy cuenta que hay una propiedad llamada 'hasData', que dice:
     En ingles:
     Returns whether this snapshot contains a non-null data value

     En español:
     Devuelve si este snapshot contiene un valor de data non-null 
     https://api.flutter.dev/flutter/widgets/AsyncSnapshot/hasData.html

     >> Explicación de la propiedad:  el snapshot es una copia de un instante determinado de los archivos; por lo que 
     al aplicar esta propiedad [hasData] dice que va a retornar un snapshot si el valor de la data no es nulo <<

    Lo que quiere decir: que en el future readToken que contiene una propiedad llamada read, dice que el future puede
    ser opcional Future<String?> pero eso es contraproducente al querer usar un FutureBuilder ya que vemos arriba
    que si hubiese dejado el <String?> y no consigue un 'key' de valor 'token' me hubiese retornado un null, que a su vez
    no hubiera podido retornar un snapshot por ser un valor nulo


    
     */
  }
}
