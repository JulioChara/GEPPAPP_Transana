


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/models/planilla_gastos_model.dart';
import 'package:transana_app/src/services/planilla_gastos_services.dart';

class PlanillaMovilidadWidget extends StatefulWidget {


  String? idViajeW="";
  String? tipoDocGasto="";
  PlanillaMovilidadWidget({
    this.idViajeW,
    this.tipoDocGasto
  });



  @override
  State<PlanillaMovilidadWidget> createState() => _PlanillaMovilidadWidgetState();
}

class _PlanillaMovilidadWidgetState extends State<PlanillaMovilidadWidget> {

  PlanillaGastosMovilidadModel _saveMovilidadModel = PlanillaGastosMovilidadModel();
  PlanillaGastosServices _saveMovilidadServices = PlanillaGastosServices();

  String selDate = DateTime.now().toString().substring(0, 10);

  TextEditingController _nroPlanillaController = TextEditingController();
  TextEditingController _montoController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();

  final formKey = GlobalKey<FormState>();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 //   print("ID ACTUAL: " + widget.idViajeW);
  }


  void registrar() {
    if (formKey.currentState!.validate()) {
      _saveMovilidadModel.viajeFk = widget.idViajeW;
      _saveMovilidadModel.tipoDocGasto = widget.tipoDocGasto;
      //_saveMovilidadModel.fecha = selDate; //fecha creacion se da por el webservice
      _saveMovilidadModel.concepto = _descripcionController.text;
      _saveMovilidadModel.monto = _montoController.text;
      _saveMovilidadModel.numeroPlanilla = _nroPlanillaController.text;
      _saveMovilidadModel.fechaDoc = selDate;
      _saveMovilidadModel.idAccion = 1;

      _saveMovilidadServices.accionesPlanillaMovilidad(_saveMovilidadModel)
          .then((value) {
            print(value);
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
    return  AlertDialog(
      content: Form(
        key: formKey,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Ingreso de Movilidad",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(height: 15.0,),

                TextFormField(
                  controller: _nroPlanillaController,
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Nro Planilla",
                    labelText: "Nro Planilla",
                    prefixIcon: Container(
                      width: 20,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset("assets/icons/document.svg"),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Ingrese un Numero de Planilla";
                    }
                    return null;
                  },
                  maxLines: 1,
                  readOnly: false,
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
                  controller: _montoController,
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "MONTO",
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
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Ingrese un monto";
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
                  validator: (String? value) {
                    if (value!.isEmpty) {
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
    );
  }





  Future<Null> _selectSelDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
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
