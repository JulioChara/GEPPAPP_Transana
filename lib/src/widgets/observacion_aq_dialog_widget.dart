import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/models/empleado_model.dart';
import 'package:transana_app/src/models/informe_detalle_model.dart';
import 'package:transana_app/src/models/proceso_informe_model.dart';
import 'package:transana_app/src/services/empleado_services.dart';
import 'package:transana_app/src/services/informe_detalle_services.dart';
import 'package:transana_app/src/services/informe_proceso_services.dart';
import 'package:transana_app/src/models/incidencias_model.dart';

class ObservacionAqDialogWidget extends StatefulWidget {
  String idCabezera;
  String idDetalle;
  String incidenciaGen;
  int idAccion;

  ObservacionAqDialogWidget({
    this.idCabezera,
    this.idDetalle,
    this.idAccion,
    this.incidenciaGen,
  });


  @override
  State<ObservacionAqDialogWidget> createState() =>
      _ObservacionAqDialogWidgetState();
}

class _ObservacionAqDialogWidgetState extends State<ObservacionAqDialogWidget> {
  static List<EmpleadoModel> empleado = new List<EmpleadoModel>(); // empleado
  static List<SubIncidenciasModel> subIncidencias = new List<SubIncidenciasModel>(); // Informe incidencias


  bool loading = true;
  GlobalKey<AutoCompleteTextFieldState<EmpleadoModel>> keyEmpleado = new GlobalKey();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  AutoCompleteTextField searchEmpleado;


  var objDetailServices = new EmpleadoService();
  var objInformeDetalleServices = new InformeDetalleService(); //

  EmpleadoService _empleadoService = EmpleadoService();
 // InformeDetalleService _infDetalleSer = InformeDetalleService(); //

  List<EmpleadoModel> empleadoList = [];
  List<SubIncidenciasModel> subIncidenciasList = []; //

  String valueInit = "";

  final formKey = GlobalKey<FormState>();
  TextEditingController _obsController = TextEditingController();
  ProcesoInformeModel _procesoInformeModel = ProcesoInformeModel();
  InformeProcesoService _informeProcesoService = InformeProcesoService();
  String idEmpleado = "";
  String idIncidencia = ""; //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

/*  getData() {
    _empleadoService.getEmpleadosList().then((value) {
      empleadoList = value;
      valueInit = empleadoList[0].entiId;
      setState(() {});
    });
  }
*/
  void getData() async {
    try {
      empleado = await objDetailServices.getEmpleadosList();
      subIncidencias = await objInformeDetalleServices.getIncidenciasDetalles(widget.incidenciaGen);

      idIncidencia = subIncidencias[0].tipoId;  // para que la lista no empieze en nada

      print("ahhh");
      print(widget.incidenciaGen);
      print(empleado.length);
      print(subIncidencias.length);
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void registrar() {
    if (formKey.currentState.validate()) {
      _procesoInformeModel.idCabezera = widget.idCabezera;
      _procesoInformeModel.idDetalle = widget.idDetalle;
      _procesoInformeModel.idAccion = widget.idAccion;

      if (widget.idAccion == 3) {  //ANULAR
        _procesoInformeModel.comentarioAnulado = _obsController.text;
      } else if (widget.idAccion == 1) {  //PROCESAR
        _procesoInformeModel.comentarioProcesado = _obsController.text;
        _procesoInformeModel.idResponsableProcesado = idEmpleado;
      } else if (widget.idAccion == 2) {  //SOLUCIONAR
        _procesoInformeModel.comentarioSolucionado = _obsController.text;
       // _procesoInformeModel.idResponsableSolucionado = valueInit;
        _procesoInformeModel.idResponsableSolucionado = idEmpleado;
        _procesoInformeModel.IdTipoSolucionado = idIncidencia; // nuevo xd
      }

      _informeProcesoService
          .registrarInformeProceso(_procesoInformeModel)
          .then((value) {
            print("dsdsd");
        if (value != null) {
          if (value == "1") {
            Navigator.pop(context);
            Navigator.pop(context);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !loading ? AlertDialog(
      content: Form(
        key: formKey,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Editar Observación"),
                SizedBox(
                  height: widget.idAccion != 3 ? 12.0 : 0,
                ),

                Column(
                  children: widget.idAccion != 3 ?  [
                    searchEmpleado = fieldEmpleado(),
                  ] : [],
                ),

                SizedBox(
                  height: 12.0,
                ),
                //com
                widget.idAccion == 2 ? DropdownButton(
                  value: idIncidencia,
                  isExpanded: true,
                  items: subIncidencias
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
                    idIncidencia = value;
                    setState(() {});
                  },
                ) : Container(),

//com
                SizedBox(
                  height: 20.0,
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
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Ingresa una observación";
                    }

                    return null;
                  },
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
            "Aceptar",
          ),
        ),
      ],
    ) : Center(child: CircularProgressIndicator());
  }

  //EXTERNOS

  AutoCompleteTextField<EmpleadoModel> fieldEmpleado() {
    //widget.idAccion != 3 ?
     return AutoCompleteTextField<EmpleadoModel>(
      key: keyEmpleado,
      clearOnSubmit: false,
      suggestions: empleado,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Responsable",
        labelText: "Responsable",
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
      ),
      itemFilter: (item, query) {
        return item.entiRazonSocial.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.entiRazonSocial.compareTo(b.entiRazonSocial);
      },
      itemSubmitted: (item) {
        setState(() {
          searchEmpleado.textField.controller.text = item.entiRazonSocial;
          idEmpleado = item.entiId;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowEmpleado(item);
      },
    );

  }

  Widget rowEmpleado(EmpleadoModel empleado) {
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
          // SizedBox(
          //   width: 10.0,
          // ),
          // Flexible(
          //   child: Text(
          //     empleado.entiNroDocumento,
          //     style: TextStyle(
          //       fontSize: 12.0,
          //       color: Colors.black54,
          //     ),
          //     overflow: TextOverflow.ellipsis,
          //   ),
          // ),
        ],
      ),
    );
  }
}
