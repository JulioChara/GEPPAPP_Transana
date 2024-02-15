



import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/models/empleado_model.dart';
import 'package:transana_app/src/models/planilla_gastos_model.dart';
import 'package:transana_app/src/models/viajes_documentos/viajes_documentos_model.dart';
import 'package:transana_app/src/services/planilla_gastos_services.dart';
import 'package:transana_app/src/widgets/guardados_widget.dart';

class ViajesCrearDocumentoWidget extends StatefulWidget {


  @override
  State<ViajesCrearDocumentoWidget> createState() => _ViajesCrearDocumentoWidgetState();
}

class _ViajesCrearDocumentoWidgetState extends State<ViajesCrearDocumentoWidget> {

  var loading = true;
  final formKey = GlobalKey<FormState>();

  var objPlanillaGastosServices = new PlanillaGastosServices(); //
  var defComprobante = "";


  TextEditingController _rucController = TextEditingController();
  TextEditingController _razonController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  TextEditingController _serieController = TextEditingController();
  TextEditingController _numeroController = TextEditingController();
  TextEditingController _montoController = TextEditingController();

  AutoCompleteTextField? searchEntidad;
  GlobalKey<AutoCompleteTextFieldState<EmpleadoModel>> keyEntidad = new GlobalKey();

  PlanillaGastosServices _planillaServices = PlanillaGastosServices();

  String idEntidad = "";
  String selDate = DateTime.now().toString().substring(0, 10);

  static PlanillaGastosConsultaSunatModel consultaRuc = new PlanillaGastosConsultaSunatModel();
  static List<EmpleadoModel> entidades = []; // empl
  static List<PlanillaComprobantesModel> comprobantes =[];

  ViajeDocumentosModel _viajeDocumentosModel = new ViajeDocumentosModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }

  void getData() async {
    try {
      entidades = await _planillaServices.getEntidadesList();
      comprobantes = await objPlanillaGastosServices.getTiposComprobantes();
      defComprobante = comprobantes[0].tipoId!;

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }




  void consultaSunat(String ruc) async {
    consultaRuc = await objPlanillaGastosServices.getConsultaSunat(ruc);
    _razonController.text = consultaRuc.razonSocial!;  //newwww
    idEntidad = "0";  // sera enciado y se analizara al crear la entidad xd

    setState(() {
      loading = false;
    });

  }



  void registrar() {
    if (formKey.currentState!.validate()) {

      _viajeDocumentosModel.tipoDocumentoFk = defComprobante;
      _viajeDocumentosModel.ruc = _rucController.text;
      _viajeDocumentosModel.razonSocial = _razonController.text;
      _viajeDocumentosModel.fechaDocumento = selDate;
      _viajeDocumentosModel.serie = _serieController.text;
      _viajeDocumentosModel.numero = _numeroController.text;
      _viajeDocumentosModel.monto = _montoController.text;
      _viajeDocumentosModel.descripcion = _descripcionController.text;
      _viajeDocumentosModel.idAccion = "1";


      _planillaServices.accionesViajesDocumentos(_viajeDocumentosModel)
          .then((value) {
        if (value != null) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {

              //ALIMENTOS
              return GuardadosWidget(result: value,);
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
                Text("Crear Nuevo Documento",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(
                  height: 15.0,
                ),

                DropdownButton(
                  value: defComprobante,
                  isExpanded: true,
                  items: comprobantes
                      .map(
                        (e) => DropdownMenuItem(
                      child: Text(
                        e.tipoDescripcion!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      value: e.tipoId,
                    ),
                  )
                      .toList(),
                  onChanged: (String? value) {
                    defComprobante = value!;
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),

                Column(
                  children: [
                    searchEntidad = fieldEntidad(),
                  ] ,
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _razonController,
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
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Ingrese una Razon Social";
                    }
                    return null;
                  },
                  maxLines: 1,
                  readOnly: false,
                ),
                SizedBox(
                  height: 15.0,
                ),

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
                  controller: _serieController,
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
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Ingrese una Serie";
                    }
                    return null;
                  },
                  maxLines: 1,
                  readOnly: false,
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _numeroController,
                  style: TextStyle(
                      color: Colors.black54, fontSize: 16.0),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
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
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Ingrese un Numero";
                    }
                    return null;
                  },
                  maxLines: 1,
                  readOnly: false,
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _montoController,
                  style: TextStyle(
                      color: Colors.black54, fontSize: 16.0),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Monto",
                    labelText: "Monto",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset(
                          "assets/icons/dolar.svg"),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Ingrese un Numero";
                    }
                    return null;
                  },
                  maxLines: 1,
                  readOnly: false,
                ),
                SizedBox(
                  height: 15.0,
                ),





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
            "Crear",
          ),
        ),
      ],
    )
        : Center(child: CircularProgressIndicator());
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
        return item.entiNroDocumento!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.entiRazonSocial!.compareTo(b.entiRazonSocial!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchEntidad!.textField!.controller!.text = item.entiNroDocumento!;
          _razonController.text = item.entiRazonSocial!;
          idEntidad = item.entiId!;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowEntidad(item);
      },
    );
  }

  Widget rowEntidad(EmpleadoModel entidad) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              entidad.entiRazonSocial!,
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




  Future<Null> _selectSelDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: DateTime.parse(selDate),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        selDate = picked.toString().substring(0, 10);
        print(selDate);
        //  _listViaje(context, viaje);
      });
  }




}
