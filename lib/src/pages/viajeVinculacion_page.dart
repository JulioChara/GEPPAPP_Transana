import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/consumosListado_model.dart';
import 'package:transana_app/src/models/extra_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/services/consumos_services.dart';
import 'package:transana_app/src/services/detail_services.dart';
import 'package:snack/snack.dart';
import 'package:transana_app/src/widgets/dialog.dart';

class viajeVinculacionPage extends StatefulWidget {
  @override
  _viajeVinculacionPageState createState() => _viajeVinculacionPageState();
}

class _viajeVinculacionPageState extends State<viajeVinculacionPage> {
  bool loading = true;
  bool loadingSend = false;

  static List<vinculacionModel> vinculacion = [];
  GlobalKey<AutoCompleteTextFieldState<vinculacionModel>> keyVinculacion = new GlobalKey();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  AutoCompleteTextField? searchVinculacion;
  TextEditingController DocumentoEditingController = new TextEditingController();
  TextEditingController ProveedorEditingController = new TextEditingController();
  TextEditingController CantidadEditingController = new TextEditingController();
  TextEditingController TotalEditingController = new TextEditingController();

  var objDetailServices = new DetailServices();
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  consumoModel ConsumoModel = new consumoModel();

  void getData() async {
    try {

      vinculacion = await objDetailServices.cargarVinculacion();
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
    final bar = SnackBar(content: Text('Hello, world!'));

    return Scaffold(
        appBar: AppBar(
          title: Text("Vincular Documento"),
          backgroundColor: Colors.orange,
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
                      searchVinculacion = fieldDocumento(),
                      SizedBox(
                        height: 20.0,
                      ),

                      TextFormField(
                        readOnly: true,
                        enableInteractiveSelection: true,
                        controller: DocumentoEditingController,
                        decoration: InputDecoration(
                          labelText: "Documento",
                          prefixIcon: Container(
                            width: 20,
                            height: 20,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/document.svg"),
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
                          //consumoModel.concepto = value;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        readOnly: true,
                        enableInteractiveSelection: true,
                        controller: ProveedorEditingController,
                        decoration: InputDecoration(
                          labelText: "Proveedor",
                          prefixIcon: Container(
                            width: 20,
                            height: 20,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/user.svg"),
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
                          //consumoModel.concepto = value;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        readOnly: true,
                        enableInteractiveSelection: true,
                        controller: CantidadEditingController,
                        decoration: InputDecoration(
                          labelText: "Galones",
                          prefixIcon: Container(
                            width: 20,
                            height: 20,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/product.svg"),
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
                          //consumoModel.concepto = value;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        readOnly: true,
                        enableInteractiveSelection: true,
                        controller: TotalEditingController,
                        decoration: InputDecoration(
                          labelText: "Monto Total",
                          prefixIcon: Container(
                            width: 20,
                            height: 20,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/price.svg"),
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
                          //consumoModel.concepto = value;
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      CupertinoButton(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "Vincular Documento",
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
                        color: Colors.orange,
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
                                          "Esta seguro de vincular el documento"),
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
    ConsumoService service = new ConsumoService();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString("idUser")!;
    String idVijae = await prefs.getString("IdVijae")!;

    print(id);
    print(idVijae);
    ConsumoModel.usercreacion = id;
    ConsumoModel.idViaje = idVijae;
    setState(() {
      loadingSend = true;
    });

    String res = await service.vincularConsumo(ConsumoModel);


    if (res == "1") {

      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text("Se vinculo el documento correctamente"),
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
              content: Text("Hubo un problema, Verifique que selecciono el documento correctamente."),
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


  AutoCompleteTextField<vinculacionModel> fieldDocumento() {

    return AutoCompleteTextField<vinculacionModel>(
      key: keyVinculacion,
      clearOnSubmit: false,
      suggestions: vinculacion,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),

      decoration: InputDecoration(
        labelText: "Documento a Vincular",
        hintStyle: TextStyle(color: Colors.black54),

        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 17.0,
          height: 17.0,
          child: SvgPicture.asset(
            "assets/icons/document.svg",
            color: Colors.black87.withOpacity(0.6),
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      itemFilter: (item, query) {
        return item.descripcion!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.descripcion!.compareTo(b.descripcion!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchVinculacion!.textField!.controller!.text = item.descripcion!;
          ConsumoModel.idCompra = item.Id;
          print(ConsumoModel.idCompra);
          ConsumoModel.proveedor = item.proveedor;
          ConsumoModel.documento = item.documento;
          ConsumoModel.galones = item.cantidad;
          ConsumoModel.total = item.total;
          DocumentoEditingController.text = item.documento!;
          ProveedorEditingController.text = item.proveedor!;
          CantidadEditingController.text = item.cantidad!;
          TotalEditingController.text = item.total!;

        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowVinculacion(item);
      },
    );
  }

  Widget rowVinculacion(vinculacionModel vinculacion) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              vinculacion.documento!,
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
              vinculacion.proveedor!,
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
