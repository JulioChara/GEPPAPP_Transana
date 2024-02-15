import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transana_app/src/services/informes_preventivos_services.dart';

class AlertasMantenimientosWidget extends StatefulWidget {
  String? idVehi = "";
  AlertasMantenimientosWidget({this.idVehi});

  @override
  State<AlertasMantenimientosWidget> createState() =>
      _AlertasMantenimientosWidgetState();
}

class _AlertasMantenimientosWidgetState
    extends State<AlertasMantenimientosWidget> {
  static List<TiposModel> tipos =[];

  final formKey = GlobalKey<FormState>();
  var loading = true;
  var defTipo = "";
  var defSubTipo = "";
  var objTipos = new InformePreventivoService(); //

  String selDateini = DateTime.now().toString().substring(0, 10);
  String selDatefin = DateTime.now().toString().substring(0, 10);

  TextEditingController kmInicialEditingController =
      new TextEditingController();
  TextEditingController kmRecorrerEditingController =
      new TextEditingController();
  TextEditingController kmMantenimientoEditingController =
      new TextEditingController();

  AlertasMantenimientosModel _saveMantenimientoModel =
      AlertasMantenimientosModel();
  InformePreventivoService _saveMantenimientoServices =
      InformePreventivoService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kmInicialEditingController.text = "0";
    kmRecorrerEditingController.text = "0";
    kmMantenimientoEditingController.text = "0";
    getData();
    //   print("ID ACTUAL: " + widget.idViajeW);
  }

  void getData() async {
    try {
      tipos = await objTipos.getAlertasTiposMantenimientos();
      defTipo = tipos[0].tipoId!;
      defSubTipo = "POR KILOMETRAJE";
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void registrar() {
    if (formKey.currentState!.validate()) {
      _saveMantenimientoModel.idAccion = 1;
      _saveMantenimientoModel.vehiculoFk = widget.idVehi;
      _saveMantenimientoModel.tipoDocFk = defTipo.toString();
      _saveMantenimientoModel.fechaEmision = selDateini.toString();
      _saveMantenimientoModel.fechaCaducidad = selDatefin.toString();
      _saveMantenimientoModel.kilometroInicial =
          kmInicialEditingController.text;
      _saveMantenimientoModel.kilometroMantenimiento =
          kmMantenimientoEditingController.text;
      _saveMantenimientoModel.kilometroCaducidad =
          kmRecorrerEditingController.text;
      if (defSubTipo == "POR FECHAS") {
        _saveMantenimientoModel.tipoControl = "1";
      } else if (defSubTipo == "POR KILOMETRAJE") {
        _saveMantenimientoModel.tipoControl = "2";
      }

      _saveMantenimientoServices
          .accionesAlertasMantenimientos(_saveMantenimientoModel)
          .then((value) {
        print("Salvadito ?");
        print(value);
        if (value != null) {
          if (value == "1") {
            print("Mantenimiento Save");
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
        ? AlertDialog(
            content: Form(
              key: formKey,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text("Alertas - Mantenimientos",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      SizedBox(
                        height: 15.0,
                      ),

                      DropdownButton(
                        value: defTipo,
                        isExpanded: true,
                        items: tipos
                            .map(
                              (e) => DropdownMenuItem(
                                child: Text(
                                  e.tipoDescripcion!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                value: e.tipoId,
                                // sRuc=  destinos[item].ruc,
                              ),
                            )
                            .toList(),
                        onChanged: (String? value) {
                          defTipo = value!;
                          // List<PlanillaComprobantesModel> lista = destinos.where((element) => element.id == value).toList();
                          // _rucController.text = lista.first.ruc;
                          // _montoController.text = lista.first.monto;
                          //  sDestino = lista.first.destino;
                          setState(() {});
                        },
                      ),

                      DropdownButton(
                        value: defSubTipo,
                        isExpanded: true,
                        underline: Container(
                          height: 1,
                          color: Colors.deepPurpleAccent,
                        ),
                        items: <String>['POR KILOMETRAJE', 'POR FECHAS']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          defSubTipo = value!;
                          // List<PlanillaComprobantesModel> lista = destinos.where((element) => element.id == value).toList();
                          // _rucController.text = lista.first.ruc;
                          // _montoController.text = lista.first.monto;
                          //  sDestino = lista.first.destino;
                          setState(() {
                            print(defSubTipo);
                            // if (defSubTipo == "POR FECHAS") {
                            //   _saveMantenimientoModel.tipoControl = "1";
                            // } else if (defSubTipo == "POR KILOMETRAJE") {
                            //   _saveMantenimientoModel.tipoControl = "2";
                            // }
                          });
                        },
                      ),

                      //-------------------FECHASSSSSSS--------------------//

                      SizedBox(
                        height: 15.0,
                      ),
                      defSubTipo == "POR FECHAS"
                          ? Text("Fecha Emision")
                          : Container(),
                      defSubTipo == "POR FECHAS"
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white, blurRadius: 3)
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
                            )
                          : Container(),

                      defSubTipo == "POR FECHAS"
                          ? SizedBox(
                              height: 15.0,
                            )
                          : Container(),
                      defSubTipo == "POR FECHAS"
                          ? Text("Fecha Caducidad")
                          : Container(),
                      defSubTipo == "POR FECHAS"
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white, blurRadius: 3)
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
                            )
                          : Container(),

                      //---------------------KILOMETRAJES---------------------//
                      defSubTipo == "POR KILOMETRAJE"
                          ? SizedBox(
                              height: 15.0,
                            )
                          : Container(),
                      defSubTipo == "POR KILOMETRAJE"
                          ? TextFormField(
                              controller: kmInicialEditingController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              decoration: InputDecoration(
                                hintText: "Kilometro Inicial",
                                labelText: "Kilometro Inicial",
                                prefixIcon: Container(
                                  width: 20,
                                  height: 40,
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    "assets/icons/kilometro.svg",
                                    color: Colors.blue,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              keyboardAppearance: Brightness.light,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String text) {},
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  kmInicialEditingController.text = "0";
                                  kmMantenimientoEditingController.text = (0 +
                                          int.parse(
                                              kmRecorrerEditingController.text))
                                      .toString();
                                }
                                kmMantenimientoEditingController
                                    .text = (int.parse(value) +
                                        int.parse(
                                            kmRecorrerEditingController.text))
                                    .toString();
                                //kmMantenimientoEditingController.text = (int.parse(kmInicialEditingController.text) + int.parse(kmRecorrerEditingController.text)).toString();
                              },
                            )
                          : Container(),
                      defSubTipo == "POR KILOMETRAJE"
                          ? SizedBox(
                              height: 15.0,
                            )
                          : Container(),
                      defSubTipo == "POR KILOMETRAJE"
                          ? TextFormField(
                              controller: kmRecorrerEditingController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              decoration: InputDecoration(
                                hintText: "Kilometro a Recorrer",
                                labelText: "Kilometro a Recorrer",
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
                                // print
                                if (value.isEmpty) {
                                  kmRecorrerEditingController.text = "0";
                                  kmMantenimientoEditingController
                                      .text = (int.parse(
                                              kmInicialEditingController.text) +
                                          0)
                                      .toString();
                                }
                                kmMantenimientoEditingController
                                    .text = (int.parse(
                                            kmInicialEditingController.text) +
                                        int.parse(value))
                                    .toString();
                                //  kmMantenimientoEditingController.text = (int.parse(kmInicialEditingController.text) + int.parse(kmRecorrerEditingController.text)).toString();
                              },
                            )
                          : Container(),

                      defSubTipo == "POR KILOMETRAJE"
                          ? SizedBox(
                              height: 15.0,
                            )
                          : Container(),
                      defSubTipo == "POR KILOMETRAJE"
                          ? TextFormField(
                              controller: kmMantenimientoEditingController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              decoration: InputDecoration(
                                hintText: "Kilometro Mantenimiento",
                                labelText: "Kilometro Mantenimiento",
                                prefixIcon: Container(
                                  width: 20,
                                  height: 40,
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    "assets/icons/kilometro.svg",
                                    color: Colors.amber,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              keyboardAppearance: Brightness.light,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String text) {},
                              readOnly: true,
                              // onChanged: (value) {
                              //   viajeModel.saldoInicial = value;
                              // },
                            )
                          : Container(),
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
          )
        : Center(child: CircularProgressIndicator());
  }

  Future<Null> _selectSelDateini(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
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
    final DateTime? picked = await showDatePicker(
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
