


import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/models/empleado_model.dart';
import 'package:transana_app/src/models/planilla_gastos_model.dart';
import 'package:transana_app/src/services/planilla_gastos_services.dart';

class PlanillaComprasWidget extends StatefulWidget {
  String idViajeW="";
  String tipoDocGasto="";
  PlanillaComprasWidget({
    this.idViajeW,
    this.tipoDocGasto
  });

  @override
  State<PlanillaComprasWidget> createState() => _PlanillaComprasWidgetState();
}

class _PlanillaComprasWidgetState extends State<PlanillaComprasWidget> {

  String selDate = DateTime.now().toString().substring(0, 10);

  static List<PlanillaComprobantesModel> comprobantes = new List<PlanillaComprobantesModel>();
  static List<PlanillaTipos_Compras_Servicios_Model> tiposCompras = new List<PlanillaTipos_Compras_Servicios_Model>();
  static PlanillaGastosConsultaSunatModel consultaRuc = new PlanillaGastosConsultaSunatModel();

  final formKey = GlobalKey<FormState>();
  var loading = true;
  var defComprobante = "";
  var defTipoCompra = "";
  var objPlanillaGastosServices = new PlanillaGastosServices(); //


  static List<EmpleadoModel> entidades = new List<EmpleadoModel>(); // empleado
  GlobalKey<AutoCompleteTextFieldState<EmpleadoModel>> keyEntidad = new GlobalKey();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  AutoCompleteTextField searchEntidad;
  String idEntidad = "";

  TextEditingController _rucController = TextEditingController();
  TextEditingController _razonController = TextEditingController();
  TextEditingController _serieController = TextEditingController();
  TextEditingController _numeroController = TextEditingController();
  TextEditingController _montoController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();

  PlanillaGastosComprasModel _saveComprasModel = PlanillaGastosComprasModel();
  PlanillaGastosServices _saveComprasServices = PlanillaGastosServices();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print("ID ACTUAL: " + widget.idViajeW);
  }

  void getData() async {
    try {
      entidades = await _saveComprasServices.getEntidadesList();
      comprobantes = await objPlanillaGastosServices.getTiposComprobantes();
      tiposCompras = await objPlanillaGastosServices.getTiposCompras();
      defComprobante = comprobantes[0].tipoId;
      defTipoCompra  = tiposCompras[0].tipoId;

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }





  void registrar() {
    if (formKey.currentState.validate()) {
      _saveComprasModel.viajeFk = widget.idViajeW;
      _saveComprasModel.tipoDocGasto = widget.tipoDocGasto;
      _saveComprasModel.concepto = _descripcionController.text;
      _saveComprasModel.monto = _montoController.text;
      _saveComprasModel.fechaDoc = selDate;
      _saveComprasModel.tipoCompra = defTipoCompra;
      _saveComprasModel.tipoComprobante = defComprobante;
      _saveComprasModel.ruc= _rucController.text;
      _saveComprasModel.razonSocial = _razonController.text;
      _saveComprasModel.serie = _serieController.text;
      _saveComprasModel.numero = _numeroController.text;
      _saveComprasModel.idAccion = "1";


      _saveComprasServices.accionesPlanillaCompras(_saveComprasModel)
          .then((value) {
        if (value != null) {
          if (value == "1") {
            Navigator.pop(context);
            // Navigator.pop(context);
          }
        }
      });
    }
  }

  void consultaSunat(String ruc) async {
    consultaRuc = await objPlanillaGastosServices.getConsultaSunat(ruc);
    _razonController.text = consultaRuc.razonSocial;  //newwww
    idEntidad = "0";
    setState(() {
      loading = false;
    });
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
                Text("Ingreso de Compra",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(height: 15.0,),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
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
                SizedBox(height: 15.0,),
                DropdownButton(
                  value: defTipoCompra,
                  isExpanded: true,
                  items: tiposCompras
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
                    defTipoCompra = value;
                    setState(() {});
                  },
                ),


                SizedBox(height: 15.0,),
                DropdownButton(
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
                ),

                SizedBox(height: 15.0,),
                Column(
                  children: [
                    searchEntidad = fieldEntidad(),
                  ] ,
                ),
                // TextFormField(
                //   controller: _rucController,
                //   style: TextStyle(color: Colors.black54, fontSize: 16.0),
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
                //       child: SvgPicture.asset("assets/icons/frame.svg"),
                //     ),
                //     border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10)),
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
                //           consultaSunat(_rucController.text);
                //         },
                //       ),
                //     ),
                //   ),
                //   validator: (String value) {
                //     if (value.isEmpty) {
                //       return "Ingrese un RUC";
                //     }
                //     return null;
                //   },
                //   maxLines: 1,
                //   readOnly: false,
                // ),
                SizedBox(height: 15.0,),
                TextFormField(
                  controller: _razonController,
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
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
                      child: SvgPicture.asset("assets/icons/frame.svg"),
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
                ),



                SizedBox(height: 15.0,),
                TextFormField(
                  controller: _serieController,
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: "Serie",
                    labelText: "Serie",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset("assets/icons/document.svg"),
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
                ),
                SizedBox(height: 15.0,),
                TextFormField(
                  controller: _numeroController,
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Numero",
                    labelText: "Numero",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset("assets/icons/document.svg"),
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
                ),
                SizedBox(height: 15.0,),

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
                      return "Ingrese un Monto";
                    }
                    return null;
                  },
                  maxLines: 1,
                  readOnly: false,
                ),


                SizedBox(height: 15.0,),

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
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Ingrese una descripcion";
                    }
                    return null;
                  },
                  //   initialValue: sRuc,
                  maxLines: 3,
                  readOnly: false,
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


  // Future _selectDateTime(BuildContext context) async {
  //   final date = await _selectDate(context);
  //   if (date == null) return;
  //
  //   final time = await _selectTime(context);
  //
  //   if (time == null) return;
  //   setState(() {
  //     dateTime = DateTime(
  //       date.year,
  //       date.month,
  //       date.day,
  //       time.hour,
  //       time.minute,
  //     );
  //   });
  // }

  // select date time picker


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
      controller: _rucController,
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
        suffixIcon:
        CircleAvatar(
          radius: 25,
          backgroundColor: Color(0xFF000000),
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              consultaSunat(_rucController.text);
            },
          ),
        ),
      ),
      itemFilter: (item, query) {
        //return item.entiRazonSocial.toLowerCase().contains(query.toLowerCase());
        return item.entiNroDocumento.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.entiRazonSocial.compareTo(b.entiRazonSocial);
      },
      itemSubmitted: (item) {
        setState(() {
          searchEntidad.textField.controller.text = item.entiNroDocumento;
          _razonController.text = item.entiRazonSocial;
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
