import 'package:flutter/material.dart';


void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Información Incorrecta"),
          content: Text(mensaje),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: ()=> Navigator.pop(context),
            )
          ],
        );
      });
}