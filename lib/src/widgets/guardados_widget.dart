import 'package:flutter/material.dart';

class GuardadosWidget extends StatefulWidget {
  String? result = "";
  GuardadosWidget({this.result});

  @override
  State<GuardadosWidget> createState() => _GuardadosWidgetState();
}

class _GuardadosWidgetState extends State<GuardadosWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Informacion'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            widget.result =="1" ? Text('Guardado Correctamente') : Text("Ocurrio un error revise los datos"),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Aceptar'),
          onPressed: () {
            if (widget.result =="1")
              {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            else {
              Navigator.of(context).pop();
            }

          },
        ),
      ],
    );
  }
}
