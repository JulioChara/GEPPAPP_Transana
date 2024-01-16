


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/models/informe_detalle_model.dart';
import 'package:transana_app/src/services/informe_detalle_services.dart';


class ObservacionEstadoDetalleDialog extends StatefulWidget {

  String idDetalle;

  ObservacionEstadoDetalleDialog({
    this.idDetalle
  });

  @override
  State<ObservacionEstadoDetalleDialog> createState() => _ObservacionEstadoDetalleDialogState();
}

class _ObservacionEstadoDetalleDialogState extends State<ObservacionEstadoDetalleDialog> {
  bool loading = true;

  static List<InformeDetalleModel> detallesxId = new List<InformeDetalleModel>(); // Informe incidencias

  var objInformeDetalleServices = new InformeDetalleService(); //

  String idDetalle = ""; //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Obtenemos:" + widget.idDetalle);
    getData();
  }


  void getData() async {
    try {
      detallesxId = await objInformeDetalleServices.getInformeDetallesxId(widget.idDetalle);
      idDetalle = detallesxId[0].idDetalle;

      setState(() {
        loading = false;
      });


    } catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return  !loading ? AlertDialog(
      content: Form(
       // key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("ESTADO DE INCIDENCIA", style: TextStyle(fontSize: 20),),
              SizedBox(
                height: 12.0,
              ),
              Text(detallesxId[0].idTipoEstadoAtencionDesc, style: TextStyle(fontSize: 20),),
              SizedBox(height: 12.0,),

              //PLACA
              TextFormField(
                style: TextStyle(
                    color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "-",
                  labelText: "Placa",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                        "assets/icons/car-parking.svg"),
                  ),

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                textAlign: TextAlign.center,
                initialValue: detallesxId[0].Placa,
                readOnly: true,
              //  enabled: false,
              ),
              SizedBox(height: 12.0,),

              //CONDUCTOR
              TextFormField(
                style: TextStyle(
                    color: Colors.black54, fontSize: 16.0),
                decoration: InputDecoration(
                  hintText: "-",
                  labelText: "Conductor",
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
                initialValue: detallesxId[0].Conductor,
                maxLines: 3,
                readOnly: true,
              ),
              SizedBox(height: 12.0,),

              //DESCRIPCION INCIDENCIA
              TextFormField(
                style: TextStyle(
                    color: Colors.black54, fontSize: 16.0),
                decoration: InputDecoration(
                  hintText: "-",
                  labelText: "Descripcion Incidencia",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                        "assets/icons/edit.svg"),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                initialValue: detallesxId[0].descripcion,
                maxLines: 3,
                readOnly: true,
              ),
              SizedBox(height: 12.0,),

             // ---------------- PROCESAMIENTO ------------------ //
              detallesxId[0].idResponsableProcesado !="0" ?  Text("PROCESAR", style: TextStyle(fontSize: 14, color: Colors.blue)) : Container(),
              detallesxId[0].idResponsableProcesado !="0" ? Divider(
                color: Colors.blue,
                height: 40,
                thickness: 3,
                indent: 15,
              ) : Container(),
              detallesxId[0].idResponsableProcesado !="0" ? TextFormField(
                style: TextStyle(
                    color: Colors.black54, fontSize: 16.0),
                decoration: InputDecoration(
                  hintText: "-",
                  labelText: "Asignado A",
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
                initialValue: detallesxId[0].idResponsableProcesadoDesc,
                maxLines: 1,
                readOnly: true,
              ) : Container(),
              SizedBox(height: 12.0,),
                      // FECHA DE PROCESADO
              detallesxId[0].idResponsableProcesado !="0" ? TextFormField(
                style: TextStyle(
                    color: Colors.black54, fontSize: 16.0),
                decoration: InputDecoration(
                  hintText: "-",
                  labelText: "Fecha Procesado",
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
                initialValue: detallesxId[0].fechaProcesar,
                maxLines: 1,
                readOnly: true,
              ) : Container(),
              SizedBox(height: 12.0,),
                        // Descripcion Procesado
              detallesxId[0].idResponsableProcesado !="0" ? TextFormField(
                style: TextStyle(
                    color: Colors.black54, fontSize: 16.0),
                decoration: InputDecoration(
                  hintText: "-",
                  labelText: "Descripcion",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                        "assets/icons/edit.svg"),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                initialValue: detallesxId[0].comentarioProcesado,
                maxLines: 3,
                readOnly: true,
              ) : Container(),
              // ---------------- END PROCESAMIENTO ------------------ //

              SizedBox(height: 12.0,),
              // ---------------- SOLUCIONES ------------------ //
              detallesxId[0].idResponsableSolucionado !="0" ?  Text("SOLUCION", style: TextStyle(fontSize: 14, color: Colors.green)) : Container(),

              detallesxId[0].idResponsableSolucionado !="0" ? Divider(
                color: Colors.green,
                height: 40,
                thickness: 3,
                indent: 15,
              ) : Container(),
              SizedBox(height: 12.0,),
                            // solucionado por
              detallesxId[0].idResponsableSolucionado != "0" ? TextFormField(
                style: TextStyle(
                    color: Colors.black54, fontSize: 16.0),
                decoration: InputDecoration(
                  hintText: "-",
                  labelText: "Solucionado por",
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
                initialValue: detallesxId[0].idResponsableSolucionadoDesc,
                maxLines: 1,
                readOnly: true,
              ): Container(),
              SizedBox(height: 12.0,),
                            // fecha solucion
              detallesxId[0].idResponsableSolucionado != "0" ? TextFormField(
                style: TextStyle(
                    color: Colors.black54, fontSize: 16.0),
                decoration: InputDecoration(
                  hintText: "-",
                  labelText: "Fecha Solucion",
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
                initialValue: detallesxId[0].fechaSolucionado,
                maxLines: 1,
                readOnly: true,
              ): Container(),
              SizedBox(height: 12.0,),
                          // incidencia DROWN
              detallesxId[0].idResponsableSolucionado != "0" ? TextFormField(
                style: TextStyle(
                    color: Colors.black54, fontSize: 16.0),
                decoration: InputDecoration(
                  hintText: "-",
                  labelText: "Especificacion",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                        "assets/icons/gear.svg"),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                initialValue: detallesxId[0].idTipoIncidenciaDesc,
                maxLines: 1,
                readOnly: true,
              ): Container(),
              SizedBox(height: 12.0,),
                            // descripcion solucion
              detallesxId[0].idResponsableSolucionado != "0" ? TextFormField(
                style: TextStyle(
                    color: Colors.black54, fontSize: 16.0),
                decoration: InputDecoration(
                  hintText: "-",
                  labelText: "Descripcion Solucion",
                  prefixIcon: Container(
                    width: 20,
                    height: 40,
                    padding: EdgeInsets.all(10),
                    child: SvgPicture.asset(
                        "assets/icons/service.svg"),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                initialValue: detallesxId[0].comentarioSolucionado,
                maxLines: 3,
                readOnly: true,
              ): Container(),
              SizedBox(height: 12.0,),

              // ---------------- SOLUCIONES END ------------------ //

            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cerrar",
          ),
        ),
      ],


    ) : Center(child: CircularProgressIndicator());
  }















}
