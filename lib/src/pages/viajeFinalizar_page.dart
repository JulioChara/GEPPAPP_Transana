import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/viaje_model.dart';
import 'package:transana_app/src/models/extra_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/services/viaje_services.dart';
import 'package:transana_app/src/services/detail_services.dart';
import 'package:snack/snack.dart';
import 'package:transana_app/src/widgets/dialog.dart';

class viajeFinalizarPage extends StatefulWidget {
  @override
  _viajeFinalizarPageState createState() => _viajeFinalizarPageState();
}

class _viajeFinalizarPageState extends State<viajeFinalizarPage> {
  bool loading = true;
  bool loadingSend = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController KilometrosFinalEditingController = new TextEditingController();
  TextEditingController PrecintoEditingController = new TextEditingController();
  TextEditingController Precinto2EditingController = new TextEditingController();
  TextEditingController KilometrosRecorridoEditingController = new TextEditingController();

  var objDetailServices = new DetailServices();
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  ViajeModel viajeModel = new ViajeModel();

  void getData() async {
    try {
      setState(() {
        viajeModel.precinto= "";
        viajeModel.precinto2= "";
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
    final bar = SnackBar(content: Text('Hello, world!'));

    return Scaffold(
        appBar: AppBar(
          title: Text("Finalizar Viaje"),
          backgroundColor: Colors.red,
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
                      TextFormField(
                        controller: PrecintoEditingController,
                        decoration: InputDecoration(
                          labelText: "Precinto",
                          prefixIcon: Container(
                            width: 20,
                            height: 20,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/car-parking.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onChanged: (value) {
                          viajeModel.precinto = value;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: Precinto2EditingController,
                        decoration: InputDecoration(
                          labelText: "Precinto 2",
                          prefixIcon: Container(
                            width: 20,
                            height: 20,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/car-parking.svg"),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.light,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (String text) {},
                        onChanged: (value) {
                          viajeModel.precinto2 = value;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: KilometrosFinalEditingController,
                        decoration: InputDecoration(
                          labelText: "KM Final",
                          prefixIcon: Container(
                            width: 20,
                            height: 20,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/kilometro.svg"),
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
                          viajeModel.kilometrajeFinal = value;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      SizedBox(
                        height: 20.0,
                      ),
                      CupertinoButton(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "Finalizar Viaje",
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
                        color: Colors.redAccent,
                        onPressed: () {

                          print(viajeModel.toJson());
                          // if(viajeModel.precinto.length >1 && viajeModel.precinto2.length >1){
                          if(viajeModel.precinto.length >1){
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
                                            "Esta seguro de finalizar el viaje"),
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

                          }else{
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
                                            "Complete todos los campos"),
                                        SizedBox(
                                          height: 10.0,
                                        ),
//                                      Icon(Icons.warning, size: 45.0, color: Colors.yellow,)
                                      ],
                                    ),
                                    actions: <Widget>[
                                      // FlatButton(
                                      //   onPressed: () {
                                      //     Navigator.pop(context);
                                      //   },
                                      //   child: Text("Cancelar"),
                                      // ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          // _sendData();
                                          // setState(() {
                                          // });
                                          // Navigator.pop(context);
                                        },
                                        child: Text("Aceptar"),
                                      )
                                    ],
                                  );
                                });

                          }




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
    String idVijae = await prefs.getString("IdVijae");

    print(id);
    print(idVijae);
    viajeModel.usercreacion = id;
    viajeModel.ViajId = idVijae;
    setState(() {
      loadingSend = true;
    });

    String res = await service.finalizarViaje(viajeModel);


    if (res == "1") {

      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text("Se finalizo correctamente el viaje"),
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
              content: Text("Hubo un problema, Verifique que coloco el kilometraje correcto."),
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


}
