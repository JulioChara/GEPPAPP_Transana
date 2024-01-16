import 'package:flutter/material.dart';
import 'package:transana_app/src/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/services/login_services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isFetching = false;
  String _email = "", _password = "";

  LoginServices loginServices = new LoginServices();

  _submit() async {
//    if (isValid) {
//      setState(() {
//        _isFetching = true;
//      });
//      bool isOk = await _accountAPI.login(_email, _password);
//      print(isOk);
//      if (isOk) {
//        SharedPreferences prefs = await SharedPreferences.getInstance();
//        await prefs.setBool("wasLogin", true);
//        Navigator.pushReplacementNamed(context, HomePage.routeName);
//      }else{
//        setState(() {
//          _isFetching = false;
//        });
//        await Dialogs.alert(
//          context,
//          title: "Error",
//          body: "Email o contraseña incorrectos",
//        );
//      }
//    }

    setState(() {
      _isFetching = true;
    });

    String rpta = await loginServices.login(_email, _password);
    print(rpta);

    if (rpta == "0") {
      setState(() {
        _isFetching = false;
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text(
                  "Hubo un problema, verifique sus datos e inténtelo nuevamente."),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Aceptar"),
                )
              ],
            );
          });
    }else{
      setState(() {
        _isFetching = false;
      });
      Navigator.pushReplacementNamed(context, 'home', arguments: _email);
    }



//    if (rpta != "0") {

//    } else {
//      setState(() {
//        _isFetching = false;
//      });
//
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
          if (_isFetching)
            Positioned(
              child: Container(
                color: Colors.black26,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final primerFondo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color(0xFFF7F7F7),
        Color(0xFFF7F7F7),
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.1)),
    );

    return Stack(
      children: <Widget>[
        primerFondo,
        Positioned(
          top: 90.0,
          left: 30.0,
          child: circulo,
        ),
        Positioned(
          top: -40.0,
          right: -30.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          right: -10.0,
          child: circulo,
        ),
        Positioned(
          bottom: 120.0,
          right: 20.0,
          child: circulo,
        ),
        Positioned(
          bottom: -50.0,
          left: -20.0,
          child: circulo,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 200.0,
                padding: EdgeInsets.only(top: 70.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset("assets/logo.jpg"),
                ))
          ],
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 3.0),
                      spreadRadius: 3.0),
                ]),
            child: Column(
              children: <Widget>[
                Text(
                  "INGRESO",
                  style: TextStyle(fontSize: 30.0, letterSpacing: 1.0),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _crearEmail(),
                SizedBox(height: 20),
                _crearPassword(),
                SizedBox(height: 50),
                _crearBoton(),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
          )
        ],
      ),
    );
  }

  Widget _crearEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Color(0xFFF44336)),
          hintText: "Usuario",
          labelText: "Usuario",
        ),
        onChanged: (value) {
          _email = value;
        },
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_outline, color: Color(0xFFF44336)),
          labelText: "Contraseña",
        ),
        onChanged: (value) {
          _password = value;
        },
      ),
    );
  }

  Widget _crearBoton() {
    return RaisedButton(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          child: Text("Ingresar"),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 0.0,
        color: Color(0xFFD32F2F),
        textColor: Colors.white,
        onPressed: () {
          _submit();
        });
  }

//  _login(LoginBloc bloc, BuildContext context) async {
//    Map info = await usuarioProvider.login(bloc.email, bloc.password);
//
//    if (info['ok']) {
//      Navigator.pushReplacementNamed(context, 'home');
//    } else {
//      mostrarAlerta(context,info['mensaje']);
//    }
//  }

}
