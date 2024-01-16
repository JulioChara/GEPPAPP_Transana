import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/informes_model.dart';
import 'package:transana_app/src/widgets/menu_widget.dart';
import 'package:transana_app/src/services/informe_services.dart';
import 'package:transana_app/src/services/detail_services.dart';

class InformePage extends StatefulWidget {


  @override
  _InformePageState createState() => _InformePageState();
}

//Future<String> sendData_() async {
//  SharedPreferences prefs = await SharedPreferences.getInstance();
// String id = await prefs.getString("idUser");
// print(id);
// return id;
//}


class _InformePageState extends State<InformePage> {

  //String idUser = "";



  var informe = new InformeService();
  var datailServices = new DetailServices();
  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);
  String usr="";

  TextEditingController inputFieldDateController = new TextEditingController();

  DateTime selectedDate = DateTime.now();

  String idInformeSeleccionada = "";

  @override
  void initState(){
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // prefs.ultimaPagina = HomePage.routeName;.

    return Scaffold(
        appBar: AppBar(
          title: Text("Lista Informes Unidades"),
          backgroundColor: Colors.red,
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
            Expanded(
              child: _listInforme(context, informe),
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
      builder: (BuildContext context, AsyncSnapshot<List<InformelistaModel>> snapshot) {
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
                return informeModel.length > 0
                    ? ListView.builder(
                  itemCount: informeModel.length,
                  itemBuilder: (context, i) {
                    return (ListTile(
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
                      trailing: Container(
                        child: PopupMenuButton<String>(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.redAccent,
                            ),
                            itemBuilder: (BuildContext context) {
                              //String enviar = "Enviar SUNAT";

                              String anular = "Anular";

                              List<String> choices = new List();

                              if (informeModel[i].tipoestado =="ANULADO") {
                               } else {
                                choices.add(anular);
                               }


                              return choices.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: informeModel[i].InunId + ","+choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                            onSelected: choiceAction),
                      ),
                    ));
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

    //print(arr[0]);
    //print(arr[1]);

    if(arr[1] == "Anular"){
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)),
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
    }

  }

  _anularInforme(String id) async{

    InformeService service = new InformeService();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String  idUser =  prefs.getString('idUser') ;

    String res = await service.estadoAnularInforme(id,idUser);

    if(res == "1"){

      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text("Informe Anulado Correctamente"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    setState(() {

                    });
                    Navigator.pop(context);
                  },
                  child: Text("Aceptar"),
                )
              ],
            );
          }
      );

    }else{
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)),
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
          }
      );
    }


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
        _listInforme(context, informe);
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
        _listInforme(context, informe);
      });
  }
}
