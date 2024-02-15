import 'package:flutter/material.dart';

class MensajeWidget extends StatefulWidget {

  String? mensaje = "";
  int? pop = 0;
  MensajeWidget({this.mensaje, this.pop});

  @override
  State<MensajeWidget> createState() => _MensajeWidgetState();
}

class _MensajeWidgetState extends State<MensajeWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Informacion'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
                Text(widget.mensaje!),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Aceptar'),
          onPressed: () {
              Navigator.of(context).pop();
              for (int i = 0; i < widget.pop!; i++) {
                Navigator.of(context).pop();
              }
          },
        ),
      ],
    );
  }
}
