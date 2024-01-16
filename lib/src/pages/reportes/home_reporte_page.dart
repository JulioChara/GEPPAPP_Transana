
import 'package:flutter/material.dart';
import 'package:transana_app/src/pages/reportes/informe_unidad_reporte_page.dart';
import 'package:transana_app/src/widgets/menu_widget.dart';

class HomeReportePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(),
      appBar: AppBar(
        title: Text("Reportes"),
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> InformeUnidadReportePage()));
            },
            title: Text("Informe de unidad"),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
