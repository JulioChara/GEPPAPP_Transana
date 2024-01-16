import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/consumosListado_model.dart';
import 'package:transana_app/src/services/consumos_services.dart';
import 'package:transana_app/src/widgets/menu_widget.dart';
import 'package:transana_app/src/services/informe_services.dart';
import 'package:transana_app/src/services/detail_services.dart';

class ConsumoPage extends StatefulWidget {
  @override
  _ConsumoPageState createState() => _ConsumoPageState();
}

class _ConsumoPageState extends State<ConsumoPage> {

  //String idUser = "";
  var consumo = new ConsumoService();
  String usr="";
  String idconsumoSeleccionada = "";

  @override
  void initState(){
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // prefs.ultimaPagina = HomePage.routeName;.
    final bar = SnackBar(content: Text('Hello, world!'));
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista Documentos Vinculados"),
          backgroundColor: Colors.red,
        ),
        //drawer: MenuWidget(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: _listConsumo(context, consumo),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Container(
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                  ),
                ),
              ],
            )
          ],
        ));
  }



  Widget _listConsumo(BuildContext context, ConsumoService consumoService) {
    //print(usr);

    return FutureBuilder(

      future: consumoService.cargarConsumos(),
      builder: (BuildContext context, AsyncSnapshot<List<consumoModel>> snapshot) {
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
                final consumoModel = snapshot.data;
                return consumoModel.length > 0
                    ? ListView.builder(
                  itemCount: consumoModel.length,
                  itemBuilder: (context, i) {
                    return (ListTile(
                      title: Text(
                        "${consumoModel[i].documento}-${consumoModel[i].proveedor}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      subtitle: Text(
                          "${consumoModel[i].fecha}   |   ${consumoModel[i].galones} gal.  |  s/. ${consumoModel[i].total}  "),
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

                              //if (guiaModel[i].estadoSunat ==
                              //   "Rechazado Sunat") {
                              // choices.add(enviar);
                              // choices.add(anular);
                              // } else {
                              //  choices.add(anular);
                              // }
                              choices.add(anular);

                              return choices.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: consumoModel[i].idCompra + ","+choice,
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
    idconsumoSeleccionada = choice;
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
                  Text(
                      "Anular Consumo"),
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
                    _anularConsumo(arr[0]);
                    Navigator.pop(context);
                  },
                  child: Text("Aceptar"),
                )
              ],
            );
          });
    }

  }

  _anularConsumo(String id) async{

    ConsumoService service = new ConsumoService();

    String res = await service.estadoAnularConsumo(id);

    if(res == "1"){

      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text("Consumo Anulado Correctamente"),
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


}
