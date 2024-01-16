




import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transana_app/src/services/parametros_services.dart';
import 'package:transana_app/src/widgets/Parametros/parametros_widget.dart';
import 'package:transana_app/src/widgets/menu_widget.dart';



class ParametrosPage extends StatefulWidget {


  @override
  State<ParametrosPage> createState() => _ParametrosPageState();
}

class _ParametrosPageState extends State<ParametrosPage> {

  var _parametrosServices = new ParametrosServices();

  List<TiposModel> informeModelList2 = [];
  List<TiposModel> informeModelList3 = [];

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
    _parametrosServices.getTiposEditableList().then((value) {
      informeModelList2 = value;
      informeModelList3.addAll(informeModelList2);
      setState(() {});
    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Parametros Editables"),
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
                    return ParametrosWidget();
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

        drawer: MenuWidget(),
        body: Column(
          children: <Widget>[
            TextField(
              onChanged: (String value) {
                //  filtrarPorPlaca(value);  PUEDE SERVIR PARA LUEGO
              },
              decoration: const InputDecoration(
                labelText: 'Filtrar tipos',
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
                      print(informeModelList2[i].tipoId);
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${informeModelList2[i].tipoDescripcion}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        // Text(
                        //   "Editable : SI",
                        //   overflow: TextOverflow.ellipsis,
                        //   maxLines: 1,
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.black54),
                        // ),
                      ],
                    ),
                    subtitle: Text("EDITABLE : SI"),
                    leading: Icon(
                      Icons.content_paste,
                      color: Colors.redAccent,
                    ),
                  );
                },
              ),
            ),


          ],
        ));
  }






}
