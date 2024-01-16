import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/models/empleado_model.dart';
import 'package:transana_app/src/models/planilla_gastos_model.dart';
import 'package:transana_app/src/services/planilla_gastos_services.dart';

class PlanillaEstacionamientoWidget extends StatefulWidget {
  String idViajeW = "";
  String tipoDocGasto = "";
  PlanillaEstacionamientoWidget({this.idViajeW, this.tipoDocGasto});

  @override
  State<PlanillaEstacionamientoWidget> createState() =>
      _PlanillaEstacionamientoWidgetState();
}

class _PlanillaEstacionamientoWidgetState
    extends State<PlanillaEstacionamientoWidget> {
  var loading = true;
  final formKey = GlobalKey<FormState>();
  bool addButton = true;
  var defComprobante = "";

  var objPlanillaGastosServices = new PlanillaGastosServices(); //

  static List<EmpleadoModel> entidades = new List<EmpleadoModel>(); // empleado
  GlobalKey<AutoCompleteTextFieldState<EmpleadoModel>> keyEntidad =
      new GlobalKey();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  AutoCompleteTextField searchEntidad;
  String idEntidad = "";

  String selDate = DateTime.now().toString().substring(0, 10);

  //static List<PlanillaGastosConsultaSunatModel> consultaRuc = new List<PlanillaGastosConsultaSunatModel>();
  static PlanillaGastosConsultaSunatModel consultaRuc =
      new PlanillaGastosConsultaSunatModel();

  TextEditingController _montoController = TextEditingController();
  TextEditingController _documentoController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();

  TextEditingController _opcnumeroController = TextEditingController();
  TextEditingController _opcserieController = TextEditingController();
  TextEditingController _opcrucController = TextEditingController();

  TextEditingController _opcrazonController = TextEditingController();

  PlanillaGastosEstacionamientoModel _saveEstacionamientoModel =
      PlanillaGastosEstacionamientoModel();
  PlanillaGastosServices _saveEstacionamientoServices =
      PlanillaGastosServices();
  static List<PlanillaComprobantesModel> comprobantes =
      new List<PlanillaComprobantesModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _descripcionController.text = "ESTACIONAMIENTO";
  }

  void getData() async {
    try {
      entidades = await _saveEstacionamientoServices.getEntidadesList();
      comprobantes = await objPlanillaGastosServices.getTiposComprobantes();
      defComprobante = comprobantes[0].tipoId;

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void consultaSunat(String ruc) async {
    consultaRuc = await objPlanillaGastosServices.getConsultaSunat(ruc);
    _opcrazonController.text = consultaRuc.razonSocial; //newwww
    idEntidad = "0";
    setState(() {
      loading = false;
    });
  }

  void registrar() {
    if (formKey.currentState.validate()) {
      _saveEstacionamientoModel.viajeFk = widget.idViajeW;
      _saveEstacionamientoModel.tipoDocGasto = widget.tipoDocGasto;
      _saveEstacionamientoModel.concepto = _descripcionController.text;
      _saveEstacionamientoModel.fechaDoc = selDate;
      _saveEstacionamientoModel.monto = _montoController.text;

      if (addButton == false) {
        print("Se Enviaron Campos Extras Estacionamiento Save");
        _saveEstacionamientoModel.tipoComprobante = defComprobante;
        _saveEstacionamientoModel.ruc = _opcrucController.text;
        _saveEstacionamientoModel.razonSocial = _opcrazonController.text;
        _saveEstacionamientoModel.serie = _opcserieController.text;
        _saveEstacionamientoModel.numero = _opcnumeroController.text;
      } else {
        print("se envia alternativo");
        _saveEstacionamientoModel.tipoComprobante = "0";
      }

      _saveEstacionamientoModel.idAccion = 1;

      _saveEstacionamientoServices
          .accionesPlanillaEstacionamiento(_saveEstacionamientoModel)
          .then((value) {
        print("Salvadito ?");
        print(value);
        if (value != null) {
          if (value == "1") {
            print("Estacionamiento Save");
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
                      Text("Ingreso de Estacionamiento",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(color: Colors.white, blurRadius: 3)
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
                                selDate,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )
                            ],
                          ),
                          onPressed: () {
                            _selectSelDate(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                        controller: _montoController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Monto",
                          labelText: "Monto",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset("assets/icons/dolar.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Ingresa un Monto";
                          }
                          return null;
                        },
                        //   initialValue: sRuc,
                        maxLines: 1,
                        readOnly: false,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.pinkAccent, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          if (addButton == true) {
                            addButton = false;
                          } else {
                            addButton = true;
                          }

                          setState(() {
                            print(addButton);
                          });
                        },
                        child: !addButton
                            ? Text('Quitar Documento')
                            : Text('Agregar Documento'),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      // LAS NUEVAS xd///

                      !addButton
                          ? DropdownButton(
                              value: defComprobante,
                              isExpanded: true,
                              items: comprobantes
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: Text(
                                        e.tipoDescripcion,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      value: e.tipoId,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                defComprobante = value;
                                setState(() {});
                              },
                            )
                          : Container(),

                      !addButton
                          ? SizedBox(
                              height: 15.0,
                            )
                          : Container(),

                      // !addButton
                      //     ? TextFormField(
                      //   controller: _opcrucController,
                      //   style: TextStyle(
                      //       color: Colors.black54, fontSize: 16.0),
                      //   keyboardType: TextInputType.number,
                      //   inputFormatters: [
                      //     LengthLimitingTextInputFormatter(11),
                      //   ],
                      //   decoration: InputDecoration(
                      //     hintText: "RUC",
                      //     labelText: "RUC",
                      //     prefixIcon: Container(
                      //       width: 20,
                      //       height: 40,
                      //       padding: EdgeInsets.all(10),
                      //       child: SvgPicture.asset(
                      //           "assets/icons/frame.svg"),
                      //     ),
                      //
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10)),
                      //
                      //
                      //     suffixIcon:
                      //     CircleAvatar(
                      //       radius: 25,
                      //       backgroundColor: Color(0xFF000000),
                      //       child: IconButton(
                      //         icon: Icon(
                      //           Icons.search,
                      //           color: Colors.white,
                      //         ),
                      //         onPressed: () {
                      //           consultaSunat(_opcrucController.text);
                      //         },
                      //       ),
                      //
                      //     ),
                      //     // suffixIcon: IconButton(
                      //     //   onPressed: () {
                      //     //     consultaSunat(_opcrucController.text);
                      //     //   },
                      //     //   icon: Icon(Icons.search),
                      //     //   color: Colors.blue,
                      //     // ),
                      //   ),
                      //
                      //   //    IconButton(
                      //   //   onPressed: _controller.clear,
                      //   //   icon: Icon(Icons.clear),
                      //   // ),,
                      //   validator: (String value) {
                      //     if (value.isEmpty) {
                      //       return "Ingrese un RUC";
                      //     }
                      //     return null;
                      //   },
                      //   maxLines: 1,
                      //   readOnly: false,
                      // )
                      !addButton
                          ? SizedBox(
                              height: 15.0,
                            )
                          : Container(),
                      !addButton
                          ? Column(
                              children: [
                                searchEntidad = fieldEntidad(),
                              ],
                            )
                          : Container(),

                      !addButton
                          ? SizedBox(
                              height: 15.0,
                            )
                          : Container(),
                      !addButton
                          ? TextFormField(
                              controller: _opcrazonController,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16.0),
                              keyboardType: TextInputType.visiblePassword,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(500),
                              ],
                              decoration: InputDecoration(
                                hintText: "Razon Social",
                                labelText: "Razon Social",
                                prefixIcon: Container(
                                  width: 20,
                                  height: 40,
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                      "assets/icons/frame.svg"),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Ingrese una Razon Social";
                                }
                                return null;
                              },
                              maxLines: 1,
                              readOnly: false,
                            )
                          : Container(),
                      !addButton
                          ? SizedBox(
                              height: 15.0,
                            )
                          : Container(),
                      !addButton
                          ? TextFormField(
                              controller: _opcserieController,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16.0),
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                hintText: "Serie",
                                labelText: "Serie",
                                prefixIcon: Container(
                                  width: 20,
                                  height: 40,
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                      "assets/icons/document.svg"),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Ingrese una Serie";
                                }
                                return null;
                              },
                              maxLines: 1,
                              readOnly: false,
                            )
                          : Container(),
                      !addButton
                          ? SizedBox(
                              height: 15.0,
                            )
                          : Container(),
                      !addButton
                          ? TextFormField(
                              controller: _opcnumeroController,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16.0),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Numero",
                                labelText: "Numero",
                                prefixIcon: Container(
                                  width: 20,
                                  height: 40,
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                      "assets/icons/document.svg"),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Ingrese un Numero";
                                }
                                return null;
                              },
                              maxLines: 1,
                              readOnly: false,
                            )
                          : Container(),
                      SizedBox(
                        height: 15.0,
                      ),
                      //END NUEVOS CAMPOS OPCIONAES

                      TextFormField(
                        controller: _descripcionController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          hintText: "Descripcion",
                          labelText: "Descripcion",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset("assets/icons/edit.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        //     initialValue: "ALIMENTACION",
                        maxLines: 1,
                        readOnly: true,
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
                  "Aceptar",
                ),
              ),
            ],
          )
        : Center(child: CircularProgressIndicator());
  }

  Future<Null> _selectSelDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: new DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        selDate = picked.toString().substring(0, 10);
        print(selDate);
        //  _listViaje(context, viaje);
      });
  }

  AutoCompleteTextField<EmpleadoModel> fieldEntidad() {
    return AutoCompleteTextField<EmpleadoModel>(
      controller: _opcrucController,
      key: keyEntidad,
      clearOnSubmit: false,
      suggestions: entidades,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "RUC",
        labelText: "RUC",
        hintStyle: TextStyle(color: Colors.black54),
        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 17.0,
          height: 17.0,
          child: SvgPicture.asset(
            "assets/icons/frame.svg",
            color: Colors.black87.withOpacity(0.6),
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: CircleAvatar(
          radius: 25,
          backgroundColor: Color(0xFF000000),
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              consultaSunat(_opcrucController.text);
            },
          ),
        ),
      ),
      itemFilter: (item, query) {
        //return item.entiRazonSocial.toLowerCase().contains(query.toLowerCase());
        return item.entiNroDocumento
            .toLowerCase()
            .contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.entiRazonSocial.compareTo(b.entiRazonSocial);
      },
      itemSubmitted: (item) {
        setState(() {
          searchEntidad.textField.controller.text = item.entiNroDocumento;
          _opcrazonController.text = item.entiRazonSocial;
          idEntidad = item.entiId;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowEntidad(item);
      },
    );
  }

  Widget rowEntidad(EmpleadoModel empleado) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              empleado.entiRazonSocial,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                // fontSize: 16.0,
                fontSize: 14.0,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
