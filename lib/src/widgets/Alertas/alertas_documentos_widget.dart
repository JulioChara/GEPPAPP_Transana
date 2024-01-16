


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transana_app/src/services/informes_preventivos_services.dart';

class AlertasDocumentosWidget extends StatefulWidget {


  String idVehi = "";
  AlertasDocumentosWidget({this.idVehi});

  @override
  State<AlertasDocumentosWidget> createState() => _AlertasDocumentosWidgetState();
}

class _AlertasDocumentosWidgetState extends State<AlertasDocumentosWidget> {


  static List<TiposModel> tipos = new List<TiposModel>();
  final formKey = GlobalKey<FormState>();
  var loading = true;
  var defTipo = "";
  var objTipos = new InformePreventivoService(); //

  String selDateini = DateTime.now().toString().substring(0, 10);
  String selDatefin = DateTime.now().toString().substring(0, 10);

  TextEditingController _docRefController = TextEditingController();



  AlertasDocumentosModel _saveDocumentoModel =
  AlertasDocumentosModel();
  InformePreventivoService _saveDocumentosServices = InformePreventivoService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
 //   print("ID ACTUAL: " + widget.idViajeW);
  }

  void getData() async {
    try {

      tipos = await objTipos.getAlertasTiposDocumentos();
      defTipo = tipos[0].tipoId;

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }




  void registrar() {
    if (formKey.currentState.validate()) {
      _saveDocumentoModel.idAccion = "1";
      _saveDocumentoModel.vehiculoFk = widget.idVehi;
      _saveDocumentoModel.tipoDocFk = defTipo.toString();
      _saveDocumentoModel.documemtoRef = _docRefController.text;
      _saveDocumentoModel.fechaEmision = selDateini.toString();
      _saveDocumentoModel.fechaCaducidad = selDatefin.toString();

      _saveDocumentosServices
          .accionesAlertasDocumentos(_saveDocumentoModel)
          .then((value) {
        print("Salvadito ?");
        print(value);
        if (value != null) {
          if (value == "1") {
            print("Documento Save");
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
                Text("Alertas - Documentos",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(height: 15.0,),

                DropdownButton(
                  value: defTipo,
                  isExpanded: true,
                  items: tipos
                      .map(
                        (e) => DropdownMenuItem(
                      child: Text(
                        e.tipoDescripcion,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      value: e.tipoId,
                      // sRuc=  destinos[item].ruc,
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    defTipo = value;
                    // List<PlanillaComprobantesModel> lista = destinos.where((element) => element.id == value).toList();
                    // _rucController.text = lista.first.ruc;
                    // _montoController.text = lista.first.monto;
                    //  sDestino = lista.first.destino;
                    setState(() {});
                  },
                ),

                SizedBox(height: 15.0,),
                TextFormField(
                  controller: _docRefController,
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: "Doc. Referencia",
                    labelText: "Doc. Referencia",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset("assets/icons/edit.svg"),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  // validator: (String value) {
                  //   if (value.isEmpty) {
                  //     return "Ingrese una descripcion";
                  //   }
                  //   return null;
                  // },
                  //   initialValue: sRuc,
                  maxLines: 1,
                  readOnly: false,
                ),
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










