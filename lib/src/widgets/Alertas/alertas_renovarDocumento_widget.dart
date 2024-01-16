


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transana_app/src/services/informes_preventivos_services.dart';

class AlertasRenovarDocumento extends StatefulWidget {



  String idDoc = "";
  AlertasRenovarDocumento({this.idDoc});

  @override
  State<AlertasRenovarDocumento> createState() => _AlertasRenovarDocumentoState();
}

class _AlertasRenovarDocumentoState extends State<AlertasRenovarDocumento> {


  final formKey = GlobalKey<FormState>();
  var loading = true;
  var defTipo = "";
  var objTipos = new InformePreventivoService(); //

  String selDateini = DateTime.now().toString().substring(0, 10);
  String selDatefin = DateTime.now().toString().substring(0, 10);

  AlertasDocumentosModel _updateAlertaDocModel =
  AlertasDocumentosModel();
  InformePreventivoService _updateAlertaDocServices = InformePreventivoService();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString("idUser");
 //   String idV = await prefs.getString("IdVehiculo");

  //  print(idV);
    // String sInicial = await prefs.getString("sInicial");

    loading = false;
    setState(() {});
  }


  void registrar() {
    if (formKey.currentState.validate()) {
      _updateAlertaDocModel.idC = widget.idDoc;
      _updateAlertaDocModel.fechaEmision = selDateini;
      _updateAlertaDocModel.fechaCaducidad = selDatefin;


      _updateAlertaDocServices.renovarDocumento(_updateAlertaDocModel)
          .then((value) {
        print("Salvadito ?");
        print(value);
        if (value != null) {
          if (value == "1") {
            print("Documento Actualizado Save");
            Navigator.pop(context);
            // Navigator.pop(context);
          }
        }
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return !loading
        ?  AlertDialog(
      content: Form(
        key: formKey,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("RENOVAR",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(height: 15.0,),

                SizedBox(height: 15.0,),

                Text("Fecha Emision"),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white,
                            blurRadius: 3)
                      ]),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 7.0,
                        ),
                        Text(
                          selDateini,
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                        )
                      ],
                    ),
                    onPressed: () {
                      _selectSelDateini(context);
                    },
                  ),
                ),

                SizedBox(height: 15.0,),
                Text("Fecha Caducidad"),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.white,
                            blurRadius: 3)
                      ]),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 7.0,
                        ),
                        Text(
                          selDatefin,
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                        )
                      ],
                    ),
                    onPressed: () {
                      _selectSelDatefin(context);
                    },
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancelar",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            registrar();
          },
          child: Text(
            "Grabar",
          ),
        ),
      ],
    ): Center(child: CircularProgressIndicator());
  }








  Future<Null> _selectSelDateini(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        //initialDate: new DateTime.now(),
        initialDate: DateTime.parse(selDateini),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        selDateini = picked.toString().substring(0, 10);
        print(selDateini);
        //  _listViaje(context, viaje);
      });
  }




  Future<Null> _selectSelDatefin(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: DateTime.parse(selDatefin),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        selDatefin = picked.toString().substring(0, 10);
        print(selDatefin);
        //  _listViaje(context, viaje);
      });
  }






}
