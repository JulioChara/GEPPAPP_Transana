import 'package:flutter/material.dart';
import 'package:transana_app/src/models/empleado_model.dart';
import 'package:transana_app/src/models/proceso_informe_model.dart';
import 'package:transana_app/src/services/empleado_services.dart';
import 'package:transana_app/src/services/informe_proceso_services.dart';

class ObservacionDialogWidget extends StatefulWidget {
  String idCabezera;
  String idDetalle;
  int idAccion;

  ObservacionDialogWidget({
    this.idCabezera,
    this.idDetalle,
    this.idAccion,
  });

  @override
  State<ObservacionDialogWidget> createState() =>
      _ObservacionDialogWidgetState();
}

class _ObservacionDialogWidgetState extends State<ObservacionDialogWidget> {

  EmpleadoService _empleadoService = EmpleadoService();
  List<EmpleadoModel> empleadoList = [];
  String valueInit = "";
  final formKey = GlobalKey<FormState>();
  TextEditingController _obsController = TextEditingController();
  ProcesoInformeModel _procesoInformeModel = ProcesoInformeModel();
  InformeProcesoService _informeProcesoService = InformeProcesoService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    _empleadoService.getEmpleadosList().then((value) {
      empleadoList = value;
      valueInit = empleadoList[0].entiId;
      setState(() {});
    });
  }

  void registrar(){
    if(formKey.currentState.validate()){

      _procesoInformeModel.idCabezera = widget.idCabezera;
      _procesoInformeModel.idDetalle = widget.idDetalle;
      _procesoInformeModel.idAccion = widget.idAccion;

      if( widget.idAccion == 3){
        _procesoInformeModel.comentarioAnulado = _obsController.text;
      }else if( widget.idAccion == 1){
        _procesoInformeModel.comentarioProcesado = _obsController.text;
        _procesoInformeModel.idResponsableProcesado = valueInit;
      }else if(widget.idAccion == 2){
        _procesoInformeModel.comentarioSolucionado = _obsController.text;
        _procesoInformeModel.idResponsableSolucionado = valueInit;
      }

      _informeProcesoService.registrarInformeProceso(_procesoInformeModel).then((value){
        if(value != null){
          if(value == "1"){
            Navigator.pop(context);
            Navigator.pop(context);
          }
        }
      });

    }
  }



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Editar Observación"),
            SizedBox(
              height: 12.0,
            ),
            widget.idAccion != 3 ? DropdownButton(
              value: valueInit,
              isExpanded: true,
              items: empleadoList
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(
                        e.entiRazonSocial,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      value: e.entiId,
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                valueInit = value;
                setState(() {});
              },
            ) : Container(),
            SizedBox(
              height: 12.0,
            ),
            TextFormField(
              controller: _obsController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Observación",
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                errorBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
              validator: (String value){

                if(value.isEmpty){
                  return "Ingresa una observación";
                }

                return null;
              },
            ),
          ],
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
    );
  }
}

