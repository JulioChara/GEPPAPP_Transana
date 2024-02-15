import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/cliente_model.dart';
import 'package:transana_app/src/models/extra_model.dart';
import 'package:transana_app/src/models/guia_envio_model.dart';
import 'package:transana_app/src/models/guia_model.dart';
import 'package:transana_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transana_app/src/models/placa_model.dart';
import 'package:transana_app/src/models/placa_preferencial_model.dart';
import 'package:transana_app/src/models/producto_model.dart';
import 'package:transana_app/src/services/detail_services.dart';
import 'package:transana_app/src/models/conductor_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/services/guia_services.dart';
import 'package:snack/snack.dart';
import 'package:transana_app/src/widgets/dialog.dart';

class GeneralPage extends StatefulWidget {
  @override
  _GeneralPageState createState() => _GeneralPageState();
}

class _GeneralPageState extends State<GeneralPage> {

  String selDate = DateTime.now().toString().substring(0, 10);
  String origDate = DateTime.now().toString().substring(0, 10);
  bool loading = true;
  bool loadingSend = false;

  static List<Conductor> conductores =  [];
  static List<Cliente> clientes =  [];
  static List<Remitente> remitentes =  [];
  static List<Destinatario> destinatarios =  [];

  static List<Placa> placas = [];
  static List<TipoTipo> tipoTipos = [];
  static List<PlacaPreferencial> placasPreferenciales = [];
  static List<TipoSituacion> situacion =[];
  static List<TipoProducto> producto = [];
  static List<SubProductosModel> subproducto = [];
  static List<SubClientesModel> subclientes = [];

  List<Producto> productoLista =[];

  GlobalKey<AutoCompleteTextFieldState<Conductor>> keyConductor =  new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<Cliente>> keyCliente = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<Remitente>> keyRemitente = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<Destinatario>> keyDestinatario= new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<Placa>> keyPlaca = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TipoSituacion>> keySituacion = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TipoProducto>> keyProducto = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<PlacaPreferencial>> keyPlacaPreferencial = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TipoTipo>> keyTipoTipo = new GlobalKey();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  AutoCompleteTextField? searchConductor;
  AutoCompleteTextField? searchCliente;
  AutoCompleteTextField? searchRemitente;
  AutoCompleteTextField? searchDestinatario;
  AutoCompleteTextField? searchPlaca;
  AutoCompleteTextField? searchPlacaPreferencial;
  AutoCompleteTextField? searchSituacion;
  AutoCompleteTextField? searchProducto;
  AutoCompleteTextField? searchTipoTipos;

  TextEditingController direccionOrigenEditingController = new TextEditingController();
  TextEditingController guiaremisionEditingController = new TextEditingController();
  TextEditingController descripcionEditingController = new TextEditingController();
  TextEditingController serieEditingController = new TextEditingController();
  TextEditingController numeroEditingController = new TextEditingController();
  TextEditingController cantidadEditingController = new TextEditingController();
  TextEditingController precioEditingController = new TextEditingController();

  var objDetailServices = new DetailServices();
  var _guiaService = new GuiaService();

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  bool tieneSubclientes = true;

  String idAddProducto = "";

  GuiaEnvioModel guiaModel = new GuiaEnvioModel();

  Placa? _selectedPlaca;
  PlacaPreferencial? _selectedPlacaReferencial;

  TipoProducto? _selectedTipoProducto;
  SubProductosModel? _selectedTipoSubProducto;
  TipoSituacion? _selectedTipoSituacion;
  TipoTipo? _selectedTipoTipo;
  SubClientesModel? _selectedTipoSubClientes;


  List<DropdownMenuItem<Placa>>? _placaDropdownMenuItems;
  List<DropdownMenuItem<PlacaPreferencial>>? _placaReferencialDropdownMenuItems;
  List<DropdownMenuItem<TipoProducto>>? _productoReferencialDropdownMenuItems;
  List<DropdownMenuItem<SubProductosModel>>? _subproductoReferencialDropdownMenuItems;
  List<DropdownMenuItem<TipoSituacion>>? _situacionReferencialDropdownMenuItems;
  List<DropdownMenuItem<TipoTipo>>? _tipoTipoReferencialDropdownMenuItems;
  List<DropdownMenuItem<SubClientesModel>>? _subclientesDropdownMenuItems;


  void getData() async {
    try {
      conductores = await objDetailServices.cargarConductor();
      clientes = await objDetailServices.cargarCliente();
      remitentes = await objDetailServices.cargarRemitente();
      destinatarios = await objDetailServices.cargarDestinatario();
      placas = await objDetailServices.cargarPlaca();
      placasPreferenciales = await objDetailServices.cargarPlacaPreferencial();
      situacion = objDetailServices.cargarTipoSituacion();
      producto = objDetailServices.cargarTipoProducto();
      tipoTipos = await objDetailServices.cargarTipoTipo();

      _placaDropdownMenuItems = buildDropDownMenuItems(placas);
      _placaReferencialDropdownMenuItems = buildPlacaReferencialDropDownMenuItems(placasPreferenciales);

      _productoReferencialDropdownMenuItems = buildProductoReferencialDropDownMenuItems(producto);
      _situacionReferencialDropdownMenuItems = buildSituacionReferencialDropDownMenuItems(situacion);
      _tipoTipoReferencialDropdownMenuItems = buildTipoTipoReferencialDropDownMenuItems(tipoTipos);

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  addItemProducto(Producto producto) {
    productoLista.add(producto);
    setState(() {});
    print(productoLista);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }



  void ActualizadoresTipo(int cate, String id) async {
    //  loading = true;
    if(cate==1){
    }else if(cate ==2){
      print("nani");
      print("Send:" + id);
      // listTipoSubEstante = await _productosServices.getTipos_SubEstantes(_selectedTipoEstante!.tipoDescripcion!);  ///para sub estantes
      subproducto = await objDetailServices.getGuias_ObtenerSubProductos(id);  //para sub estantes
      print(subproducto.length);
      _subproductoReferencialDropdownMenuItems = buildSubProductoReferencialDropDownMenuItems(subproducto);
      //_tipoSubEstanteDropdownMenuItems = buildDropDownMenuTiposSubEstante(listTipoSubEstante);
      //  subpro
      _selectedTipoSubProducto = subproducto.first;
      //   _savemodel.tipoSubEstanteFk = listTipoSubEstante.first.tipoId;
    }

    setState(() {
      //loading =false;
      SetearDescripcion(id);
    });


  }


  void obtenerSubClientes(String id) async {
    subclientes = [];
    subclientes = await _guiaService.obtenerSubClientesxCliente(id);  //para sub estantes
    print(subclientes.length);
    _subclientesDropdownMenuItems = buildSubClientesDropDownMenuItems(subclientes);
    print("aaaaaaaaaa");
    setState(() {

      _selectedTipoSubClientes = subclientes.first;
      guiaModel.destinatario = subclientes.first.subClientesFk;
      if (subclientes.length >0 ) {
        if (subclientes.first.scId =="0"){
          tieneSubclientes = false;
        }else {
          tieneSubclientes = true;
        }
      }else {
        tieneSubclientes = false;
      }
    });
  }


  List<DropdownMenuItem<Placa>> buildDropDownMenuItems(List placas) {

    List<DropdownMenuItem<Placa>> items = [];

    for (Placa placa in placas) {
      items.add(DropdownMenuItem( value: placa, child: Text(placa.descripcion!),));
    }
    return items;
  }


  List<DropdownMenuItem<PlacaPreferencial>> buildPlacaReferencialDropDownMenuItems(List placas) {
    List<DropdownMenuItem<PlacaPreferencial>> items = [];
    for (PlacaPreferencial placa in placas) {
      items.add(DropdownMenuItem( value: placa, child: Text(placa.descripcion!),));
    }
    return items;
  }

  List<DropdownMenuItem<TipoSituacion>> buildSituacionReferencialDropDownMenuItems(List lista) {
    List<DropdownMenuItem<TipoSituacion>> items = [];
    for (TipoSituacion p in lista) {
      items.add(DropdownMenuItem( value: p , child: Text(p .descripcion!),));
    }
    return items;
  }

  List<DropdownMenuItem<TipoProducto>> buildProductoReferencialDropDownMenuItems(List lista) {
    List<DropdownMenuItem<TipoProducto>> items = [];
    for (TipoProducto p  in lista) {
      items.add(DropdownMenuItem( value: p , child: Text(p .descripcion!),));
    }
    return items;
  }
  List<DropdownMenuItem<SubProductosModel>> buildSubProductoReferencialDropDownMenuItems(List lista) {
    List<DropdownMenuItem<SubProductosModel>> items = [];
    for (SubProductosModel p  in lista) {
      items.add(DropdownMenuItem( value: p , child: Text(p .tipoDescripcion!),));
    }
    return items;
  }

  List<DropdownMenuItem<TipoTipo>> buildTipoTipoReferencialDropDownMenuItems(List lista) {
    List<DropdownMenuItem<TipoTipo>> items = [];
    for (TipoTipo p  in lista) {
      items.add(DropdownMenuItem( value: p , child: Text(p .descripcion!),));
    }
    return items;
  }

  List<DropdownMenuItem<SubClientesModel>> buildSubClientesDropDownMenuItems(List lista) {
    List<DropdownMenuItem<SubClientesModel>> items = [];
    for (SubClientesModel p  in lista) {
      items.add(DropdownMenuItem( value: p , child: Text(p .subClientesFkDesc!),));
    }
    return items;
  }




  onChangeDropdownItem(Placa? selectedPlaca) {
    guiaModel.placa = selectedPlaca!.descripcion;
    serieEditingController.text = selectedPlaca!.Serie!;
    guiaModel.serie = selectedPlaca!.Serie;
    setState(() {
      _selectedPlaca = selectedPlaca;
      print(_selectedPlaca!.descripcion);
    });
  }

  onPlancasReferencialChangeDropdownItem(PlacaPreferencial? selectedPlaca) {
    guiaModel.placaReferencial = selectedPlaca!.descripcion;
    setState(() {
      _selectedPlacaReferencial = selectedPlaca;
      print(_selectedPlacaReferencial!.descripcion);
    });
  }

  onTipoProductoChangeDropdownItem(TipoProducto? selected) {
    setState(() {
      _selectedTipoProducto = selected;
      print(_selectedTipoProducto!.descripcion);

      ActualizadoresTipo(2, selected!.id!);  //
    });
  }
  onTipoSubProductoChangeDropdownItem(SubProductosModel? selected) {
    setState(() {
      _selectedTipoSubProducto = selected;
      print(_selectedTipoSubProducto!.tipoDescripcion);
      SetearDescripcion(_selectedTipoSubProducto!.tipoId!);
    });

  }

  onTipoSituacionChangeDropdownItem(TipoSituacion? selected) {
    guiaModel.tipoSituacion = selected!.id;
    setState(() {
      _selectedTipoSituacion = selected;
      print(_selectedTipoSituacion!.descripcion);
    });
  }

  onTipoTipoChangeDropdownItem(TipoTipo? selected) {
    _selectedTipoTipo = selected;
    guiaModel.tipoProducto = selected!.id;
    setState(() {
      _selectedTipoTipo = selected;
      print(_selectedTipoTipo!.descripcion);
    });
  }
  onTipoSubClientesChangeDropdownItem(SubClientesModel? selected) {
    setState(() {
      print(":3");
      _selectedTipoSubClientes = selected;

      // _selectedTipoSubClientes = subclientes.first;
      print(_selectedTipoSubClientes!.subClientesFkDesc);
      print(":3 b");
      // SetearDescripcion(_selectedTipoSubClientes!.tipoId!);
    });
  }




  void SetearDescripcion(String id){

    String idPro = _selectedTipoProducto!.id!;
    String prodText = "";
    switch(idPro) {
      case "86": //COMBUSTIBLE
        prodText = "SERVICIO DE FLETE DE COMBUSTIBLE";
        break; // The switch statement must be told to exit, or it will execute every case.
      default:
        prodText =_selectedTipoProducto!.descripcion!;
    }
    if(_selectedTipoSubProducto!.tipoId!= "0"){
      prodText = prodText + " - " +_selectedTipoSubProducto!.tipoDescripcion!;
    }
    // else{
    //   descripcionEditingController.text = selected!.descripcion!;
    // }
    descripcionEditingController.text = prodText;
  }



  @override
  Widget build(BuildContext context) {
    final bar = SnackBar(content: Text('Hello, world!'));

    return Scaffold(
        appBar: AppBar(
          title: Text("Crear Guia de Remisión"),
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

                            SizedBox(
                              height: 20.0,
                            ),
                            searchCliente = fieldCliente(),
                            SizedBox(
                              height: 20.0,
                            ),
                            searchRemitente = fieldRemitente(),
                            SizedBox(
                              height: 20.0,
                            ),
                            // searchDestinatario= fieldDestinatario(),
                            tieneSubclientes== false ?(searchDestinatario= fieldDestinatario()) :DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: "Destinatarios",
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

                              // value: _selectedTipoSubClientes,
                              value:  _selectedTipoSubClientes,
                              items: _subclientesDropdownMenuItems,
                              onChanged: onTipoSubClientesChangeDropdownItem,
                              elevation: 2,
                              style: TextStyle(color: Colors.black54, fontSize: 16),
                              isDense: true,
                              iconSize: 40.0,
                            ),

                            SizedBox(height: 20.0,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 3)
                                  ]),
                              child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.date_range,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 7.0,
                                    ),
                                    Text(
                                      selDate,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )
                                  ],
                                ),
                                onPressed: () {
                                  _selectSelDate(context);
                                },
                              ),
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
                            //searchPlacaPreferencial = fieldPlacaPreferencial(),

                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: "Placa Referencial",
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
                              value: _selectedPlacaReferencial,
                              items: _placaReferencialDropdownMenuItems,
                              onChanged: onPlancasReferencialChangeDropdownItem,
                              elevation: 2,
                              style: TextStyle(color: Colors.black54, fontSize: 16),
                              isDense: true,
                              iconSize: 40.0,
                            ),

                            SizedBox(
                              height: 20.0,
                            ),


                            TextFormField(
                              readOnly: true,
                              enableInteractiveSelection: true,
                              controller: serieEditingController,
                              decoration: InputDecoration(
                                hintText: "Serie",
                                labelText: "Serie",
                                prefixIcon: Container(
                                  width: 20,
                                  height: 40,
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                      "assets/icons/send.svg"),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
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

                            TextFormField(
                              controller: numeroEditingController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Número",
                                labelText: "Número",
                                prefixIcon: Container(
                                  width: 20,
                                  height: 40,
                                  padding: EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                      "assets/icons/send.svg"),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              //keyboardType: TextInputType.emailAddress,
                              keyboardAppearance: Brightness.light,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String text) {},
                              onChanged: (value) {
                                  guiaModel.numero = value.toString();
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),

                            TextFormField(
                             controller: guiaremisionEditingController,
                             decoration: InputDecoration(
                               hintText: "009-200",
                               labelText: "Guia Remision",
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
                              maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
                              keyboardAppearance: Brightness.light,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                               guiaModel.guiaremision = value;
                              },
                              ),
                              SizedBox(
                               height: 20.0,
                             ),

                            //TextFormField(
                             // controller: direccionOrigenEditingController,
                            //  style: TextStyle(
                             //     color: Colors.black54, fontSize: 16.0),
                             // decoration: InputDecoration(
                             //   hintText: "Av. Angamos",
                             //   labelText: "Dirección Partida",
                             //   prefixIcon: Container(
                             //     width: 20,
                             //     height: 40,
                             //     padding: EdgeInsets.all(10),
                             //     child: SvgPicture.asset(
                              //        "assets/icons/adress.svg"),
                              //  ),
                             //   border: OutlineInputBorder(
                             //       borderRadius: BorderRadius.circular(10)),
                            //  ),
                            //  maxLines: 3,
                            //  keyboardType: TextInputType.emailAddress,
                            //  keyboardAppearance: Brightness.light,
                            //  textInputAction: TextInputAction.next,
                            //  onChanged: (value) {
                             //   guiaModel.dirPartida = value;
                            //  },
                          //  ),
                          //  SizedBox(
                           //   height: 20.0,
                           // ),
                           // TextFormField(
                           //   decoration: InputDecoration(
                            //    hintText: "Av. Angamos",
                            //    labelText: "Dirección Llegada",
                            //    prefixIcon: Container(
                            //      width: 20,
                             //     height: 40,
                             //     padding: EdgeInsets.all(10),
                             //     child: SvgPicture.asset(
                             //         "assets/icons/travel.svg"),
                             //   ),
                             //   border: OutlineInputBorder(
                             //       borderRadius: BorderRadius.circular(10)),
                            //  ),
                            //  maxLines: 3,
                            //  keyboardType: TextInputType.emailAddress,
                            //  keyboardAppearance: Brightness.light,
                            //  textInputAction: TextInputAction.next,
                            //  onFieldSubmitted: (String text) {},
                           //   onChanged: (value) {
                            //    guiaModel.dirLlegada = value;
                            //  },
                           // ),
                           // SizedBox(
                           //   height: 20.0,
                           // ),
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
                            //searchProducto = fieldTipoProducto(),


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
                              value: _selectedTipoProducto,
                              items: _productoReferencialDropdownMenuItems,
                              onChanged: onTipoProductoChangeDropdownItem,
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
                                labelText: "Sub Producto",
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
                              value: _selectedTipoSubProducto,
                              items: _subproductoReferencialDropdownMenuItems,
                              onChanged: onTipoSubProductoChangeDropdownItem,
                              elevation: 2,
                              style: TextStyle(color: Colors.black54, fontSize: 16),
                              isDense: true,
                              iconSize: 40.0,
                            ),

                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              controller: descripcionEditingController,
                              decoration: InputDecoration(
                                hintText: "Descripción",
                                labelText: "Descripción del producto",
                                prefixIcon: Container(
                                  width: 20,
                                  height: 40,
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
                                setState(() {});
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    controller: cantidadEditingController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "Cantidad",
                                      labelText: "Cantidad",
                                      prefixIcon: Container(
                                        width: 20,
                                        height: 40,
                                        padding: EdgeInsets.all(10),
                                        child: SvgPicture.asset(
                                            "assets/icons/overflow.svg"),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    keyboardAppearance: Brightness.light,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (String text) {},
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 7.0,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: precioEditingController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "Precio",
                                      labelText: "Precio",
                                      prefixIcon: Container(
                                        width: 20,
                                        height: 40,
                                        padding: EdgeInsets.all(10),
                                        child: SvgPicture.asset(
                                          "assets/icons/price.svg",
                                          color: Colors.black54,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    keyboardAppearance: Brightness.light,
                                    textInputAction: TextInputAction.next,
                                    onFieldSubmitted: (String text) {},
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
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
                              onPressed: descripcionEditingController
                                              .text.length >
                                          0 &&
                                      cantidadEditingController.text.length >
                                          0 &&
                                      precioEditingController.text.length > 0
                                  ? () {
                                      var prod = new Producto(
                                          productoId: _selectedTipoProducto!.id,
                                          producto:
                                              descripcionEditingController.text,
                                          cantidad:
                                              cantidadEditingController.text,
                                          precioUnitario:
                                              precioEditingController.text,
                                          total: _total(
                                                  cantidadEditingController
                                                      .text,
                                                  precioEditingController.text)
                                              .toString(),
                                          subProductoFk: _selectedTipoSubProducto!.tipoId
                                      );

                                      addItemProducto(prod);

                                      descripcionEditingController.clear();
                                      precioEditingController.clear();
                                      cantidadEditingController.clear();
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
                                                "Cant.: ${productoLista[index].cantidad} | Precio: S/. ${productoLista[index].precioUnitario} | Total: ${_total(productoLista[index].precioUnitario!, productoLista[index].cantidad!)}",
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
                                  "REGISTRAR GUIA",
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
                              color: Colors.lightBlueAccent,
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
                                                "Generar y enviar Guia de Remisión"),
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

//                          _sendData();
//
//                          setState(() {
//                            loadingSend = true;
//                          });
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

  double _total(String cantidad, String precio) {
    return double.parse((double.parse(cantidad) * double.parse(precio)).toStringAsFixed(2));
  }

  _sendData() async {
    GuiaService service = new GuiaService();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString("idUser")!;
    print(id);
    guiaModel.usuario = id;
    guiaModel.fechaGuia = selDate;
    guiaModel.detalle = productoLista;


    setState(() {
      loadingSend = true;
    });

    print(guiaModel);
    String res = await service.registrarGuia(guiaModel);


    if (res == "1") {

      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(20.0)),
              title: Text("Atención"),
              content: Text("Guia Generada y Enviada Correctamente"),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, 'home');
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
      setState(() {
        loadingSend = false;
      });
    }


  }

  Widget listProductos() {
    return ListView.builder(
      itemCount: productoLista.length,
      itemBuilder: (context, i) => Dismissible(
        direction: DismissDirection.horizontal,
        background: Container(
          color: Colors.pinkAccent,
        ),
        key: UniqueKey(),
        onDismissed: (direction) {},
        child: ListTile(
          leading: Icon(
            Icons.cloud_queue,
            color: Colors.pinkAccent,
          ),
          title: Text("sadsd"),
          subtitle: Text("asdsdsdsd"),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            color: Colors.pinkAccent,
          ),
          onTap: () {
            // abrirScan(scans[i], context);
          },
        ),
      ),
    );
  }

  AutoCompleteTextField<Conductor> fieldConductor() {
    return AutoCompleteTextField<Conductor>(
      key: keyConductor,
      clearOnSubmit: false,
      suggestions: conductores,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Conductor",
        labelText: "Conductor",
        hintStyle: TextStyle(color: Colors.black54),
        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 20.0,
          height: 20.0,
          child: SvgPicture.asset("assets/icons/truck.svg"),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      itemFilter: (item, query) {
        return item.razonSocial!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.razonSocial!.compareTo(b.razonSocial!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchConductor!.textField!.controller!.text = item.razonSocial!;
          guiaModel.conductor = item.id;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowConductor(item);
      },
    );
  }

  AutoCompleteTextField<Cliente> fieldCliente() {

    return AutoCompleteTextField<Cliente>(
      key: keyCliente,
      clearOnSubmit: false,
      suggestions: clientes,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),

      decoration: InputDecoration(
        hintText: "Cliente",
        labelText: "Cliente",
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
        return item.razonSocial!.toLowerCase().contains(query.toLowerCase()) || item.documento!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.razonSocial!.compareTo(b.razonSocial!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchCliente!.textField!.controller!.text = item.razonSocial!;
          guiaModel.cliente = item.id;

          subclientes = [];

          _selectedTipoSubClientes =null;
          //pene 2
          obtenerSubClientes(item.id!);  //12/12/2023
          print("Enviando: "+ item.id!);

          //guiaModel.dirPartida = item.direccion;
          //direccionOrigenEditingController.text = item.direccion;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowCliente(item);
      },
    );
  }

  AutoCompleteTextField<Remitente> fieldRemitente() {

    return AutoCompleteTextField<Remitente>(
      key: keyRemitente,
      clearOnSubmit: false,
      suggestions: remitentes,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),

      decoration: InputDecoration(
        hintText: "Remitente",
        labelText: "Remitente",
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
        return item.razonSocial!.toLowerCase().contains(query.toLowerCase()) || item.documento!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.razonSocial!.compareTo(b.razonSocial!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchRemitente!.textField!.controller!.text = item.razonSocial!;
          guiaModel.remitente = item.id;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowRemitente(item);
      },
    );
  }

  AutoCompleteTextField<Destinatario> fieldDestinatario() {

    return AutoCompleteTextField<Destinatario>(
      key: keyDestinatario,
      clearOnSubmit: false,
      suggestions: destinatarios,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),

      decoration: InputDecoration(
        hintText: "Destinatario",
        labelText: "Destinatario",
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
        return item.razonSocial!.toLowerCase().contains(query.toLowerCase()) || item.documento!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.razonSocial!.compareTo(b.razonSocial!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchDestinatario!.textField!.controller!.text = item.razonSocial!;
          guiaModel.destinatario = item.id;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowDestinatario(item);
      },
    );
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
          guiaModel.placa = item.descripcion;
          //serieEditingController.text = item.Serie;
          //print(item.Serie);
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowPlaca(item);
      },
    );
  }

  AutoCompleteTextField<PlacaPreferencial> fieldPlacaPreferencial() {
    return AutoCompleteTextField<PlacaPreferencial>(
      key: keyPlacaPreferencial,
      clearOnSubmit: false,
      suggestions: placasPreferenciales,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Placa Referencial",
        labelText: "Placa Referencial",
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
          searchPlacaPreferencial!.textField!.controller!.text = item.descripcion!;
          guiaModel.placaReferencial = item.descripcion;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowPlacaPreferencial(item);
      },
    );
  }

  AutoCompleteTextField<TipoSituacion> fieldTipoSituacion() {
    return AutoCompleteTextField<TipoSituacion>(
      key: keySituacion,
      clearOnSubmit: false,
      suggestions: situacion,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Tipo Situación",
        labelText: "Tipo Situación",
        hintStyle: TextStyle(color: Colors.black54),
        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 17.0,
          height: 17.0,
          child: SvgPicture.asset(
            "assets/icons/price.svg",
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
          searchSituacion!.textField!.controller!.text = item.descripcion!;
          guiaModel.tipoSituacion = item.id;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowTipoSituacion(item);
      },
    );
  }

  AutoCompleteTextField<TipoProducto> fieldTipoProducto() {
    return AutoCompleteTextField<TipoProducto>(
      key: keyProducto,
      clearOnSubmit: false,
      suggestions: producto,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Tipo Producto",
        labelText: "Tipo Producto",
        hintStyle: TextStyle(color: Colors.black54),
        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 17.0,
          height: 17.0,
          child: SvgPicture.asset(
            "assets/icons/service.svg",
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
          searchProducto!.textField!.controller!.text = item.descripcion!;
          idAddProducto = item.id!;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowTipoProducto(item);
      },
    );
  }

  AutoCompleteTextField<TipoTipo> fieldTipoTipos() {
    return AutoCompleteTextField<TipoTipo>(
      key: keyTipoTipo,
      clearOnSubmit: false,
      suggestions: tipoTipos,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Tipo Producto",
        labelText: "Tipo Producto",
        hintStyle: TextStyle(color: Colors.black54),
        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 17.0,
          height: 17.0,
          child: SvgPicture.asset(
            "assets/icons/service.svg",
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
          searchTipoTipos!.textField!.controller!.text = item.descripcion!;
          guiaModel.tipoProducto = item.id;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowTipoTipos(item);
      },
    );
  }




  Widget rowConductor(Conductor conductor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              conductor.razonSocial!,
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
              conductor.documento!,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget rowCliente(Cliente cliente) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              cliente.razonSocial!,
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
              cliente.documento!,
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


  Widget rowRemitente(Remitente remitente) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              remitente.razonSocial!,
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
              remitente.documento!,
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


  Widget rowDestinatario(Destinatario destinatario) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              destinatario.razonSocial!,
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
              destinatario.documento!,
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

  Widget rowPlacaPreferencial(PlacaPreferencial placa) {
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

  Widget rowTipoSituacion(TipoSituacion situacion) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              situacion.descripcion!,
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
              situacion.categoria!,
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

  Widget rowTipoProducto(TipoProducto producto) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              producto.descripcion!,
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
              producto.categoria!,
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

  Widget rowTipoTipos(TipoTipo tipo) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              tipo.descripcion!,
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
              tipo.categoria!,
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


  Future<Null> _selectSelDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: DateTime.parse(selDate),
        firstDate: DateTime.parse(origDate).add(const Duration(days: -3)),
        lastDate: DateTime.parse(origDate));

    if (picked != null)
      setState(() {
        selDate = picked.toString().substring(0, 10);
        print(selDate);
        //  _listViaje(context, viaje);
      });
  }


}
