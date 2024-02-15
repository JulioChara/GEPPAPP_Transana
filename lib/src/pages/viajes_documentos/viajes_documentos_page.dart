

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/viajes_documentos/viajes_documentos_model.dart';
import 'package:transana_app/src/services/viaje_services.dart';
import 'package:transana_app/src/widgets/Viajes/viajes_documentos_crear_widget.dart';
import 'package:transana_app/src/widgets/menu_widget.dart';

class ViajesDocumentos extends StatefulWidget {

  @override
  State<ViajesDocumentos> createState() => _ViajesDocumentosState();
}

class _ViajesDocumentosState extends State<ViajesDocumentos> {







  var _viajeServices = new ViajeService();
  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);
  String usr = "";

  TextEditingController inputFieldDateController = new TextEditingController();

//  DateTime selectedDate = DateTime.now();

  String idInformeSeleccionada = "";

  List<ViajeDocumentosModel> informeModelList2 = [];
  List<ViajeDocumentosModel> informeModelList3 = [];

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
    _viajeServices.getViajeDocumentosList(initDate, endDate).then((value) {
      informeModelList2 = value;
      informeModelList3.addAll(informeModelList2);
      setState(() {});
    });
  }
  //
  // void filtrarPorPlaca(String query) {
  //   print("xxxx 1");
  //   List<VehiculosModel> tempSearchList = [];
  //
  //   if (query.isNotEmpty) {
  //     tempSearchList.addAll(informeModelList3);
  //     List<VehiculosModel> tempDataList = [];
  //     tempSearchList.forEach((element) {
  //       if (element.vehiPlaca.toLowerCase().contains(query.toLowerCase())) {
  //         tempDataList.add(element);
  //       }
  //     });
  //     informeModelList2.clear();
  //     informeModelList2.addAll(tempDataList);
  //     setState(() {});
  //   } else {
  //     print("xxxx 3");
  //     print(informeModelList3);
  //     informeModelList2.clear();
  //     informeModelList2.addAll(informeModelList3);
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // prefs.ultimaPagina = HomePage.routeName;.

    return Scaffold(
        appBar: AppBar(
          title: Text("Lista Documentos"),
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              color: Colors.white,
              iconSize: 30.0,
              onPressed: () {
               // Navigator.pushNamed(context, 'viajesCreate');


                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {

                      //ALIMENTOS
                      return ViajesCrearDocumentoWidget();
                  },
                ).then((val) {
                  //Navigator.pop(context);
                  getData();
                  setState(() {});
                });


              },
            )
          ],
        ),

       // drawer: MenuWidget(),
        body: Column(
          children: <Widget>[
            TextField(
              onChanged: (String value) {
              //  filtrarPorPlaca(value);  PUEDE SERVIR PARA LUEGO
              },
              decoration: const InputDecoration(
                labelText: 'Filtrar Documentos',
                suffixIcon: Icon(
                  Icons.search,
                ),
              ),
            ),


            Expanded(
              child: ListView.builder(
                itemCount: informeModelList2.length,
                itemBuilder: (BuildContext context, int i) {

                  return ListTile(
                    // tileColor: miColor,
                    onTap: () {
                      print(informeModelList2[i].idDoc);
                    },
                    // title: Text(
                    //   "${informeModelList2[i].serie}-${informeModelList2[i].numero}",
                    //   overflow: TextOverflow.ellipsis,
                    //   maxLines: 1,
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.bold, color: Colors.black54),
                    // ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${informeModelList2[i].serie} - ${informeModelList2[i].numero}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        Text(
                          "${double.parse(informeModelList2[i].monto!).toStringAsFixed(2)}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    subtitle: Text("${informeModelList2[i].razonSocial}"),
                    leading: Icon(
                      Icons.content_paste,
                      color: Colors.redAccent,
                    ),
                    // trailing: FutureBuilder(
                    //   future: getIdRol(),
                    //   builder: (BuildContext context, AsyncSnapshot snap) {
                    //     if (snap.hasData) {
                    //       String idRol = snap.data;
                    //       return PopupMenuButton<String>(
                    //         icon: Icon(
                    //           Icons.more_vert,
                    //           color: Colors.redAccent,
                    //         ),
                    //         itemBuilder: (BuildContext context) {
                    //           String anular = "Anular";
                    //           List<String> choices = new List();
                    //           choices.add(anular);
                    //           choices.add("Ver Detalle");
                    //           return [
                    //             PopupMenuItem<String>
                    //               (value: informeModelList2[i].idDoc +
                    //                 "," +
                    //                 "Alertas",
                    //               child: Text("Alertas"),
                    //             )
                    //           ];
                    //         },
                    //         onSelected: choiceAction,
                    //       );
                    //     }
                    //
                    //     return SizedBox(
                    //       width: 1,
                    //       height: 1,
                    //     );
                    //   },
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

  //
  // void choiceAction(String choice) {
  //   idInformeSeleccionada = choice;
  //   var arr = choice.split(',');
  //
  //   if (arr[1] == "Alertas")
  //   {
  //     print("Somos Alertas");
  //     vincularId2(arr[0], arr[1]);
  //   }
  // }

  //
  // vincularId2(String id, String sini) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString("IdVehiculo", id);
  // }


  Future<Null> _selectDateInit(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: DateTime.parse(initDate),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        initDate = picked.toString().substring(0, 10);
        getData();
      });
  }

  Future<Null> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: DateTime.parse(endDate),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        endDate = picked.toString().substring(0, 10);
        getData();
      });
  }













}



