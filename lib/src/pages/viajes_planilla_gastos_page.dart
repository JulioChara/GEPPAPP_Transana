import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/planilla_gastos_model.dart';
import 'package:transana_app/src/services/planilla_gastos_services.dart';
import 'package:transana_app/src/widgets/Planillas/planilla_alimentos_widget.dart';
import 'package:transana_app/src/widgets/Planillas/planilla_compras_widget.dart';
import 'package:transana_app/src/widgets/Planillas/planilla_estacionamiento_widget.dart';
import 'package:transana_app/src/widgets/Planillas/planilla_hospedaje_widget.dart';
import 'package:transana_app/src/widgets/Planillas/planilla_movilidad_widget.dart';
import 'package:transana_app/src/widgets/Planillas/planilla_pasajes_widget.dart';
import 'package:transana_app/src/widgets/Planillas/planilla_peajes_widget.dart';
import 'package:transana_app/src/widgets/Planillas/planilla_servicios_widget.dart';
import 'package:transana_app/src/widgets/Planillas/planilla_show_widget.dart';
import 'package:transana_app/src/widgets/planilla_documentos_widget.dart';

class PlanillaGastosPage extends StatefulWidget {
  String? saldoInicial;

  PlanillaGastosPage({
    this.saldoInicial,
  });

  @override
  State<PlanillaGastosPage> createState() => _PlanillaGastosPageState();
}

class _PlanillaGastosPageState extends State<PlanillaGastosPage> {
  var planilla = new PlanillaGastosServices();
  bool isLoading = true;
  String idViaje = "";
  String sInicial = "";
  double saldoFinal = 0;
  double totalGastos = 0;
  List<PlanillaGastosModel> plantillaGastosList = [];

  PlanillaGastosEliminarModel _deletePeajesModel =
      PlanillaGastosEliminarModel();
  PlanillaGastosServices _deletePeajesServices = PlanillaGastosServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString("idUser")!;
    String idVijae = await prefs.getString("IdVijae")!;
    String sInicial = await prefs.getString("sInicial")!;
    idViaje = idVijae;
    sInicial = sInicial;
    plantillaGastosList = await planilla.getPlanillaGastosDetalles(idViaje);
    //saldoFinal = 0;
    totalGastos = 0;
    saldoFinal = double.parse(widget.saldoInicial!);
    plantillaGastosList.forEach((element) {
      saldoFinal = saldoFinal - double.parse(element.monto!);
      totalGastos = totalGastos + double.parse(element.monto!);
    });

    isLoading = false;
    setState(() {});
  }

  showFormulario() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PlanillaDocumentosWidget(
            //PARAMETROS
            idViajeW: idViaje);
      },
    );
  }

  void eliminarItem(String tipoDoc, String idPlanilla) {
    // loading = true;

    _deletePeajesModel.idTipoDocGasto = tipoDoc;
    _deletePeajesModel.idPlanilla = idPlanilla;

    _deletePeajesServices.eliminarPlanillaDetalles(_deletePeajesModel).then(
      (value) {
        if (value != null) {
          if (value == "1") {
            getData();
            Navigator.pop(context);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Planilla de Gastos",
          maxLines: 2,
        ),
        backgroundColor: Colors.purple,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (choice) => choiceAction(choice, context),
            icon: Icon(Icons.add),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Alimentacion"),
                value: 10793,
              ),
              PopupMenuItem(
                child: Text("Estacionamiento"),
                value: 10800,
              ),
              PopupMenuItem(
                child: Text("Peajes"),
                value: 10794,
              ),
              PopupMenuItem(
                child: Text("Movilidad"),
                value: 10795,
              ),
              PopupMenuItem(
                child: Text("Hospedaje"),
                value: 10796,
              ),
              PopupMenuItem(
                child: Text("Pasajes"),
                value: 10797,
              ),
              PopupMenuItem(
                child: Text("Compras"),
                value: 10798,
              ),
              PopupMenuItem(
                child: Text("Servicios"),
                value: 10799,
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
                    itemCount: plantillaGastosList.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        onTap: () {
                          showDetalles(
                              plantillaGastosList[i].idTipoDocumento!,
                              plantillaGastosList[i].plaId!);
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${plantillaGastosList[i].idTipoDocumentoDesc}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(
                              "${double.parse(plantillaGastosList[i].monto!).toStringAsFixed(2)}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        subtitle: Text(plantillaGastosList[i].concepto!),
                        leading: Icon(
                          Icons.content_paste,
                          color: Colors.redAccent,
                        ),
                        trailing: Wrap(
                          spacing: 12, // space between two icons
                          children: <Widget>[
                            // IconButton(
                            //     icon: Icon(Icons.edit),
                            //     onPressed: (){
                            //       print("ICONO EDITAR: " + planillaModel[i].plaId);
                            //     },
                            // ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                print("ICONO ELIMINAR: " +
                                    plantillaGastosList[i].plaId!);
                                print("TIPO DOC A AELIMINAR" +
                                    plantillaGastosList[i].idTipoDocumento!);
                                return showEliminar(
                                    plantillaGastosList[i].idTipoDocumento!,
                                    plantillaGastosList[i].plaId!);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 56.0,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        12,
                      ),
                      topRight: Radius.circular(
                        12,
                      ),
                    ),
                  ),
                  //child: Text("Saldo inicial: S./ ${widget.saldoInicial}",
                  child: Text(
                    "Saldo inicial: S./ ${double.parse(widget.saldoInicial!).toStringAsFixed(2)}",
                    style: TextStyle(height: 1, fontSize: 20),
                  ),
                ),

                // New
                Container(
                  height: 56.0,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade300,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        12,
                      ),
                      topRight: Radius.circular(
                        12,
                      ),
                    ),
                  ),
                  //child: Text("Saldo inicial: S./ ${widget.saldoInicial}",
                  child: Text(
                    "Total Gastos: S./ ${double.parse(totalGastos.toString()).toStringAsFixed(2)}",
                    style: TextStyle(height: 1, fontSize: 20),
                  ),
                ),
                // END NEW

                Container(
                  height: 56.0,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: saldoFinal >= 0
                      ? BoxDecoration(
                    color: Colors.lightGreenAccent,
                  )
                      : BoxDecoration(
                    color: Colors.redAccent,
                  ),
                  child: saldoFinal >= 0
                      ? Text(
                    "Saldo a Devolver: S./ ${saldoFinal.toStringAsFixed(2)}",
                    style: TextStyle(height: 1, fontSize: 20),
                  )
                      : Text(
                    "Saldo a Reembolsar: S./ ${(saldoFinal.toDouble() *-1).toStringAsFixed(2)}",
                    style: TextStyle(height: 1, fontSize: 20),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _listPlanilla(
      BuildContext context, PlanillaGastosServices PlanillaGastosServices) {
    //print(usr);

    return FutureBuilder(
      future: PlanillaGastosServices.getPlanillaGastosDetalles(idViaje),
      builder: (BuildContext context,
          AsyncSnapshot<List<PlanillaGastosModel>> snapshot) {
        print(snapshot.connectionState);
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            {
              return new Center(
                child: CircularProgressIndicator(),
              );
            }
          case ConnectionState.active:
            {
              break;
            }
          case ConnectionState.none:
            {
              break;
            }
          case ConnectionState.done:
            {
              if (snapshot.hasData) {
                List<PlanillaGastosModel> planillaModel = snapshot.data!;
                return planillaModel.length > 0
                    ? ListView.builder(
                        itemCount: planillaModel.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            onTap: () {
                              //  print(informeModel[i].tipoestado);
                            },
                            title: Text(
                              "${planillaModel[i].idTipoDocumentoDesc}-${planillaModel[i].monto}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            subtitle: Text(planillaModel[i].concepto!),
                            //   "${informeModel[i].correlativo}   |   ${informeModel[i].tipoprioridad}  |  ${informeModel[i].tipoestado}   |  ${informeModel[i].fechacreacion} "),
                            leading: Icon(
                              Icons.content_paste,
                              color: Colors.redAccent,
                            ),
                            trailing: Wrap(
                              spacing: 12, // space between two icons
                              children: <Widget>[
                                // IconButton(
                                //     icon: Icon(Icons.edit),
                                //     onPressed: (){
                                //       print("ICONO EDITAR: " + planillaModel[i].plaId);
                                //     },
                                // ),
                                IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      print("ICONO ELIMINAR: " +
                                          planillaModel[i].plaId!);
                                      print("TIPO DOC A AELIMINAR" +
                                          planillaModel[i].idTipoDocumento!);
                                      return showEliminar(
                                          planillaModel[i].idTipoDocumento!,
                                          planillaModel[i].plaId!);
                                    }),
                              ],
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text(
                          "No hay información disponible.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black26),
                        ),
                      );
              }
            }
        }

        return new Center(child: CircularProgressIndicator());
      },
    );
  }

  void choiceAction(dynamic choice, BuildContext context) {
    print(choice);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if (choice == 10793) {
          //ALIMENTOS
          return PlanillaAlimentosWidget(
              idViajeW: idViaje, tipoDocGasto: choice.toString());
        } else if (choice == 10800) {
          //ESTACIONAMIENTO
          return PlanillaEstacionamientoWidget(
              idViajeW: idViaje, tipoDocGasto: choice.toString());
        } else if (choice == 10794) {
          //PEAJES
          return PlanillaPeajesWidget(
              idViajeW: idViaje, tipoDocGasto: choice.toString());
        } else if (choice == 10795) {
          //MOVILIDAD
          return PlanillaMovilidadWidget(
              idViajeW: idViaje, tipoDocGasto: choice.toString());
        } else if (choice == 10796) {
          //HOSPEDAJE
          return PlanillaHospedajeWidget(
              idViajeW: idViaje, tipoDocGasto: choice.toString());
        } else if (choice == 10797) {
          //PASAJES
          return PlanillaPasajesWidget(
              idViajeW: idViaje, tipoDocGasto: choice.toString());
        } else if (choice == 10798) {
          //COMPRAS
          return PlanillaComprasWidget(
              idViajeW: idViaje, tipoDocGasto: choice.toString());
        } else if (choice == 10799) {
          //SERVICIOS
          return PlanillaServiciosWidget(
              idViajeW: idViaje, tipoDocGasto: choice.toString());
        } else {
          return Container();
        }
      },
    ).then((val) {
      //Navigator.pop(context);
      getData();
      setState(() {});
    });
  }




  showDetalles(String tipoDoc, String idPla) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {

    return PlanillaShowWidget(
      tipoDoc: tipoDoc,
      idPla: idPla,
    );
    });
  }



  showEliminar(String tipoDoc, String idPla) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text("Atención"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("¿Eliminar Item?"),
              SizedBox(
                height: 10.0,
              ),
//                                      Icon(Icons.warning, size: 45.0, color: Colors.yellow,)
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
            FlatButton(
              onPressed: () {
                eliminarItem(tipoDoc, idPla);
              },
              child: Text("Aceptar"),
            )
          ],
        );
        // );
      },
    ).then((val) {
      //Navigator.pop(context);
      getData();
    });
  }
}
