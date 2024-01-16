import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transana_app/src/services/informes_preventivos_services.dart';
import 'package:transana_app/src/widgets/Alertas/alertas_actualizarKM_widget.dart';
import 'package:transana_app/src/widgets/Alertas/alertas_detalles_widget.dart';
import 'package:transana_app/src/widgets/Alertas/alertas_documentos_widget.dart';
import 'package:transana_app/src/widgets/Alertas/alertas_finalizarAlerta_widget.dart';
import 'package:transana_app/src/widgets/Alertas/alertas_mantenimiento_widget.dart';
import 'package:transana_app/src/widgets/Alertas/alertas_renovarDocumento_widget.dart';
import 'package:transana_app/src/widgets/Alertas/alertas_renovarMantenimiento_widget.dart';

class AlertasPage extends StatefulWidget {
  @override
  State<AlertasPage> createState() => _AlertasPageState();
}

class _AlertasPageState extends State<AlertasPage> {
  var alertas = new InformePreventivoService();
  bool isLoading = true;
  String idVehiculo = "";
  String sInicial = "";
  double saldoFinal = 0;
  String idSend = "";

  List<AlertasListadoModel> alertasListadoList = [];
  //plantillaGastosList
  //
  // PlanillaGastosEliminarModel _deletePeajesModel =
  // PlanillaGastosEliminarModel();
  // PlanillaGastosServices _deletePeajesServices = PlanillaGastosServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString("idUser");
    String idV = await prefs.getString("IdVehiculo");

    print(idV);
    // String sInicial = await prefs.getString("sInicial");
    idVehiculo = idV;
    sInicial = sInicial;
    alertasListadoList = await alertas.getAlertasListado(idVehiculo);
    // saldoFinal = 0;
    // saldoFinal = double.parse(widget.saldoInicial);

    isLoading = false;
    setState(() {});
  }

  // showFormulario() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return PlanillaDocumentosWidget(
  //         //PARAMETROS
  //           idViajeW: idViaje);
  //     },
  //   );
  // }

  // void eliminarItem(String tipoDoc, String idPlanilla) {
  //   // loading = true;
  //
  //   _deletePeajesModel.idTipoDocGasto = tipoDoc;
  //   _deletePeajesModel.idPlanilla = idPlanilla;
  //
  //   _deletePeajesServices.eliminarPlanillaDetalles(_deletePeajesModel).then(
  //         (value) {
  //       if (value != null) {
  //         if (value == "1") {
  //           getData();
  //           Navigator.pop(context);
  //         }
  //       }
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Listado de Alertas",
          maxLines: 2,
          // style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (choice) => choiceActionDoc(choice, context),
            icon: Icon(Icons.add),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Documentos"),
                // value: 10763,
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Mantenimientos"),
                //  value: 10769,
                value: 2,
              ),
            ],
          )
        ],
      ),
      body: !isLoading
          ? Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: alertasListadoList.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        onTap: () {
                          showDetalles(alertasListadoList[i].documentoGeneral,
                              alertasListadoList[i].idTab);
                          //  alertasListadoList[i].plaId);
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${alertasListadoList[i].documentoGeneral}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            //  Text(
                            // //   "${double.parse(alertasListadoList[i].fechaCaducidad).toStringAsFixed(2)}",
                            //    "${alertasListadoList[i].fechaCaducidad}",
                            //    overflow: TextOverflow.ellipsis,
                            //    maxLines: 1,
                            //    style: TextStyle(
                            //        fontWeight: FontWeight.bold,
                            //        color: Colors.black54),
                            //  ),
                          ],
                        ),
                        subtitle:
                            Text(alertasListadoList[i].tipoDocumentoFkDesc),
                        leading: Icon(
                          Icons.content_paste,
                          color: Colors.redAccent,
                        ),
                        // trailing: alertasListadoList[i].documentoGeneral =="Mantenimientos" && alertasListadoList[i].alertaKM =="False" ?   null : FutureBuilder(
                        trailing: alertasListadoList[i].estadoAlerta == "False"
                            ? null
                            : FutureBuilder(
                                //  future: getIdRol(),
                                builder:
                                    (BuildContext context, AsyncSnapshot snap) {
                                  // if (snap.hasData) {
                                  //    String idRol = snap.data;
                                  return PopupMenuButton<String>(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.redAccent,
                                    ),
                                    itemBuilder: (BuildContext context) {
                                      //    String anular = "Anular";
                                      List<String> choices = new List();
                                      // choices.add(anular);
                                      // choices.add("Ver Detalle");
                                      return [
                                        PopupMenuItem<String>(
                                          value: (alertasListadoList[i]
                                                          .documentoGeneral ==
                                                      "Documento"
                                                  ? alertasListadoList[i].idTab
                                                  : alertasListadoList[i]
                                                      .vehiId) +
                                              "," +
                                              alertasListadoList[i]
                                                  .documentoGeneral +
                                              "," +
                                              alertasListadoList[i].kmActual +
                                              "," +
                                              alertasListadoList[i].idTab,
                                          //alertasListadoList[i].documentoGeneral == "Documento" ? "Renovar" : "Actualizar KM",
                                          // child: alertasListadoList[i].documentoGeneral == "Documento" ? Text("Renovar") : Text("Actualizar KM") ,
                                          child: alertasListadoList[i]
                                                      .documentoGeneral ==
                                                  "Documento"
                                              ? Text("Renovar")
                                              : alertasListadoList[i]
                                                          .kmActual !=
                                                      ""
                                                  ? Text("Actualizar KM")
                                                  : Text("Renovar"),
                                        ),
                                        PopupMenuItem<String>(
                                          value: (alertasListadoList[i].idTab) +
                                              "," +
                                              "Finalizar" +
                                              "," +
                                              alertasListadoList[i].kmActual +
                                              "," +
                                              ( alertasListadoList[i].documentoGeneral =="Documento" ? "1" : "2"),
                                             // alertasListadoList[i].idTab,
                                          //alertasListadoList[i].documentoGeneral == "Documento" ? "Renovar" : "Actualizar KM",
                                          // child: alertasListadoList[i].documentoGeneral == "Documento" ? Text("Renovar") : Text("Actualizar KM") ,
                                          child: Text("Finalizar"),
                                        ),
                                      ];
                                    },
                                    onSelected: choiceAction,
                                  );
                                  //  }

                                  return SizedBox(
                                    width: 1,
                                    height: 1,
                                  );
                                },
                              ),
                      );
                    },
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  choiceAction(String choice) {
    var arr = choice.split(',');
    print("Full Array INI");
    print(arr);
    print("Full Array END");
    String sendID = arr[0];
    print("Valuess" + arr[0]);
    showDialog(
      context: context,
      barrierDismissible: false,
      // builder: (BuildContext context) {
      //   //return arr[1] == "Documento" ? AlertasRenovarDocumento(idDoc: sendID) :  AlertasActualizarKM(idVeh: sendID);7
      //   return arr[1] == "Documento" ? AlertasRenovarDocumento(idDoc: sendID) : arr[2] != "" ? AlertasActualizarKM(idVeh: sendID) : AlertasRenovarMantenimiento(idVeh: sendID, idMan: arr[3]);
      // },
      builder: (BuildContext context) {
        if (arr[1] == "Finalizar") {
          //DOCUMENTOS
          return FinalizarAlertaWidget(tipoSub: arr[3],idTab: sendID,);
         // return AlertasRenovarDocumento(idDoc: sendID);
        } else {
          //MANTENIMIENTOS

          if (arr[1] == "Documento") {
            return AlertasRenovarDocumento(idDoc: sendID);
          }
          else
            {
              if (arr[2] != ""){
                return  AlertasActualizarKM(idVeh: sendID);
              }
              else
                {
                  return AlertasRenovarMantenimiento(idVeh: sendID, idMan: arr[3]);
                }
            }
          return Container();
        }
      //  return Container();
      },
    );
  }

  void choiceActionDoc(int choice, BuildContext context) {
    print(choice);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (choice == 1) {
            //DOCUMENTOS
            return AlertasDocumentosWidget(idVehi: idVehiculo);
          } else if (choice == 2) {
            //MANTENIMIENTOS
            return AlertasMantenimientosWidget(
              idVehi: idVehiculo,
            );
          }
          return Container();
        }
        //   },
        ).then((val) {
      //Navigator.pop(context);
      getData();
      setState(() {});
    });
  }

  //
  //  choiceActionDoc(String choice) {
  //  // idInformeSeleccionada = choice;
  //   var arr = choice.split(',');
  //
  //   if (arr[1] == "Documento")
  //   {
  //     print("Somos Documentos");
  //       return AlertasRenovarDocumento(
  //         idDoc: arr[0],
  //       );
  //
  //     //     idViajeW: idViaje, tipoDocGasto: choice.toString());
  //    // vincularId2(arr[0], arr[1]);
  //    //  Navigator.push(
  //    //    context,
  //    //    MaterialPageRoute(
  //    //      builder: (context) => AlertasRenovarDocumento(idDoc: "1",),
  //    //    ),
  //    //  );
  //
  //   }
  //   else if(arr[1] == "Mantenimientos")
  //     {
  //       print("Somos Mantenimientos");
  //     }
  // }
  //
  //

  showDetalles(String Tipo, String idTab) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertaDetallesWidget(tipoSub: Tipo, idTab: idTab);
        });
  }

//
//   showEliminar(String tipoDoc, String idPla) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//           title: Text("Atención"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text("¿Eliminar Item?"),
//               SizedBox(
//                 height: 10.0,
//               ),
// //                                      Icon(Icons.warning, size: 45.0, color: Colors.yellow,)
//             ],
//           ),
//           actions: <Widget>[
//             FlatButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text("Cancelar"),
//             ),
//             FlatButton(
//               onPressed: () {
//                 eliminarItem(tipoDoc, idPla);
//               },
//               child: Text("Aceptar"),
//             )
//           ],
//         );
//         // );
//       },
//     ).then((val) {
//       //Navigator.pop(context);
//       getData();
//     });
//   }

}
