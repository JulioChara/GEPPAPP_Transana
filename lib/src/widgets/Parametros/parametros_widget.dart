


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transana_app/src/services/parametros_services.dart';
import 'package:transana_app/src/widgets/guardados_widget.dart';



class ParametrosWidget extends StatefulWidget {

  @override
  State<ParametrosWidget> createState() => _ParametrosWidgetState();

}

class _ParametrosWidgetState extends State<ParametrosWidget> {

  var loading = true;
  final formKey = GlobalKey<FormState>();

  var parametrosServices = new ParametrosServices(); //
  var defTipoGeneral = "";

  TextEditingController _descripcionCortaController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();


  static List<TiposModel> tiposgeneral = new List<TiposModel>();
  TiposModel _tiposModel = new TiposModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    try {
      tiposgeneral = await parametrosServices.getTiposEditableList();
      defTipoGeneral = tiposgeneral[0].tipoId;

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }


  void registrar() {
    if (formKey.currentState.validate()) {

      _tiposModel.idAccion =  "1";
      _tiposModel.idTipoGeneralFk = defTipoGeneral;
      _tiposModel.tipoDescripcionCorta = _descripcionCortaController.text;
      _tiposModel.tipoDescripcion = _descripcionController.text;

      parametrosServices.accionesParametrosTipos(_tiposModel)
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
                Text("Crear Nuevo Tipo",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                SizedBox(
                  height: 15.0,
                ),

                DropdownButton(
                  value: defTipoGeneral,
                  isExpanded: true,
                  items: tiposgeneral
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
                    defTipoGeneral = value;
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 15.0,
                ),


                TextFormField(
                  controller: _descripcionCortaController,
                  style: TextStyle(
                      color: Colors.black54, fontSize: 16.0),
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(3),
                  ],
                  decoration: InputDecoration(
                    hintText: "Descripcion Corta",
                    labelText: "Descripcion Corta",
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
                  maxLines: 1,
                  readOnly: false,
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: _descripcionController,
                  style: TextStyle(
                      color: Colors.black54, fontSize: 16.0),
                  keyboardType: TextInputType.visiblePassword,

                  decoration: InputDecoration(
                    hintText: "Descripcion",
                    labelText: "Descripcion",
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
                      return "Ingrese una Descripcion";
                    }
                    return null;
                  },
                  maxLines: 1,
                  readOnly: false,
                ),
                SizedBox(
                  height: 15.0,
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
            "Crear",
          ),
        ),
      ],
    )
        : Center(child: CircularProgressIndicator());
  }








}
