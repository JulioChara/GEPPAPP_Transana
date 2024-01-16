import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/viaje_model.dart';
import 'package:transana_app/src/models/placa_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/services/viaje_services.dart';
import 'package:transana_app/src/services/detail_services.dart';
import 'package:snack/snack.dart';
import 'package:transana_app/src/widgets/dialog.dart';

class ViajeCreatePage extends StatefulWidget {
  @override
  _ViajeCreatePageState createState() => _ViajeCreatePageState();
}

class _ViajeCreatePageState extends State<ViajeCreatePage> {
  bool loading = true;
  bool loadingSend = false;

  static List<Placa> placas = new List<Placa>();
  GlobalKey<AutoCompleteTextFieldState<Placa>> keyPlaca = new GlobalKey();


  final scaffoldKey = GlobalKey<ScaffoldState>();

  AutoCompleteTextField searchPlaca;
  TextEditingController origenEditingController = new TextEditingController();
  TextEditingController destinoEditingController = new TextEditingController();
  TextEditingController kilometrajeEditingController = new TextEditingController();
  TextEditingController ComentariosEditingController = new TextEditingController();
  TextEditingController saldoInicialEditingController = new TextEditingController();


  var objDetailServices = new DetailServices();

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  ViajeModel viajeModel = new ViajeModel();

  Placa _selectedPlaca;
  List<DropdownMenuItem<Placa>> _placaDropdownMenuItems;

  void getData() async {
    try {

      placas = await objDetailServices.cargarPlaca();
      _placaDropdownMenuItems = buildDropDownMenuItems(placas);

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

  List<DropdownMenuItem<Placa>> buildDropDownMenuItems(List placas) {
    List<DropdownMenuItem<Placa>> items = List();
    for (Placa placa in placas) {
      items.add(DropdownMenuItem( value: placa, child: Text(placa.descripcion),));
    }
    return items;
  }


  onChangeDropdownItem(Placa selectedPlaca) {
    viajeModel.vehiculo = selectedPlaca.descripcion;
    setState(() {
      _selectedPlaca = selectedPlaca;
      print(_selectedPlaca.descripcion);

    });
  }

  @override
  Widget build(BuildContext context) {
    final bar = SnackBar(content: Text('Hello, world!'));

    return Scaffold(
        appBar: AppBar(
          title: Text("Viajes Conductores"),
          backgroundColor: Colors.green,
        ),
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
                      //searchTipoTipos = fieldTipoTipos(),
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

                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: origenEditingController,
                        style: TextStyle(
                            color: Colors.black54, fontSize: 16.0),
                        decoration: InputDecoration(
                          hintText: "Cerro Colorado-Arequipa",
                          labelText: "Dirección Origen",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/adress.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                           viajeModel.origen = value;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: destinoEditingController,
                        style: TextStyle(
                            color: Colors.black54, fontSize: 16.0),
                        decoration: InputDecoration(
                          hintText: "La Aguadita-Chala",
                          labelText: "Dirección Destino",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/adress.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                           viajeModel.destino = value;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: kilometrajeEditingController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "kilometraje",
                          labelText: "kilometraje",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/kilometro.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(10)),
                        ),
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onChanged: (value) {
                          viajeModel.kilometraje = value;
                        },
                      ),

                      //---------------------------------AQUA CAMBIOS ----------------------


                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: saldoInicialEditingController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          hintText: "Saldo Inicial",
                          labelText: "Saldo Inicial",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/dolar.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(10)),
                        ),
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onChanged: (value) {
                          viajeModel.saldoInicial = value;
                        },
                      ),

                      // -------------------------------END AQUACAMBIOS---------------------






                      SizedBox(
                        height: 20.0,
                      ),

                      TextFormField(
                        controller: ComentariosEditingController,
                        decoration: InputDecoration(
                          hintText: "Si tiene algun comentario coloquelo aqui",
                          labelText: "Comentarios",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/service.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 3,
                        keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onChanged: (value) {
                          viajeModel.comentarios = value;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      CupertinoButton(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "REGISTRAR VIAJE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        color: Colors.green,
                        onPressed: () {
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
                                          "Esta seguro de grabar el Viaje"),
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
                                        _sendData();
                                        setState(() {
                                        });
                                        Navigator.pop(context);

                                      },
                                      child: Text("Enviar"),
                                    )
                                  ],
                                );
                              });
                        },
                      ),
                      SizedBox(
                        height: 70.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (loadingSend)
              Positioned(
                child: Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ));
  }



  _sendData() async {
    ViajeService service = new ViajeService();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString("idUser");
    print(id);
    viajeModel.usercreacion = id;

    setState(() {
      loadingSend = true;
    });

    String res = await service.registrarViaje(viajeModel);


    if (res == "1") {

      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text("Viaje Grabado Correctamente"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                   Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, 'viajes');
                  },
                  child: Text("Aceptar"),
                )
              ],
            );
          }
      );

      setState(() {
        loadingSend = false;
      });

    }else{

      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text("Hubo un problema, Verifique que todos los datos esten llenos e inténtelo nuevamente."),
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
      setState(() {
        loadingSend = false;
      });
    }


  }


  AutoCompleteTextField<Placa> fieldPlaca() {
    return AutoCompleteTextField<Placa>(
      key: keyPlaca,
      clearOnSubmit: false,
      suggestions: placas,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Placa",
        labelText: "Placa",
        hintStyle: TextStyle(color: Colors.black54),
        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 17.0,
          height: 17.0,
          child: SvgPicture.asset(
            "assets/icons/car-parking.svg",
            color: Colors.black87.withOpacity(0.6),
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      itemFilter: (item, query) {
        return item.descripcion.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.descripcion.compareTo(b.descripcion);
      },
      itemSubmitted: (item) {
        setState(() {
          searchPlaca.textField.controller.text = item.descripcion;
          viajeModel.vehiculo = item.descripcion;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowPlaca(item);
      },
    );
  }


  Widget rowPlaca(Placa placa) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              placa.descripcion,
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
              placa.categoria,
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
