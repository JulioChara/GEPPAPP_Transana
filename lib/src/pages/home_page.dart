import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transana_app/src/models/guia_model.dart';
import 'package:transana_app/src/widgets/menu_widget.dart';
import 'package:transana_app/src/services/guia_services.dart';
import 'package:transana_app/src/services/detail_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  var guia = new GuiaService();
  var datailServices = new DetailServices();
  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);

  TextEditingController inputFieldDateController = new TextEditingController();

  DateTime selectedDate = DateTime.now();

  String idGuiaSeleccionada = "";

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
          title: Text("Lista Guias Transportistas"),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              color: Colors.white,
              iconSize: 30.0,
              onPressed: (){
                Navigator.pushNamed(context, 'general');
              },
            )
          ],
        ),
        drawer: MenuWidget(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: _listGuia(context, guia),
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
                        color: Colors.lightBlueAccent,
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

  Widget _listGuia(BuildContext context, GuiaService guiaService) {
    return FutureBuilder(
      future: guiaService.cargarGuia(initDate, endDate),
      builder: (BuildContext context, AsyncSnapshot<List<GuiaModel>> snapshot) {
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
                final guiaModel = snapshot.data;
                return guiaModel!.length > 0
                    ? ListView.builder(
                        itemCount: guiaModel.length,
                        itemBuilder: (context, i) {
                          return (ListTile(
                            title: Text(
                              guiaModel[i].clientes!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            subtitle: Text(
                                "${guiaModel[i].serie}-${guiaModel[i].numero}    |   ${guiaModel[i].fecha}  |  ${guiaModel[i].estadoSunat} "),
                            leading: Icon(
                              Icons.content_paste,
                              color: Colors.lightBlueAccent,
                            ),
                            trailing: Container(
                              child: PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Colors.lightBlueAccent,
                                  ),
                                  itemBuilder: (BuildContext context) {
                                    String enviar = "Enviar SUNAT";

                                    String anular = "Anular";

                                    List<String> choices = [];

                                    if (guiaModel[i].estadoSunat ==
                                        "Rechazado Sunat") {
                                      choices.add(enviar);
                                      choices.add(anular);
                                    } else if(guiaModel[i].estadoSunat ==
                                        "Valido Sunat") {
                                      choices.add(anular);
                                    }

                                    return choices.map((String choice) {
                                      return PopupMenuItem<String>(
                                        value: guiaModel[i].id! + ","+choice,
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
    idGuiaSeleccionada = choice;
    var arr = choice.split(',');

    print(arr[0]);
    print(arr[1]);

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
                  Text(
                      "Anular Guia de Remisión"),
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
                    _anularGuia(arr[0]);
                    Navigator.pop(context);
                  },
                  child: Text("Aceptar"),
                )
              ],
            );
          });
    }else if(arr[1] == "Enviar SUNAT"){
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
                  Text(
                      "Enviar Guia de Remisión"),
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
                    _enviarGuia(arr[0]);
                    Navigator.pop(context);
                  },
                  child: Text("Aceptar"),
                )
              ],
            );
          });
    }
  }

  _anularGuia(String id) async{

    GuiaService service = new GuiaService();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String  idUser =  prefs.getString('idUser')! ;
   // String  rolId =  prefs.getString('rolId') ;


    String res = await service.estadoAnularGuia(id,idUser);

    if(res == "1"){

      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text("Guia Anulada Correctamente"),
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


  _enviarGuia(String id) async{

    GuiaService service = new GuiaService();

    String res = await service.estadoEnviarSunat(id);

    if(res == "1"){

      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text("Guia Enviada Correctamente"),
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
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: new DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        initDate = picked.toString().substring(0, 10);
        _listGuia(context, guia);
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
        _listGuia(context, guia);
      });
  }
}
