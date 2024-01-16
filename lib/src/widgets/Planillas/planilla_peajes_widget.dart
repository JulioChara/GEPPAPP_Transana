import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/models/planilla_gastos_model.dart';
import 'package:transana_app/src/services/planilla_gastos_services.dart';

class PlanillaPeajesWidget extends StatefulWidget {

  String idViajeW="";
  String tipoDocGasto="";
  PlanillaPeajesWidget({
    this.idViajeW,
    this.tipoDocGasto
  });
  @override
  State<PlanillaPeajesWidget> createState() => _PlanillaPeajesWidgetState();
}

class _PlanillaPeajesWidgetState extends State<PlanillaPeajesWidget> {



  static List<DestinosPeajesModel> destinos = new List<DestinosPeajesModel>();
  static List<PlanillaComprobantesModel> comprobantes = new List<PlanillaComprobantesModel>();

  var objPlanillaGastosServices = new PlanillaGastosServices(); //

  PlanillaGastosPeajesModel _savePeajesModel = PlanillaGastosPeajesModel();
  PlanillaGastosServices _savePeajesServices = PlanillaGastosServices();

  final formKey = GlobalKey<FormState>();
  var loading = true;
//Valores iniciales //
  var defDestino = "";
  var defComprobante = "";
  var sDestino ="";
  // var sRuc = "";
  // var sMonto = "";
  // var sSerie = "";
  // var sNumero = "";


  String selDate = DateTime.now().toString().substring(0, 10);

  TextEditingController _rucController = TextEditingController();
  TextEditingController _razonController = TextEditingController();
  TextEditingController _montoController = TextEditingController();
  TextEditingController _serieController = TextEditingController();
  TextEditingController _numeroController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print("ID ACTUAL: " + widget.idViajeW);
  }

  void getData() async {
    try {
      destinos = await objPlanillaGastosServices.getPeajesDestinos();
      comprobantes = await objPlanillaGastosServices.getTiposComprobantes();

      // defComprobante = comprobantes[0].tipoId;
      //defComprobante = destinos[0].tipoComprobante;  :o
      print("Comprobante ID: "+ destinos[0].tipoComprobante);
      defDestino = destinos[0].id;
      sDestino = destinos[0].destino;


      List<DestinosPeajesModel> lista = destinos.where((element) => element.id == defDestino).toList();
      defComprobante = lista.first.tipoComprobante;  //newwww
      _rucController.text = lista.first.ruc;
      _razonController.text = lista.first.razonSocial;
      _montoController.text = lista.first.monto;

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }



  void registrar() {
    if (formKey.currentState.validate()) {
       _savePeajesModel.viajeFk = widget.idViajeW;
      _savePeajesModel.tipoDocGasto = widget.tipoDocGasto;
       _savePeajesModel.fecha = selDate;  //dudadudsoa
     //  _savePeajesModel.
       _savePeajesModel.concepto = sDestino;
       _savePeajesModel.monto = _montoController.text;
       _savePeajesModel.lugar = sDestino;
       _savePeajesModel.ruc = _rucController.text;
       _savePeajesModel.fechaDoc = selDate;
       _savePeajesModel.tipoComprobante = defComprobante;
       _savePeajesModel.razonSocial = _razonController.text;
       _savePeajesModel.serie = _serieController.text;
       _savePeajesModel.numero = _numeroController.text;
       _savePeajesModel.idAccion = 1;


      // _procesoInformeModel.idDetalle = widget.idDetalle;
      // _procesoInformeModel.idAccion = widget.idAccion;
      print("Llegamos a Registrar");
      // if (widget.idAccion == 3) {  //ANULAR
      //   _procesoInformeModel.comentarioAnulado = _obsController.text;
      // } else if (widget.idAccion == 1) {  //PROCESAR
      //   _procesoInformeModel.comentarioProcesado = _obsController.text;
      //   _procesoInformeModel.idResponsableProcesado = idEmpleado;
      // } else if (widget.idAccion == 2) {  //SOLUCIONAR
      //   _procesoInformeModel.comentarioSolucionado = _obsController.text;
      //   // _procesoInformeModel.idResponsableSolucionado = valueInit;
      //   _procesoInformeModel.idResponsableSolucionado = idEmpleado;
      //   _procesoInformeModel.IdTipoSolucionado = idIncidencia; // nuevo xd
      // }

      _savePeajesServices
          .AccionesPlanillaPeajes(_savePeajesModel)
          .then((value) {
        print("Salvadito ?");
        if (value != null) {
          if (value == "1") {
            print("SE GUARDO");
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
                      Text("Ingreso de Peaje",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      SizedBox(height: 15.0,),
                      DropdownButton(
                        value: defDestino,
                        isExpanded: true,
                        items: destinos
                            .map(
                              (e) => DropdownMenuItem(
                            child: Text(
                              e.destino,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            value: e.id,
                                 // sRuc=  destinos[item].ruc,
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          defDestino = value;
                          List<DestinosPeajesModel> lista = destinos.where((element) => element.id == value).toList();
                          defComprobante = lista.first.tipoComprobante;
                          _rucController.text = lista.first.ruc;
                          _razonController.text = lista.first.razonSocial;
                          _montoController.text = lista.first.monto;
                          sDestino = lista.first.destino;
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
                      TextFormField(
                        controller: _rucController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        decoration: InputDecoration(
                          hintText: "RUC",
                          labelText: "RUC",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset("assets/icons/frame.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 1,
                        readOnly: true,
                      ),

                      SizedBox(height: 15.0,),
                      TextFormField(
                        controller: _razonController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        decoration: InputDecoration(
                          hintText: "RUC",
                          labelText: "RUC",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset("assets/icons/frame.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 1,
                        readOnly: true,
                      ),
                      SizedBox(height: 15.0,),
                      TextFormField(
                        controller: _montoController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
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
                        maxLines: 1,
                        readOnly: true,
                      ),
                      SizedBox(height: 15.0,),
                      //AQUA DATE
                  //    Expanded(
                   //     child: Container(
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
                    //  ),
                      //END AQUA DATE

                      SizedBox(height: 15.0,),
                      TextFormField(
                        controller: _serieController,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        decoration: InputDecoration(
                          hintText: "Serie Documento",
                          labelText: "Serie Documento",
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
                            return "Ingresa una Serie";
                          }
                          return null;
                        },
                       // initialValue: sRuc,
                        maxLines: 1,
                        readOnly: false,
                      ),
                      SizedBox(height: 15.0,),
                      TextFormField(
                        controller: _numeroController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Numero Documento",
                          labelText: "Numero Documento",
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
                            return "Ingresa un Numero";
                          }
                          return null;
                        },
                     //   initialValue: sRuc,
                        maxLines: 1,
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


}
