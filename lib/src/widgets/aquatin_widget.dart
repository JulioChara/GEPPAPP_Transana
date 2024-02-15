import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:transana_app/src/models/empleado_model.dart';
import 'package:transana_app/src/services/empleado_services.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transana_app/src/widgets/menu_widget.dart';


class AquaEjemplo extends StatefulWidget {
//  const AquaEjemplo({Key? key}) : super(key: key);

  @override
  State<AquaEjemplo> createState() => _AquaEjemploState();

}

class _AquaEjemploState extends State<AquaEjemplo> {
  static List<EmpleadoModel> empleado = [];
  bool loading = true;
  GlobalKey<AutoCompleteTextFieldState<EmpleadoModel>> keyEmpleado = new GlobalKey();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  AutoCompleteTextField? searchEmpleado;

  var objDetailServices = new EmpleadoService();

  void getData() async {
    try {

      empleado = await objDetailServices.getEmpleadosList();
      //empleado = await objDetailServices.cargarTrabajadores();

      print("a");
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }


  @override
  Widget build(BuildContext context) {
    //return Container();
    final bar = SnackBar(content: Text('Hello, world!'));

    return Scaffold(
        appBar: AppBar(
          title: Text("TEST DE CONTROLES"),
          backgroundColor: Colors.purple,
        ),
        drawer: MenuWidget(),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : Stack(
          children: <Widget>[
            Container(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "DATOS GENERALES",
                        style: TextStyle(
                            fontSize: 18.0,
                            letterSpacing: 1.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

                      SizedBox(
                        height: 20.0,
                      ),

                      searchEmpleado = fieldEmpleado(),
                    /*
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Placa",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              "assets/icons/car-parking.svg", color: Colors.black54,),
                          ),
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        isExpanded: true,
                        value: _selectedPlaca,
                        items: _placaDropdownMenuItems,
                        onChanged: onChangeDropdownItem,
                        elevation: 2,
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                        isDense: true,
                        iconSize: 40.0,
                      ),
*/

                      SizedBox(
                        height: 70.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ));
  }











  AutoCompleteTextField<EmpleadoModel> fieldEmpleado() {

    return AutoCompleteTextField<EmpleadoModel>(
      key: keyEmpleado,
      clearOnSubmit: false,
      suggestions: empleado,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),

      decoration: InputDecoration(
        hintText: "Empleados",
        labelText: "Empleados",
        hintStyle: TextStyle(color: Colors.black54),

        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 17.0,
          height: 17.0,
          child: SvgPicture.asset(
            "assets/icons/frame.svg",
            color: Colors.black87.withOpacity(0.6),
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      itemFilter: (item, query) {
        return item.entiRazonSocial!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.entiRazonSocial!.compareTo(b.entiRazonSocial!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchEmpleado!.textField!.controller!.text = item.entiRazonSocial!;
         // guiaModel.remitente = item.id;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowEmpleado(item);
      },
    );
  }




  Widget rowEmpleado(EmpleadoModel empleado) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              empleado.entiRazonSocial!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: Text(
              empleado.entiNroDocumento!,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }





}
