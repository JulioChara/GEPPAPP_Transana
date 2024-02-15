


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/general_model.dart';
import 'package:transana_app/src/services/informes_preventivos_services.dart';
import 'package:transana_app/src/widgets/mensaje_widget.dart';

class FinalizarAlertaWidget extends StatefulWidget {


  String? tipoSub = "";
  String? idTab="";
  FinalizarAlertaWidget({
    this.tipoSub,
    this.idTab
  });

  @override
  State<FinalizarAlertaWidget> createState() => _FinalizarAlertaWidgetState();
}

class _FinalizarAlertaWidgetState extends State<FinalizarAlertaWidget> {

  bool isLoading = true;


  IdsModel _idsModel = IdsModel();
  InformePreventivoService _alertaServices = InformePreventivoService();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("Tipo: "+widget.tipoSub!);
    print("Id: "+widget.idTab!);

    isLoading = false;
    setState(() {});
  }




  void finalizar() {

      _idsModel.idC = widget.tipoSub;
      _idsModel.idD = widget.idTab;

      _alertaServices.finalzarAlerta(_idsModel)
          .then((value) {
        if (value != null) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {

              return MensajeWidget(mensaje: "Finalizado Correctamente",pop: 2,);
            },
          ).then((val) {
            //Navigator.pop(context);
            getData();
            setState(() {});
          });


          // if (value == "1") {
          //   Navigator.pop(context);
          //   // Navigator.pop(context);
          // }
        }
      });

  }





  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? AlertDialog(
      content: Form(
        // key: formKey,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("ADVERTENCIA",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(
                  height: 15.0,
                ),

                SizedBox(
                  height: 15.0,
                ),
                ListBody(
                  children: <Widget>[
                    Text("Esta Seguro de Finalizar la Alerta?"),
                  ],
                ),




              ],
            ),
          ),
        ),
      ),
      actions: [

        ElevatedButton(
          onPressed: () {
            finalizar();
          },
          child: Text(
            "SI",
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "NO",
          ),
        ),
      ],
    )
        : Center(child: CircularProgressIndicator());
  }









}
