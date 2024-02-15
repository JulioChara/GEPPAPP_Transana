import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/models/planilla_gastos_model.dart';
import 'package:transana_app/src/services/planilla_gastos_services.dart';

class PlanillaShowWidget extends StatefulWidget {
  String? tipoDoc = "";
  String? idPla = "";
  PlanillaShowWidget({this.tipoDoc, this.idPla});

  @override
  State<PlanillaShowWidget> createState() => _PlanillaShowWidgetState();
}

class _PlanillaShowWidgetState extends State<PlanillaShowWidget> {
  final formKey = GlobalKey<FormState>();
  var loading = true;

  static List<PlanillaGastosVisorModel> visor =[];

  var objPlanillaGastosServices = new PlanillaGastosServices(); //

  TextEditingController _nroPlanillaController = TextEditingController();
  TextEditingController _lugarController = TextEditingController();
  TextEditingController _tipoComSerController = TextEditingController();
  TextEditingController _fechaDocController = TextEditingController();
  TextEditingController _comprobanteDocController = TextEditingController();
  TextEditingController _rucController = TextEditingController();
  TextEditingController _razonController = TextEditingController();
  TextEditingController _serieController = TextEditingController();
  TextEditingController _numeroController = TextEditingController();
  TextEditingController _montoController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print("TIPO DOCUMEMTO: " + widget.tipoDoc!);
    print("ID PLANILLA: " + widget.idPla!);
  }

  void getData() async {
    try {
      print("entro a consultar");
      visor = await objPlanillaGastosServices.getPlanillaGastosVisor(
          widget.tipoDoc!, widget.idPla!);

      _nroPlanillaController.text = visor[0].numeroPlanilla!;
      _lugarController.text = visor[0].lugar!;
      _tipoComSerController.text = visor[0].tipoComSer!;
      _fechaDocController.text = visor[0].fechaDoc!;
      _comprobanteDocController.text = visor[0].tipoComprobante!;
      _rucController.text = visor[0].ruc!;
      _razonController.text = visor[0].razonSocial!;
      _serieController.text = visor[0].serie!;
      _numeroController.text = visor[0].numero!;
      _montoController.text = visor[0].monto!;
      _descripcionController.text = visor[0].descripcion!;

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
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
                      Text("DETALLES",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      SizedBox(
                        height: 15.0,
                      ),
                     _nroPlanillaController.text!="" ? TextFormField(
                        controller: _nroPlanillaController,
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
                      _nroPlanillaController.text!="" ? SizedBox(
                        height: 15.0,
                      ):Container(),
                        _lugarController.text!="" ? TextFormField(
                        controller: _lugarController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        decoration: InputDecoration(
                          labelText: "LUGAR",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset("assets/icons/location.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 1,
                        readOnly: true,
                      ) :Container(),
                      _lugarController.text!="" ? SizedBox(
                        height: 15.0,
                      ) :Container(),

                    _tipoComSerController.text!="0" ?  TextFormField(
                        controller: _tipoComSerController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        decoration: InputDecoration(
                          labelText: "SUB TIPO",
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
                      ):Container(),
                      _tipoComSerController.text!="0" ? SizedBox(
                        height: 15.0,
                      ):Container(),
                      _fechaDocController.text!="" ? TextFormField(
                        controller: _fechaDocController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        decoration: InputDecoration(
                          labelText: "FECHA DOCUMENTO",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset("assets/icons/date.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 1,
                        readOnly: true,
                      ):Container(),
                      _fechaDocController.text!="" ? SizedBox(
                        height: 15.0,
                      ):Container(),

                        _comprobanteDocController.text!="" ? TextFormField(
                        controller: _comprobanteDocController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        decoration: InputDecoration(
                          labelText: "TIPO COMPROBANTE",
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
                      ):Container(),
                      _comprobanteDocController.text!="" ? SizedBox(
                        height: 15.0,
                      ):Container(),

                     _rucController.text!="" ?  TextFormField(
                        controller: _rucController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        decoration: InputDecoration(
                          //    hintText: "RUC",
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
                      ):Container(),
                      _rucController.text!="" ?  SizedBox(
                        height: 15.0,
                      ):Container(),

                      _razonController.text!="" ?  TextFormField(
                        controller: _razonController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        decoration: InputDecoration(
                          //    hintText: "RUC",
                          labelText: "RAZON SOCIAL",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset("assets/icons/razon.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 1,
                        readOnly: true,
                      ):Container(),
                      _razonController.text!="" ?  SizedBox(
                        height: 15.0,
                      ):Container(),

                      _serieController.text!="" ?  TextFormField(
                        controller: _serieController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        //   keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          //     hintText: "Serie",
                          labelText: "Serie",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child:
                                SvgPicture.asset("assets/icons/document.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 1,
                        readOnly: true,
                      ):Container(),
                      _serieController.text!="" ?  SizedBox(
                        height: 15.0,
                      ):Container(),

                      _numeroController.text!="" ?  TextFormField(
                        controller: _numeroController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        //  keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          //  hintText: "Numero",
                          labelText: "Numero",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child:
                                SvgPicture.asset("assets/icons/document.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 1,
                        readOnly: false,
                      ):Container(),
                      _numeroController.text!="" ?  SizedBox(
                        height: 15.0,
                      ) :Container(),

                    _montoController.text!="" ?   TextFormField(
                        controller: _montoController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        decoration: InputDecoration(
                          //          hintText: "Monto",
                          labelText: "MONTO",
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
                      ):Container(),
                     _montoController.text!="" ?  SizedBox(
                        height: 15.0,
                      ):Container(),

                      _descripcionController.text!="" ?  TextFormField(
                        controller: _descripcionController,
                        style: TextStyle(color: Colors.black54, fontSize: 16.0),
                        // keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          //     hintText: "Descripcion",
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
                        //   initialValue: sRuc,
                        maxLines: 3,
                        readOnly: true,
                      ) : Container()
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
