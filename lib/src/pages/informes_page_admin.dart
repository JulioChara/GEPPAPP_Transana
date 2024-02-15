import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/informes_model.dart';
import 'package:transana_app/src/pages/informes_detalle_page.dart';
import 'package:transana_app/src/widgets/menu_widget.dart';
import 'package:transana_app/src/services/informe_services.dart';
import 'package:transana_app/src/services/detail_services.dart';

class InformeAdmPage extends StatefulWidget {
  @override
  _InformeAdmPageState createState() => _InformeAdmPageState();
}

//Future<String> sendData_() async {
//  SharedPreferences prefs = await SharedPreferences.getInstance();
// String id = await prefs.getString("idUser");
// print(id);
// return id;
//}

class _InformeAdmPageState extends State<InformeAdmPage> {
  //String idUser = "";
  static List<InformelistaModel> inFiltro = [];
  static List<InformelistaModel> inFiltroMinimal =[];

  var informe = new InformeService();
  var datailServices = new DetailServices();
  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);
  String usr = "";

  TextEditingController inputFieldDateController = new TextEditingController();

  DateTime selectedDate = DateTime.now();

  String idInformeSeleccionada = "";

  List<InformelistaModel> informeModelList2 = [];
  List<InformelistaModel> informeModelList3 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<String> getIdRol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("rolId")!;
  }

  getData() {
    informe.cargarInforme(initDate, endDate).then((value) {
      informeModelList2 = value;
      informeModelList3.addAll(informeModelList2);
      setState(() {});
    });
  }

  void filtrarPorPlaca(String query) {

    print("xxxx 1");
    List<InformelistaModel> tempSearchList = [];

    if(query.isNotEmpty){
      tempSearchList.addAll(informeModelList3);
      List<InformelistaModel> tempDataList = [];
      tempSearchList.forEach((element) {
        if(element.vehiculo!.toLowerCase().contains(query.toLowerCase())){
          tempDataList.add(element);
        }
      });
      informeModelList2.clear();
      informeModelList2.addAll(tempDataList);
      setState(() {

      });
    }else{
      print("xxxx 3");
      print(informeModelList3);
      informeModelList2.clear();
      informeModelList2.addAll(informeModelList3);
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // prefs.ultimaPagina = HomePage.routeName;.

    return Scaffold(
        appBar: AppBar(
          title: Text("Lista Informes Unidades"),
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              color: Colors.white,
              iconSize: 30.0,
              onPressed: () {
                Navigator.pushNamed(context, 'informeCreate');
              },
            )
          ],
        ),
        drawer: MenuWidget(),
        body: Column(
          children: <Widget>[
            TextField(
              onChanged: (String value) {
                filtrarPorPlaca(value);
              },
              decoration: const InputDecoration(
                labelText: 'Filtrar por Placa',
                suffixIcon: Icon(
                  Icons.search,
                ),
              ),
            ),

            //Expanded(
            //child: _listInforme(context, informe),
            //),
            Expanded(
              child: ListView.builder(
                itemCount: informeModelList2.length,
                itemBuilder: (BuildContext context, int i) {
                  Color miColor = Colors.blue;
                  switch(informeModelList2[i].tipoestado) {
                    case "INFORMADA": {
                      miColor = Colors.blue.withOpacity(0.4);
                    } break;
                    case "EN PROCESO": {
                      miColor = Colors.yellow.withOpacity(0.4);
                    } break;
                    case "SOLUCIONADO": {
                      miColor = Colors.green.withOpacity(0.4);
                    } break;
                    default: {
                      miColor = Colors.red.withOpacity(0.4);
                    } break;
                  }
                  return ListTile(
                    tileColor: miColor,
                    onTap: () {
                      print(informeModelList2[i].tipoestado);
                    },
                    title: Text(
                      "${informeModelList2[i].vehiculo}-${informeModelList2[i].conductor}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                    subtitle: Text(
                        "${informeModelList2[i].correlativo}   |   ${informeModelList2[i].tipoprioridad}  |  ${informeModelList2[i].tipoestado}   |  ${informeModelList2[i].fechacreacion} "),
                    leading: Icon(
                      Icons.content_paste,
                      color: Colors.redAccent,
                    ),
                    trailing: FutureBuilder(
                      future: getIdRol(),
                      builder: (BuildContext context, AsyncSnapshot snap) {
                        if (snap.hasData) {
                          String idRol = snap.data;
                          return PopupMenuButton<String>(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.redAccent,
                            ),
                            itemBuilder: (BuildContext context) {
                              String anular = "Anular";
                              List<String> choices = [];
                              choices.add(anular);
                              choices.add("Ver Detalle");
                              return [
                                if (informeModelList2[i].tipoestado == "INFORMADA") PopupMenuItem<String>(
                                        value: informeModelList2[i].InunId! +
                                            "," +
                                            "Anular" +
                                            "," +
                                            informeModelList2[i].vehiculo! +
                                            "," +
                                            informeModelList2[i].conductor!,
                                        child: Text("Anular "),
                                      ),
                                if (idRol == "1" || idRol == "13") PopupMenuItem<String>(
                                        value: informeModelList2[i].InunId! +
                                            "," +
                                            "VerDetalle" +
                                            "," +
                                            informeModelList2[i].vehiculo! +
                                            "," +
                                            informeModelList2[i].conductor!,
                                        child: Text("Ver Detalle"),
                                      ),
                              ];
                            },
                            onSelected: choiceAction,
                          );
                        }

                        return SizedBox(
                          width: 1,
                          height: 1,
                        );
                      },
                    ),
                    //CONTAINER
                    // trailing: Container(
                    //   child: PopupMenuButton<String>(aq
                    //     icon: Icon(
                    //       Icons.more_vert,
                    //       color: Colors.redAccent,
                    //     ),
                    //     // onSelected: (String result) { setState(() { _selection = result; }); },
                    //     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    //       const PopupMenuItem<String>(
                    //         // value: String.harder,
                    //         child: Text('ANULAR'),
                    //       ),
                    //       const PopupMenuItem<String>(
                    //         // value: String.smarter,
                    //         child: Text('VER DETALLE'),
                    //       ),
                    //     ],
                    //   )
                    // ),
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0XFF51E2A7),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade400, blurRadius: 3)
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
                            initDate,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                      onPressed: () {
                        _selectDateInit(context);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade400, blurRadius: 3)
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
                            endDate,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                      onPressed: () {
                        _selectDateEnd(context);
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Widget _listInforme(BuildContext context, InformeService informeService) {
    //print(usr);

    return FutureBuilder(
      future: informeService.cargarInforme(initDate, endDate),
      builder: (BuildContext context,
          AsyncSnapshot<List<InformelistaModel>> snapshot) {
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
                final informeModel = snapshot.data;
                return informeModel!.length > 0
                    ? ListView.builder(
                        itemCount: informeModel.length,
                        itemBuilder: (context, i) {
                          Color miColor = Colors.blue;
                          switch (informeModel[i].tipoestado) {
                            case "INFORMADA":
                              {
                                miColor = Colors.blue.withOpacity(0.5);
                              }
                              break;

                            case "EN PROCESO":
                              {
                                miColor = Colors.yellow.withOpacity(0.5);
                              }
                              break;

                            case "SOLUCIONADO":
                              {
                                miColor = Colors.green.withOpacity(0.5);
                              }
                              break;

                            default:
                              {
                                miColor = Colors.red.withOpacity(0.5);
                              }
                              break;
                          }

                          // if(informeModel[i].tipoestado== "INFORMADA"){
                          //
                          // }else

                          print(informeModel[i]);
                          print("cat" + informeModel[i].tipoestado!);
                          return ListTile(
                            tileColor: miColor,
                            //  hoverColor: Colors.green,
                            onTap: () {
                              print(informeModel[i].tipoestado);
                            },
                            title: Text(
                              "${informeModel[i].vehiculo}-${informeModel[i].conductor}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            subtitle: Text(
                                "${informeModel[i].correlativo}   |   ${informeModel[i].tipoprioridad}  |  ${informeModel[i].tipoestado}   |  ${informeModel[i].fechacreacion} "),
                            leading: Icon(
                              Icons.content_paste,
                              color: Colors.redAccent,
                            ),
                            trailing: FutureBuilder(
                              future: getIdRol(),
                              builder:
                                  (BuildContext context, AsyncSnapshot snap) {
                                if (snap.hasData) {
                                  String idRol = snap.data;
                                  return PopupMenuButton<String>(
                                    icon: Icon(
                                      Icons.more_vert,
                                      color: Colors.redAccent,
                                    ),
                                    itemBuilder: (BuildContext context) {
                                      String anular = "Anular";
                                      List<String> choices = [];
                                      choices.add(anular);
                                      choices.add("Ver Detalle");
                                      return [
                                        if (informeModel[i].tipoestado ==
                                                "INFORMADA") PopupMenuItem<String>(
                                                value: informeModel[i].InunId! +
                                                    "," +
                                                    "Anular" +
                                                    "," +
                                                    informeModel[i].vehiculo! +
                                                    "," +
                                                    informeModel[i].conductor!,
                                                child: Text("Anular "),
                                              ),
                                        if (idRol == "1" || idRol == "13") PopupMenuItem<String>(
                                                value: informeModel[i].InunId! +
                                                    "," +
                                                    "VerDetalle" +
                                                    "," +
                                                    informeModel[i].vehiculo! +
                                                    "," +
                                                    informeModel[i].conductor!,
                                                child: Text("Ver Detalle"),
                                              ),
                                      ];
                                    },
                                    onSelected: choiceAction,
                                  );
                                }

                                return SizedBox(
                                  width: 1,
                                  height: 1,
                                );
                              },
                            ),
                            //CONTAINER
                            // trailing: Container(
                            //   child: PopupMenuButton<String>(aq
                            //     icon: Icon(
                            //       Icons.more_vert,
                            //       color: Colors.redAccent,
                            //     ),
                            //     // onSelected: (String result) { setState(() { _selection = result; }); },
                            //     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                            //       const PopupMenuItem<String>(
                            //         // value: String.harder,
                            //         child: Text('ANULAR'),
                            //       ),
                            //       const PopupMenuItem<String>(
                            //         // value: String.smarter,
                            //         child: Text('VER DETALLE'),
                            //       ),
                            //     ],
                            //   )
                            // ),
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

  void choiceAction(String choice) {
    idInformeSeleccionada = choice;
    var arr = choice.split(',');

    if (arr[1] == "Anular") {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Anular Informe"),
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
                    _anularInforme(arr[0]);
                    Navigator.pop(context);
                  },
                  child: Text("Aceptar"),
                )
              ],
            );
          });
    } else if (arr[1] == "VerDetalle") {
      //
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InformeDetallePage(
            id: arr[0],
            placa: arr[2],
            conductor: arr[3],
          ),
        ),
      ).then((value) {
        setState(() {});
      });
    }
  }

  _anularInforme(String id) async {
    InformeService service = new InformeService();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String idUser = prefs.getString('idUser')!;

    String res = await service.estadoAnularInforme(id, idUser);

    if (res == "1") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text("Informe Anulado Correctamente"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text("Aceptar"),
                )
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text("Hubo un problema, inténtelo nuevamente."),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Aceptar"),
                )
              ],
            );
          });
    }
  }

  Future<Null> _selectDateInit(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: new DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        initDate = picked.toString().substring(0, 10);
        //_listInforme(context, informe);
        getData();
      });
  }

  Future<Null> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: new DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        endDate = picked.toString().substring(0, 10);
        //_listInforme(context, informe);
        getData();
      });
  }

}
