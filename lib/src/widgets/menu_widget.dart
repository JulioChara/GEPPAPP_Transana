import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/pages/informes_home_page.dart';
import 'package:transana_app/src/widgets/mensaje_widget.dart';

class MenuWidget extends StatefulWidget {

  String rolcito = "";
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  String nameUser = "";
  _cerrarSesion(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.pushReplacementNamed(context, 'login');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIdRol();
    _valorInicial();
  }

  _valorInicial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nameUser = await prefs.getString("nameUser")!;
    print(nameUser);
  }


  Future<String> getIdRol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.rolcito = prefs.getString('rolId')!;
    print(prefs.getString('rolId'));
    return prefs.getString("rolId")!;
  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: NetworkImage(
                        "https://c4.wallpaperflare.com/wallpaper/200/112/950/material-design-design-wallpaper-preview.jpg"),
                    fit: BoxFit.cover)),
          ),
          ExpansionTile(
            title: Text("LOGISTICA"),
            initiallyExpanded: true,
            children: [
              ListTile(
                leading: Icon(
                  Icons.devices_other,
                  color: Colors.blueAccent,
                ),
                title: Text("Guias Transportistas"),
                onTap: () => Navigator.pushReplacementNamed(context, 'home'),
                // Navigator.pushReplacementNamed(context, 'home', arguments: _email);
              ),
              ListTile(
                leading: Icon(
                  Icons.directions_car,
                  color: Colors.blueAccent,
                ),
                title: Text("Viajes"),
                onTap: () => Navigator.pushReplacementNamed(context, 'viajes'),
              ),
              ListTile(
                leading: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                title: Text("Informe Unidad"),
                onTap: () =>
                // Navigator.pushReplacementNamed(context, 'informe'),
                //Navigator.pushReplacementNamed(context, 'informeAdm'),
                //  Navigator.pushReplacementNamed(context, 'InformesHomePage'),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InformesHomePage())),
                //Navigator.pushReplacementNamed(context, 'test'),
              ),
//PARA PRUEBAS DE DESARROLLO


              // ListTile(
              //   leading: Icon(
              //     Icons.insert_chart,
              //     color: Colors.blueAccent,
              //   ),
              //   title: Text("Reportes"),
              //   onTap: () =>
              //   // Navigator.pushReplacementNamed(context, 'informe'),
              //   //Navigator.pushReplacementNamed(context, 'informeAdm'),
              //   Navigator.pushReplacementNamed(context, 'reportes'),
              // ),

              //END PRUEBAS DE DESARROLLO

            ],
          ),
          ExpansionTile(
            title: Text("GENERAL"),
            initiallyExpanded: true,
            children: [
              ListTile(
                leading: Icon(
                  Icons.devices_other,
                  color: Colors.blueAccent,
                ),
                title: Text("Parametros"),
                onTap: (){
                  if(widget.rolcito =="1" || widget.rolcito =="8" || widget.rolcito =="13") {
                    Navigator.pushReplacementNamed(context, 'parametros');
                  }
                  else
                  {
                    MensajeWidget(mensaje: "Menu de uso administrativo",pop: 1,);
                  }
                },

                //  onTap: () => Navigator.pushReplacementNamed(context, 'parametros'),
                // Navigator.pushReplacementNamed(context, 'home', arguments: _email);
              ),
            ],
          ),

          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.blueAccent,
            ),
            title: Text("Cerrar Sesión"),
            onTap: () {
              //Navigator.pushReplacementNamed(context, SettingsPage.routeName);
              _cerrarSesion(context);
            },
          ),

        ],
      ),
    );
  }
}
