import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> alert(
      BuildContext context, {
        String? title,
        String? body,
        String? confirmText = "Aceptar",
      }) async {
    Completer<void> c = Completer();

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: title != null ? Text(title) : null,
            content: body != null ? Text(body) : null,
            actions: <Widget>[
              CupertinoButton(
                onPressed: () {
                  Navigator.pop(context);
                  c.complete();
                },
                child: Text(confirmText!),
              )
            ],
          );
        });

    return c.future;
  }


  static Future<bool> showMaterialDialog(
      BuildContext context, {
        String? title,
        String? body,
        String? enviar = "Enviar SUNAT",
        String? anular = "Anular",
        String? cancelText = "Cancelar",
        String? confirmText = "Aceptar",
      }) {
    Completer<bool> c = Completer();

    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.transparent,
            alignment: Alignment.bottomCenter,
            child: CupertinoActionSheet(
              title: title != null
                  ? Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              )
                  : null,
              message: body != null
                  ? Text(
                body,
                style: TextStyle(fontSize: 16.0),
              )
                  : null,
              actions: <Widget>[
                CupertinoActionSheetAction(
                  onPressed: () {
                    //c.complete(true);
                  },
                  child: Text(
                    enviar!,
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w300,
                        fontSize: 17.0),
                  ),
                ),
                CupertinoActionSheetAction(
                  onPressed: () {
                    //c.complete(true);
                  },
                  child: Text(
                    anular!,
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w300,
                        fontSize: 17.0),
                  ),
                ),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  c.complete(false);
                },
                child: Text(
                  cancelText!,
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0),
                ),
              ),
            ),
          );
        });

    return c.future;
  }

  static void inputEmail(BuildContext context,
      {String? label,
        String? placeholder,
        @required void Function(String)? onOka}) {
    String text = "";

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: label != null ? Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(label),
            ) : null,
            content: InputEmail(
              placeholder: placeholder!,
            ),
          );
        });
  }
}

class InputEmail extends StatefulWidget {
  final String? placeholder;

  InputEmail({this.placeholder});

  @override
  _InputEmailState createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  String _email = "";

  bool _validate() {
    return _email.contains("@");
  }

  @override
  Widget build(BuildContext context) {
    final isValid = _validate();

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CupertinoTextField(
            onChanged: (String text) {
              _email = text;
              _validate();
              setState(() {});
            },
            placeholder: widget.placeholder,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: isValid
                      ? () {
                    Navigator.pop(context);
                  }
                      : null,
                  child: Text("Aceptar",
                      style: TextStyle(
                          color: isValid ? Colors.redAccent : Colors.black45)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}