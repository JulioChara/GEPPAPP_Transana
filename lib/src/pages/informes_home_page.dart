import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/pages/informes_page_admin.dart';
import 'package:transana_app/src/pages/informes_preventivos/vehiculos_page.dart';
import 'package:transana_app/src/widgets/menu_widget.dart';

class InformesHomePage extends StatefulWidget {
  String rolcito = "";
  @override
  _InformesHomePageState createState() => _InformesHomePageState();
}

class _InformesHomePageState extends State<InformesHomePage> {


  Future<String> getIdRol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.rolcito = prefs.getString('rolId');
    print(prefs.getString('rolId'));
    return prefs.getString("rolId");
  }
  // void test(){
  //   SharedPreferences prefs =  SharedPreferences.getInstance();
  //   widget.rolcito = prefs.getString("rolId");
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIdRol();
    print("aaaa");
    print(widget.rolcito);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: MenuWidget(),
      appBar: AppBar(
        title: Text("INFORMES"),
      ),
      // body: ListView(
      //   children: [
      //     ListTile(
      //       onTap: (){
      //         Navigator.push(context, MaterialPageRoute(builder: (context)=> InformeAdmPage()));
      //       },
      //       title: Text("PREVENTIVO"),
      //       trailing: Icon(Icons.chevron_right),
      //     ),
      //
      //     ListTile(
      //       onTap: (){
      //         Navigator.push(context, MaterialPageRoute(builder: (context)=> InformeAdmPage()));
      //       },
      //       title: Text("CORRECTIVO"),
      //       trailing: Icon(Icons.chevron_right),
      //     ),
      //   ],
      // ),
      body: Center(
        child: Column(
          children: [
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 5,
                  color: Theme.of(context).colorScheme.background,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print("ROL: "+widget.rolcito);
                  //debugPrint('Card tapped.');
                  if(widget.rolcito =="1" || widget.rolcito =="8" || widget.rolcito =="13") {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> VehiculosPage()));
                  }
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: const SizedBox(
                    width: 300,
                    height: 100,
                    child: Center(child: Text('PREVENTIVO')),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 5,
                  color: Colors.lightGreen,
                //  color: Theme.of(context).colorScheme.background,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: InkWell(
                splashColor: Colors.green.withAlpha(30),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> InformeAdmPage()));
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,


                  child: const SizedBox(
                    width: 300,
                    height: 100,
                    child: Center(child: Text('CORRECTIVO')),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
