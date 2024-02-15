




import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transana_app/src/services/informes_preventivos_services.dart';

class AlertaDetallesWidget extends StatefulWidget {

 // List<AlertasListadoModel> alertasListadoList = [];

  // AlertaDetallesWidget({
  //  this.alertasListadoList,
  // });


  String? tipoSub = "";
  String? idTab="";
  AlertaDetallesWidget({
    this.tipoSub,
    this.idTab
  });

  // AlertaDetallesWidget({
  //   List<AlertasListadoModel> alertasListadoList
  // });




  @override
  State<AlertaDetallesWidget> createState() => _AlertaDetallesWidgetState();
}






class _AlertaDetallesWidgetState extends State<AlertaDetallesWidget> {


  var alertaService = new InformePreventivoService();
  List<AlertasListadoModel> listAlerta = [];
  bool isLoading = true;

  TextEditingController _tipoGeneralController = TextEditingController();
  TextEditingController _tipoDocumentoController = TextEditingController();
  TextEditingController _docReferenciaController = TextEditingController();
  TextEditingController _fechaCaducidadController = TextEditingController();
  TextEditingController _kmCaducidadController = TextEditingController();
  TextEditingController _kmActualController = TextEditingController();
  TextEditingController _kmMantenimientoController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString("idUser")!;
    String idV = await prefs.getString("IdVehiculo")!;

    String opc = "";
    if(widget.tipoSub == "Mantenimientos")
      {
        opc ="1";
      }else { opc ="0";}


    listAlerta = await alertaService.getAlertaxId(opc, widget.idTab!);
     print(listAlerta[0].idTab);
     print(listAlerta[0].fechaCaducidad);

    _tipoGeneralController.text = listAlerta[0].documentoGeneral!;
    _tipoDocumentoController.text = listAlerta[0].tipoDocumentoFkDesc!;
    _docReferenciaController.text = listAlerta[0].documento!;
    _fechaCaducidadController.text = listAlerta[0].fechaCaducidad!;
    _kmCaducidadController.text = listAlerta[0].kmCaducidad!;
    _kmActualController.text = listAlerta[0].kmActual!;
    _kmMantenimientoController.text = listAlerta[0].kmMantenimiento!;

    print("Llega: "+widget.tipoSub!);
    print("Llgea: "+widget.idTab!);
    isLoading = false;
    setState(() {});
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
                Text("DETALLES",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(
                  height: 15.0,
                ),
                _tipoGeneralController.text!="" ? TextFormField(
                  controller: _tipoGeneralController,
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  decoration: InputDecoration(
                    labelText: "NUMERO DE PLANILLA",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset("assets/icons/spider.svg"),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  maxLines: 1,
                  readOnly: true,
                ) : Container(),

                _tipoDocumentoController.text!="" ? SizedBox(height: 15.0,) :Container(),
                _tipoDocumentoController.text!="" ? TextFormField(
                  controller: _tipoDocumentoController,
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  decoration: InputDecoration(
                    labelText: "TIPO DOCUMENTO",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset("assets/icons/spider.svg"),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  maxLines: 1,
                  readOnly: true,
                ) : Container(),


                _docReferenciaController.text!="" ? SizedBox(height: 15.0,) :Container(),
                _docReferenciaController.text!="" ? TextFormField(
                  controller: _docReferenciaController,
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  decoration: InputDecoration(
                    labelText: "DOC REFERENCIA",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset("assets/icons/spider.svg"),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  maxLines: 1,
                  readOnly: true,
                ) : Container(),



                _fechaCaducidadController.text!="" ? SizedBox(height: 15.0,) :Container(),
                _fechaCaducidadController.text!="" ? TextFormField(
                  controller: _fechaCaducidadController,
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  decoration: InputDecoration(
                    labelText: "FECHA CADUCIDAD",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset("assets/icons/spider.svg"),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  maxLines: 1,
                  readOnly: true,
                ) : Container(),

                _kmCaducidadController.text!="" ? SizedBox(height: 15.0,) :Container(),
                _kmCaducidadController.text!="" ? TextFormField(
                  controller: _kmCaducidadController,
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  decoration: InputDecoration(
                    labelText: "KM CADUCIDAD",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset("assets/icons/spider.svg"),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  maxLines: 1,
                  readOnly: true,
                ) : Container(),


                _kmMantenimientoController.text!="" ? SizedBox(height: 15.0,) :Container(),
                _kmMantenimientoController.text!="" ? TextFormField(
                  controller: _kmMantenimientoController,
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  decoration: InputDecoration(
                    labelText: "KM MANTENIMIENTO",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset("assets/icons/spider.svg"),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  maxLines: 1,
                  readOnly: true,
                ) : Container(),



                _kmActualController.text!="" ? SizedBox(height: 15.0,) :Container(),
                _kmActualController.text!="" ? TextFormField(
                  controller: _kmActualController,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                  decoration: InputDecoration(
                    labelText: "KM ACTUAL",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset("assets/icons/spider.svg"),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  maxLines: 1,
                  readOnly: true,
                ) : Container(),


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

      ],
    )
        : Center(child: CircularProgressIndicator());
  }




}
