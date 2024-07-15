import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/informes_model.dart';
import 'package:transana_app/src/models/placa_model.dart';
import 'package:transana_app/src/models/extra_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/models/producto_model.dart';
import 'package:transana_app/src/services/informe_services.dart';
import 'package:transana_app/src/services/detail_services.dart';
import 'package:snack/snack.dart';
import 'package:transana_app/src/widgets/dialog.dart';

class InformeCreatePage extends StatefulWidget {
  @override
  _InformeCreatePageState createState() => _InformeCreatePageState();
}

class _InformeCreatePageState extends State<InformeCreatePage> {
  bool loading = true;
  bool loadingSend = false;

  static List<Placa> placas = [];
  GlobalKey<AutoCompleteTextFieldState<Placa>> keyPlaca = new GlobalKey();

  static List<TipoPrioridad> tipoPrioridad = [];
  GlobalKey<AutoCompleteTextFieldState<TipoPrioridad>> keyTipo = new GlobalKey();

  static List<TipoInsidencia> tipoInsidencias = [];
  GlobalKey<AutoCompleteTextFieldState<TipoInsidencia>> keyTipoInsidencias = new GlobalKey();


  List<ProductoInformes> productoLista = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  AutoCompleteTextField? searchPlaca;
  AutoCompleteTextField? searchTipo;
  AutoCompleteTextField? searchTipoInsidencia;
  TextEditingController ConceptoEditingController = new TextEditingController();

  var objDetailServices = new DetailServices();
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  InformeModel informeModel = new InformeModel();

  Placa? _selectedPlaca;
  TipoPrioridad? _selectedPrioridad;
  TipoInsidencia? _selectedInsidencia;
  List<DropdownMenuItem<Placa>>? _placaDropdownMenuItems;
  List<DropdownMenuItem<TipoPrioridad>>? _tipoDropdownMenuItems;
  List<DropdownMenuItem<TipoInsidencia>>? _tipoInsidenciaDropdownMenuItems;

  void getData() async {
    try {

      placas = await objDetailServices.cargarPlaca();
      _placaDropdownMenuItems = buildDropDownMenuItems(placas);

      tipoPrioridad = await objDetailServices.cargarTipoPrioridad();
      _tipoDropdownMenuItems = buildDropDownMenuTipos(tipoPrioridad);

      tipoInsidencias = await objDetailServices.cargarTipoInsidencias();
      _tipoInsidenciaDropdownMenuItems = buildDropDownMenuTiposInsidencias(tipoInsidencias);

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }
  addItemProducto(ProductoInformes producto) {
    productoLista.add(producto);
    var pr= productoLista;
    setState(() {});
    //print(pr.toList());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  List<DropdownMenuItem<Placa>> buildDropDownMenuItems(List placas) {
    List<DropdownMenuItem<Placa>> items = [];
    for (Placa placa in placas) {
      items.add(DropdownMenuItem( value: placa, child: Text(placa.descripcion!),));
    }
    return items;
  }

  List<DropdownMenuItem<TipoPrioridad>> buildDropDownMenuTipos(List tipos) {
    List<DropdownMenuItem<TipoPrioridad>> items = [];
    for (TipoPrioridad tipo in tipos) {
      items.add(DropdownMenuItem( value: tipo, child: Text(tipo.descripcion!),));
    }
    return items;
  }

  List<DropdownMenuItem<TipoInsidencia>> buildDropDownMenuTiposInsidencias(List tipos) {
    List<DropdownMenuItem<TipoInsidencia>> items = [];
    for (TipoInsidencia tipo in tipos) {
      items.add(DropdownMenuItem( value: tipo, child: Text(tipo.descripcion!),));
    }
    return items;
  }

  onChangeDropdownItem(Placa? selectedPlaca) {
    informeModel.vehiculo = selectedPlaca!.descripcion!;
    setState(() {
      _selectedPlaca = selectedPlaca;
      print(_selectedPlaca!.descripcion);

    });
  }

  onChangeDropdownTipos(TipoPrioridad? selectedPrioridad) {
    informeModel.tipoprioridad = selectedPrioridad!.id;
    print(selectedPrioridad.id);
    setState(() {
      _selectedPrioridad = selectedPrioridad;
    });
  }

  onChangeDropdownTiposInsidencia(TipoInsidencia? selectedInsidencias) {
    setState(() {
      _selectedInsidencia = selectedInsidencias;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bar = SnackBar(content: Text('Hello, world!'));

    return Scaffold(
        appBar: AppBar(
          title: Text("Informes Vehiculares"),
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
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Tipo Prioridad",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              "assets/icons/tick.svg", color: Colors.black54,),
                          ),
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        isExpanded: true,
                        value: _selectedPrioridad,
                        items: _tipoDropdownMenuItems,
                        onChanged: onChangeDropdownTipos,
                        elevation: 2,
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                        isDense: true,
                        iconSize: 40.0,
                      ),

                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(
                        height: 20.0,
                      ),
                      Text(
                        "DETALLE",
                        style: TextStyle(
                            fontSize: 18.0,
                            letterSpacing: 1.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Tipo Producto",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                              "assets/icons/service.svg", color: Colors.black54,),
                          ),
                          contentPadding: EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        isExpanded: true,
                        value: _selectedInsidencia,
                        items: _tipoInsidenciaDropdownMenuItems,
                        onChanged: onChangeDropdownTiposInsidencia,
                        elevation: 2,
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                        isDense: true,
                        iconSize: 40.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: ConceptoEditingController,
                        decoration: InputDecoration(
                          hintText: "Coloque el informe aqui",
                          labelText: "Concepto",
                          prefixIcon: Container(
                            width: 20,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset(
                                "assets/icons/adjust.svg"),
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
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      CupertinoButton(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "Agregar",
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
                        color: Color(0XFF51E2A7),
                        onPressed: ConceptoEditingController.text.length > 0
                            ? () {
                          print("mayor que cero");
                          var prod = new ProductoInformes(
                              productoId: _selectedInsidencia!.id,
                              producto: ConceptoEditingController.text,
                              Tipo: _selectedInsidencia!.descripcion,
                              );
                          addItemProducto(prod);
                          ConceptoEditingController.clear();
                        }
                        : null,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      Column(
                        children: <Widget>[
                          SizedBox(
                            height: 200, // fixed height
                            child: productoLista.length > 0
                                ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                padding: const EdgeInsets.all(8),
                                itemCount: productoLista.length,
                                itemBuilder: (BuildContext context,
                                    int index) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15.0,
                                    ),
                                    title: Text(
                                      productoLista[index]
                                          .producto!
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.black54),
                                    ),
                                    subtitle: Text(
                                      "Tipo.: ${productoLista[index].Tipo} ",
                                      style:
                                      TextStyle(fontSize: 13.0),
                                    ),
                                    trailing: Container(
                                      padding: EdgeInsets.zero,
                                      child: IconButton(
                                        icon: Icon(Icons.delete),
                                        color:
                                        Colors.redAccent.shade200,
                                        onPressed: () {
                                          print(index);
                                          productoLista
                                              .removeAt(index);
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    onTap: () {
                                      // abrirScan(scans[i], context);
                                    },
                                  );
                                })
                                : Center(
                              child: Text(
                                "No hay productos en la lista.",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.black26),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(
                        height: 20.0,
                      ),

                      CupertinoButton(
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "REGISTRAR INFORME",
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
                                          "Esta seguro de grabar el Informe"),
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
    InformeService service = new InformeService();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString("idUser")!;
    print(id);
    informeModel.usercreacion = id;
    informeModel.tipoestado="10525";
    informeModel.Detalle = productoLista;
    setState(() {
      loadingSend = true;
    });



    String res = await service.registrarInforme(informeModel);


    if (res == "1") {

      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text("Informe Vehicular Grabado Correctamente"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, 'informeAdm');
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
        return item.descripcion!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.descripcion!.compareTo(b.descripcion!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchPlaca!.textField!.controller!.text = item.descripcion!;
          informeModel.vehiculo = item.descripcion;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowPlaca(item);
      },
    );
  }


  AutoCompleteTextField<TipoPrioridad> fieldTipo() {
    return AutoCompleteTextField<TipoPrioridad>(
      key: keyTipo,
      clearOnSubmit: false,
      suggestions: tipoPrioridad,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Tipo Prioridad",
        labelText: "Tipo Prioridad",
        hintStyle: TextStyle(color: Colors.black54),
        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 17.0,
          height: 17.0,
          child: SvgPicture.asset(
            "assets/icons/tick.svg",
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
          searchTipo!.textField!.controller!.text = item.descripcion!;
          informeModel.tipoprioridad = item.id;
          print(item.id);
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowTipo(item);
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
              placa.descripcion!,
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
              placa.categoria!,
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

  Widget rowTipo(TipoPrioridad tipoPrioridad) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              tipoPrioridad.descripcion!,
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
              tipoPrioridad.categoria!,
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
