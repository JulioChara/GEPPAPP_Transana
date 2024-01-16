import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/informes_model.dart';
import 'package:transana_app/src/models/informes_preventivos/vehiculos_model.dart';
import 'package:transana_app/src/pages/informes_preventivos/alertas_page.dart';
import 'package:transana_app/src/services/informes_preventivos_services.dart';
import 'package:transana_app/src/widgets/menu_widget.dart';

class VehiculosPage extends StatefulWidget {
  @override
  State<VehiculosPage> createState() => _VehiculosPageState();
}

// class _VehiculosPageState extends State<VehiculosPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

//
// class VehiculosPage extends StatefulWidget {
//   @override
//   VehiculosPageState createState() => _VehiculosPageState();
// }

//Future<String> sendData_() async {
//  SharedPreferences prefs = await SharedPreferences.getInstance();
// String id = await prefs.getString("idUser");
// print(id);
// return id;
//}

class _VehiculosPageState extends State<VehiculosPage> {
  //String idUser = "";
  // static List<VehiculosModel> inFiltro = new List<VehiculosModel>();
  // static List<VehiculosModel> inFiltroMinimal =
  // new List<VehiculosModel>();

  var informe = new InformePreventivoService();
  //var datailServices = new DetailServices();
  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);
  String usr = "";

  TextEditingController inputFieldDateController = new TextEditingController();

  DateTime selectedDate = DateTime.now();

  String idInformeSeleccionada = "";

  List<VehiculosModel> informeModelList2 = [];
  List<VehiculosModel> informeModelList3 = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<String> getIdRol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("rolId");
  }

  getData() {
    informe.getVehiculos().then((value) {
      informeModelList2 = value;
      informeModelList3.addAll(informeModelList2);
      setState(() {});
    });
  }

  void filtrarPorPlaca(String query) {
    print("xxxx 1");
    List<VehiculosModel> tempSearchList = [];

    if (query.isNotEmpty) {
      tempSearchList.addAll(informeModelList3);
      List<VehiculosModel> tempDataList = [];
      tempSearchList.forEach((element) {
        if (element.vehiPlaca.toLowerCase().contains(query.toLowerCase())) {
          tempDataList.add(element);
        }
      });
      informeModelList2.clear();
      informeModelList2.addAll(tempDataList);
      setState(() {});
    } else {
      print("xxxx 3");
      print(informeModelList3);
      informeModelList2.clear();
      informeModelList2.addAll(informeModelList3);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // prefs.ultimaPagina = HomePage.routeName;.

    return Scaffold(
        appBar: AppBar(
          title: Text("Lista Vehiculos"),
          backgroundColor: Colors.black,
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


            Expanded(
              child: ListView.builder(
                itemCount: informeModelList2.length,
                itemBuilder: (BuildContext context, int i) {

                  return ListTile(
                    // tileColor: miColor,
                    onTap: () {
                      print(informeModelList2[i].vehiEstado);
                    },
                    title: Text(
                      "${informeModelList2[i].vehiPlaca}-${informeModelList2[i].tipoServicioVehiculoFkDesc}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                    subtitle: informeModelList2[i].vehiEstado =="True" ? Text(
                        //  "${informeModelList2[i].correlativo}   |   ${informeModelList2[i].tipoprioridad}  |  ${informeModelList2[i].tipoestado}   |  ${informeModelList2[i].fechacreacion} "),
                        "HABILITADO") : Text(
                      //  "${informeModelList2[i].correlativo}   |   ${informeModelList2[i].tipoprioridad}  |  ${informeModelList2[i].tipoestado}   |  ${informeModelList2[i].fechacreacion} "),
                        "DESABILITADO"),
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
                              List<String> choices = new List();
                              choices.add(anular);
                              choices.add("Ver Detalle");
                              return [
                                PopupMenuItem<String>
                                  (value: informeModelList2[i].vehiId +
                                    "," +
                                    "Alertas",
                                  child: Text("Alertas"),
                                )
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
                  );
                },
              ),
            ),

          ],
        ));
  }


  void choiceAction(String choice) {
    idInformeSeleccionada = choice;
    var arr = choice.split(',');

    if (arr[1] == "Alertas")
    {
      print("Somos Alertas");
      vincularId2(arr[0], arr[1]);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AlertasPage(),
        ),
      );

    }
  }


  vincularId2(String id, String sini) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("IdVehiculo", id);
  }


  Future<Null> _selectDateInit(BuildContext context) async {
    final DateTime picked = await showDatePicker(
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
    final DateTime picked = await showDatePicker(
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
