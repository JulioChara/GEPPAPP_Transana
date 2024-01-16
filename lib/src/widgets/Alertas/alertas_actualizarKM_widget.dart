


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transana_app/src/services/informes_preventivos_services.dart';

class AlertasActualizarKM extends StatefulWidget {

  String idVeh = "";
  AlertasActualizarKM({this.idVeh});

  @override
  State<AlertasActualizarKM> createState() => _AlertasActualizarKMState();
}



class _AlertasActualizarKMState extends State<AlertasActualizarKM> {


  final formKey = GlobalKey<FormState>();
  var loading = true;
  var defTipo = "";
  var objTipos = new InformePreventivoService(); //


  TextEditingController kmActualizarEditingController = new TextEditingController();


  AlertasMantenimientosModel _updateAlertaManModel =
  AlertasMantenimientosModel();
  InformePreventivoService _updateAlertaManServices = InformePreventivoService();




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString("idUser");
    loading = false;
    setState(() {});
  }



  void registrar() {
    if (formKey.currentState.validate()) {
      _updateAlertaManModel.idC = widget.idVeh;
      _updateAlertaManModel.vehiculoFk = widget.idVeh;
      _updateAlertaManModel.kilometroMantenimiento = kmActualizarEditingController.text;

      _updateAlertaManServices.actualizarKM(_updateAlertaManModel)
          .then((value) {
        print("Salvadito ?");
        print(value);
        if (value != null) {
          if (value == "1") {
            print("Kilometraje Actualizado Save");
            Navigator.pop(context);
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
                Text("ACTUALIZAR KM",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(height: 15.0,),

                TextFormField(
                  controller: kmActualizarEditingController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    hintText: "Actualizar Kilometraje",
                    labelText: "Kilometraje",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        "assets/icons/kilometro.svg",
                        color: Colors.green,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  keyboardAppearance: Brightness.light,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (String text) {},

                  //initialValue: "0",
                  onChanged: (value) {
                    //  kmMantenimientoEditingController.text = (int.parse(kmInicialEditingController.text) + int.parse(kmRecorrerEditingController.text)).toString();
                  },
                )

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







}
