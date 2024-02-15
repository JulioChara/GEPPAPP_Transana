






import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_tags/flutter_tags.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transana_app/src/models/extra_model.dart';
import 'package:transana_app/src/models/guia_model.dart';
import 'package:transana_app/src/models/guiasElectronicas/guiasElectronicas_model.dart';
import 'package:transana_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transana_app/src/models/placa_model.dart';
import 'package:transana_app/src/models/placa_preferencial_model.dart';
import 'package:transana_app/src/models/producto_model.dart';
import 'package:transana_app/src/models/widgets/chip_model.dart';
import 'package:transana_app/src/services/detail_services.dart';
import 'package:transana_app/src/services/guiasElectronicas/guiasElectronicas_services.dart';
import 'package:transana_app/utils/sp_global.dart';
import 'dart:developer';


import '../../models/cliente_model.dart';
import '../../models/conductor_model.dart';


class GuiasElectronicasCreatePage extends StatefulWidget {


  @override
  State<GuiasElectronicasCreatePage> createState() => _GuiasElectronicasCreatePageState();
}

class _GuiasElectronicasCreatePageState extends State<GuiasElectronicasCreatePage> {






  String selDate = DateTime.now().toString().substring(0, 10);
  String origDate = DateTime.now().toString().substring(0, 10);

  String selDate_tras = DateTime.now().toString().substring(0, 10);
  String origDate_tras = DateTime.now().toString().substring(0, 10);

  bool loading = true;
  bool loadingSend = false;

  static List<TiposModel> conductores = [];
  static List<TiposModel> clientes = [];
  static List<TiposModel> remitentes =[];
  static List<TiposModel> destinatarios =[];

  static List<TiposModel> placas = [];
  static List<TiposModel> tipoTipos = [];
  // static List<PlacaPreferencial> placasPreferenciales =[];
  static List<TiposModel> situacion = [];
  static List<TiposModel> producto = [];
  static List<SubProductosModel> subproducto = [];
  static List<SubClientesModel> subclientes = [];
  static List<TiposModel> tipoUnidadMedida = [];

  static List<ClientesUbigeoModel> ubigeoPartida = [];
  static List<ClientesUbigeoModel> ubigeoLlegada = [];

  List<GuiasElectronicasDetalleModel> productoLista = [];  //was PRODUCTO

 // List<Producto> productoLista = [];

  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyConductor =  new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyCliente = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyRemitente = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyDestinatario= new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyPlaca = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keySituacion = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyProducto = new GlobalKey();
  // GlobalKey<AutoCompleteTextFieldState<PlacaPreferencial>> keyPlacaPreferencial = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<TiposModel>> keyTipoTipo = new GlobalKey();



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
  // TextEditingController serieEditingController = new TextEditingController();
  TextEditingController numeroEditingController = new TextEditingController();
  TextEditingController cantidadEditingController = new TextEditingController();
  TextEditingController precioEditingController = new TextEditingController();
  TextEditingController pesoEditingController = new TextEditingController();

  TextEditingController direccionPartidaEditingController = new TextEditingController();
  TextEditingController direccionLlegadaEditingController = new TextEditingController();

  var _guiasElectronicasServices = new GuiasElectronicasServices();
  var _guiaService = new GuiasElectronicasServices();

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  final List<ChipModel> _chipList=[];
  final List<ChipModelConductores> _chipListConductores=[];

  bool tieneSubclientes = true;

  String idAddProducto = "";

  GuiasElectronicasModel guiaModel = new GuiasElectronicasModel();
  List<GuiasElectronicasDetalleModel> guiaDetalleModel = [];
  List<GuiasElectronicasConductoresModel> guiaConductoresModel = [];
  List<GuiasElectronicasPlacasModel> guiaPlacasModel = [];

  TiposModel? _selectedConductores; //wasa placa
  TiposModel? _selectedPlaca; //wasa placa
  // PlacaPreferencial? _selectedPlacaReferencial;

  TiposModel? _selectedTipoProducto;
  SubProductosModel? _selectedTipoSubProducto;
  ClientesUbigeoModel? _selectedUbigeoPartida;
  ClientesUbigeoModel? _selectedUbigeoLlegada;
  TiposModel? _selectedtipoUnidadMedida;
  TiposModel? _selectedTipoSituacion;
  TiposModel? _selectedTipoTipo;
  SubClientesModel? _selectedTipoSubClientes;

  List<DropdownMenuItem<TiposModel>>? _conductoresDropdownMenuItems;
  List<DropdownMenuItem<TiposModel>>? _placaDropdownMenuItems;
  // List<DropdownMenuItem<TiposModel>>? _placaReferencialDropdownMenuItems;
  List<DropdownMenuItem<TiposModel>>? _productoReferencialDropdownMenuItems;
  List<DropdownMenuItem<SubProductosModel>>? _subproductoReferencialDropdownMenuItems;
  List<DropdownMenuItem<ClientesUbigeoModel>>? _ubigeoPartidaDropdownMenuItems;
  List<DropdownMenuItem<ClientesUbigeoModel>>? _ubigeoLlegadaDropdownMenuItems;
  List<DropdownMenuItem<TiposModel>>? _tipoUnidadMedidaDropdownMenuItems;
  List<DropdownMenuItem<TiposModel>>? _situacionReferencialDropdownMenuItems;
  List<DropdownMenuItem<TiposModel>>? _tipoTipoReferencialDropdownMenuItems;

  List<DropdownMenuItem<SubClientesModel>>? _subclientesDropdownMenuItems;


  void getData() async {
    try {
      print("Part 1");
      conductores = await _guiasElectronicasServices.GuiasElectronicas_ObtenerConductores();
      _conductoresDropdownMenuItems = buildConductoresDropDownMenuItems(conductores);

      print("Part 2");
      clientes = await _guiasElectronicasServices.GuiasElectronicas_ObtenerClientes();
      print("Part 3");
      remitentes = clientes;
      destinatarios = clientes;

      print("Part 4");
      placas = await _guiasElectronicasServices.GuiasElectronicas_ObtenerPlacasAll();
      placas = await _guiasElectronicasServices.GuiasElectronicas_ObtenerPlacasAll();
      // placasPreferenciales = await objDetailServices.cargarPlacaPreferencial();

      ///: todo: revisar estas 3
      var objDetailServices = new GuiasElectronicasServices();
   //   var objDetailServices = new DetailServices();
      situacion = objDetailServices.Old_cargarTipoSituacion();
      producto = objDetailServices.Old_cargarTipoProducto();  //sospechoso
      // tipoTipos = await objDetailServices.cargarTipoTipo();
      tipoTipos = await _guiasElectronicasServices.GuiasElectronicas_ObtenerTipoTipos();
      tipoUnidadMedida = await _guiasElectronicasServices.GuiasElectronicas_ObtenerTipoUnidadMedida();  //para sub estantes
      _tipoUnidadMedidaDropdownMenuItems = buildTipoUnidadMedidaDropDownMenuItems(tipoUnidadMedida);



      print("Part 5");
      _placaDropdownMenuItems = buildDropDownMenuItems(placas);
      print("Part 5.5");
      // _placaReferencialDropdownMenuItems = buildPlacaReferencialDropDownMenuItems(placasPreferenciales);
      _productoReferencialDropdownMenuItems = buildProductoReferencialDropDownMenuItems(producto);
      print("Part 6");
      _situacionReferencialDropdownMenuItems = buildSituacionReferencialDropDownMenuItems(situacion);
      _tipoTipoReferencialDropdownMenuItems = buildTipoTipoReferencialDropDownMenuItems(tipoTipos);
      print("Part 7");



      // ubigeoPartida = await _guiaService.GuiasElectronicas_ObtenerUbigeoFinal();  //para sub estantes
      // print(ubigeoPartida.length);
      // _ubigeoPartidaDropdownMenuItems = buildUbigeoPartidaDropDownMenuItems(ubigeoPartida);
      //
      // ubigeoLlegada = ubigeoPartida;//para sub estantes
      // print(ubigeoLlegada.length);
      // _ubigeoLlegadaDropdownMenuItems = buildUbigeoLlegadaDropDownMenuItems(ubigeoLlegada);


      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  addItemProducto(GuiasElectronicasDetalleModel producto) {
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
      ubigeoPartida =await _guiasElectronicasServices.GuiasElectronicas_ObtenerDireccionesxCliente(id);  //para sub estantes
      ubigeoLlegada= ubigeoPartida;
      _ubigeoPartidaDropdownMenuItems = buildUbigeoPartidaDropDownMenuItems(ubigeoPartida);
      _ubigeoLlegadaDropdownMenuItems = buildUbigeoLlegadaDropDownMenuItems(ubigeoLlegada);

      _selectedUbigeoPartida = ubigeoPartida.first;
      _selectedUbigeoLlegada = ubigeoLlegada.first;


    }else if(cate ==2){
      print("nani");
      print("Send:" + id);
      // listTipoSubEstante = await _productosServices.getTipos_SubEstantes(_selectedTipoEstante!.tipoDescripcion!);  ///para sub estantes
      var objDetailServices = new DetailServices();
      subproducto = await objDetailServices.getGuias_ObtenerSubProductos(id);  //para sub estantes
      print(subproducto.length);
      _subproductoReferencialDropdownMenuItems = buildSubProductoReferencialDropDownMenuItems(subproducto);
      //_tipoSubEstanteDropdownMenuItems = buildDropDownMenuTiposSubEstante(listTipoSubEstante);
      //  subpro
      _selectedTipoSubProducto = subproducto.first;

      SetearDescripcion(id);

      //   _savemodel.tipoSubEstanteFk = listTipoSubEstante.first.tipoId;
    }
    setState(() {
      //loading =false;

    });

  }


  void obtenerSubClientes(String id) async {
    subclientes = [];
    subclientes = await _guiaService.obtenerSubClientesxCliente(id);  //para sub estantes
    print(subclientes.length);
    _subclientesDropdownMenuItems = buildSubClientesDropDownMenuItems(subclientes);
    print("aaaaaaaaaa");

    //_selectedTipoSubProducto = subproducto.first;


    setState(() {



      _selectedTipoSubClientes = subclientes.first;
      guiaModel.clienteDestinatarioFk = subclientes.first.subClientesFk;
      if (subclientes.length >0 ) {
        if (subclientes.first.scId =="0"){
          tieneSubclientes = false;
        }else {
          tieneSubclientes = true;
        }
      }else {
        tieneSubclientes = false;
      }




      //loading =false;
      //SetearDescripcion(id);
    });
  }


  List<DropdownMenuItem<TiposModel>> buildConductoresDropDownMenuItems(List Model) {

    List<DropdownMenuItem<TiposModel>> items = [];

    for (TiposModel model in Model) {  //conductires
      // items.add(DropdownMenuItem( value: placa, child: Text(placa.tipoDescripcion!),));
      items.add(DropdownMenuItem( value: model, child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${(model.tipoDescripcion!)}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          // Text(
          //   "${(model.idTipoGeneralFkDesc!)}",
          //   overflow: TextOverflow.ellipsis,
          //   maxLines: 1,
          //   style:
          //   TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          // ),
        ],
      )));
    }
    return items;
  }


  List<DropdownMenuItem<TiposModel>> buildDropDownMenuItems(List placas) {

    List<DropdownMenuItem<TiposModel>> items = [];

    for (TiposModel placa in placas) {
      // items.add(DropdownMenuItem( value: placa, child: Text(placa.tipoDescripcion!),));
      items.add(DropdownMenuItem( value: placa, child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${(placa.tipoDescripcion!)}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          Text(
            "${(placa.idTipoGeneralFkDesc!)}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style:
            TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
      )));
    }
    return items;
  }


  // List<DropdownMenuItem<PlacaPreferencial>> buildPlacaReferencialDropDownMenuItems(List placas) {
  //   List<DropdownMenuItem<PlacaPreferencial>> items = [];
  //   for (PlacaPreferencial placa in placas) {
  //     items.add(DropdownMenuItem( value: placa, child: Text(placa.descripcion!),));
  //   }
  //   return items;
  // }

  List<DropdownMenuItem<TiposModel>> buildSituacionReferencialDropDownMenuItems(List lista) {
    List<DropdownMenuItem<TiposModel>> items = [];
    for (TiposModel p in lista) {
      items.add(DropdownMenuItem( value: p , child: Text(p .tipoDescripcion!),));
    }
    return items;
  }

  List<DropdownMenuItem<TiposModel>> buildProductoReferencialDropDownMenuItems(List lista) {
    List<DropdownMenuItem<TiposModel>> items = [];
    for (TiposModel p  in lista) {
      items.add(DropdownMenuItem( value: p , child: Text(p .tipoDescripcion!),));
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

  List<DropdownMenuItem<ClientesUbigeoModel>> buildUbigeoPartidaDropDownMenuItems(List lista) {
    List<DropdownMenuItem<ClientesUbigeoModel>> items = [];
    for (ClientesUbigeoModel p  in lista) {
      items.add(DropdownMenuItem( value: p , child: Text(p .clubDireccionPartida!),));
    }
    return items;
  }
  List<DropdownMenuItem<ClientesUbigeoModel>> buildUbigeoLlegadaDropDownMenuItems(List lista) {
    List<DropdownMenuItem<ClientesUbigeoModel>> items = [];
    for (ClientesUbigeoModel p  in lista) {
      items.add(DropdownMenuItem( value: p , child: Text(p .clubDireccionLlegada!),));
    }
    return items;
  }
  List<DropdownMenuItem<TiposModel>> buildTipoUnidadMedidaDropDownMenuItems(List lista) {
    List<DropdownMenuItem<TiposModel>> items = [];
    for (TiposModel p  in lista) {
      items.add(DropdownMenuItem( value: p , child: Text(p .tipoDescripcion!),));
    }
    return items;
  }

  List<DropdownMenuItem<TiposModel>> buildTipoTipoReferencialDropDownMenuItems(List lista) {
    List<DropdownMenuItem<TiposModel>> items = [];
    for (TiposModel p  in lista) {
      items.add(DropdownMenuItem( value: p , child: Text(p .tipoDescripcion!),));
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




  onChangeDropdownItem(TiposModel? selectedPlaca) {  //por revisar
    setState(() {
      _selectedPlaca = selectedPlaca;
      print(_selectedPlaca!.tipoDescripcion);

      Color colorcito = Colors.white38;
      bool esPrincipal = true;

      if (_chipList.length ==0){
        if (_selectedPlaca!.idTipoGeneralFkDesc != "VEHICULO") {
          mensajeToast("Debe ingresar una placa Principal de manera inicial", Colors.red, Colors.white);
          return;
        }
        // serieEditingController.text = selectedPlaca!.tipoDescripcionCorta!;
        // guiaModel.gutrSerie = selectedPlaca.tipoDescripcionCorta;
        colorcito = Colors.green;
        esPrincipal = true;
      }else {
        esPrincipal = false;
        if(_selectedPlaca!.idTipoGeneralFkDesc == "VEHICULO"){
          colorcito = Colors.blue;
        }else {
          colorcito = Colors.orange;
        }
      }

      _chipList.add(ChipModel(id:selectedPlaca!.tipoId!, name: _selectedPlaca!.tipoDescripcion!, tipo: _selectedPlaca!.idTipoGeneralFkDesc!, colorcito: colorcito, esPrincipal: esPrincipal));

    });
  }

  onConductoresChangeDropdownItem(TiposModel? selected) {  //por revisar
    setState(() {
      _selectedConductores = selected;
      print("Inicio Chance Condductores");
      print(_selectedConductores!.tipoDescripcion);
      print(_selectedConductores!.tipoId);
      print("Inicio Chance Condductores END");

      Color colorcito = Colors.white38;
      bool esPrincipal = true;

      if (_chipListConductores.length ==0){
        // if (_selectedConductores!.idTipoGeneralFkDesc != "VEHICULO") {
        //   mensajeToast("Debe ingresar una placa Principal de manera inicial", Colors.red, Colors.white);
        //   return;
        // }
        // serieEditingController.text = selected!.tipoDescripcionCorta!;
      //  guiaModel.gutrSerie = selected.tipoDescripcionCorta;
        colorcito = Colors.green;
        esPrincipal = true;
      }else {
        esPrincipal = false;
        colorcito = Colors.orange;
      }

      _chipListConductores.add(ChipModelConductores(id:selected!.tipoId!, name: _selectedConductores!.tipoDescripcion!, colorcito: colorcito, esPrincipal: esPrincipal));
      print("Inicio Chance Condductores END end");
    });
  }




  void deleteChips(String id){
    setState(() {
      _chipList.removeWhere((element) => element.id == id);
    });
  }
  void deleteConductoresChips(String id){
    setState(() {
      _chipListConductores.removeWhere((element) => element.id == id);
    });
  }

mensajeToast(String mensaje, Color colorFondo, Color colorText) {
  Fluttertoast.showToast(
      msg: mensaje,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colorFondo,
      textColor: colorText,
      fontSize: 16.0);
}


  // onPlancasReferencialChangeDropdownItem(TiposModel? selectedPlaca) {
  //   guiaModel.placaReferencial = selectedPlaca!.descripcion;
  //   setState(() {
  //     _selectedPlacaReferencial = selectedPlaca;
  //     print(_selectedPlacaReferencial!.descripcion);
  //   });
  // }

  onTipoProductoChangeDropdownItem(TiposModel? selected) {
    setState(() {
      _selectedTipoProducto = selected;
      print(_selectedTipoProducto!.tipoDescripcion);

      ActualizadoresTipo(2, selected!.tipoId!);  //
    });

  }
  onTipoSubProductoChangeDropdownItem(SubProductosModel? selected) {
    setState(() {
      _selectedTipoSubProducto = selected;
      print(_selectedTipoSubProducto!.tipoDescripcion);
      SetearDescripcion(_selectedTipoSubProducto!.tipoId!);
    });
  }
  onUbigeoPartidaChangeDropdownItem(ClientesUbigeoModel? selected) {
    setState(() {
      _selectedUbigeoPartida = selected;
      print(_selectedUbigeoPartida!.clubDireccionPartida);
    });
  }
  onUbigeoLlegadaChangeDropdownItem(ClientesUbigeoModel? selected) {
    setState(() {
      _selectedUbigeoLlegada = selected;
      print(_selectedUbigeoLlegada!.clubDireccionLlegada);
    });
  }
  onTipoUnidadMedidaChangeDropdownItem(TiposModel? selected) {
    setState(() {
      _selectedtipoUnidadMedida = selected;
      print(_selectedtipoUnidadMedida!.tipoDescripcion);
    });
  }


  onTipoSituacionChangeDropdownItem(TiposModel? selected) {
    guiaModel.tipoEstadoSituacionFk = selected!.tipoId;
    setState(() {
      _selectedTipoSituacion = selected;
      print(_selectedTipoSituacion!.tipoDescripcion);
    });
  }

  onTipoTipoChangeDropdownItem(TiposModel? selected) {
    _selectedTipoTipo = selected;
    guiaModel.tipoServicioFk = selected!.tipoId;
    setState(() {
      _selectedTipoTipo = selected;
      print(_selectedTipoTipo!.tipoId);
      print(_selectedTipoTipo!.tipoDescripcion);
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

    String idPro = _selectedTipoProducto!.tipoId!;
    String prodText = "";
    switch(idPro) {
      case "75": //COMBUSTIBLE
        prodText = "SERVICIO DE FLETE DE COMBUSTIBLE";
        break; // The switch statement must be told to exit, or it will execute every case.
      default:
        prodText =_selectedTipoProducto!.tipoDescripcion!;
    }
    if(_selectedTipoSubProducto!.tipoId!= "0"){
      prodText = prodText + " - " +_selectedTipoSubProducto!.tipoDescripcion!;
    }
    // else{
    //   descripcionEditingController.text = selected!.descripcion!;
    // }
    descripcionEditingController.text = prodText;
  }


  // _write(String text) async {
  //   final Directory directory = await getApplicationDocumentsDirectory();
  //   final File file = File('${directory.path}/my_file.txt');
  //   await file.writeAsString(text);
  // }


  @override
  Widget build(BuildContext context) {
    final bar = SnackBar(content: Text('Hello, world!'));

    return Scaffold(
        appBar: AppBar(
          title: Text("Crear Guia Electronica"),
        ),
            floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
            tooltip: 'Increment',
            onPressed: (){
              print("Que riko aprietas kata");
              // print(_selectedTipoSubClientes!.scId);
              //todo: SANEADORES
              guiaDetalleModel = [];
              guiaConductoresModel = [];
              guiaPlacasModel = [];

              guiaModel.gutrFechaEmision = selDate;
              guiaModel.gutrFechaTraslado = selDate_tras;
              guiaModel.gutrPuntoPartida = _selectedUbigeoPartida!.clubDireccionPartida;
              guiaModel.gutrPuntoLlegada = _selectedUbigeoLlegada!.clubDireccionLlegada;

              guiaModel.unidadMedidaFk = _selectedtipoUnidadMedida!.tipoId;
              guiaModel.unidadMedidaFkDesc = _selectedtipoUnidadMedida!.tipoDescripcion;


              //
              // GuiasElectronicasDetalleModel test = new GuiasElectronicasDetalleModel();
              // guiaDetalleModel.add(test);

              if(_chipListConductores.length ==0){
                mensajeToast("No hay conductores", Colors.redAccent,Colors.white);
                return;
              }else{
                _chipListConductores.forEach((element){
                 GuiasElectronicasConductoresModel mod = new GuiasElectronicasConductoresModel();
                 mod.conductoresFk = element.id;
                 mod.conductoresFkDesc = element.name;
                 guiaConductoresModel.add(mod);
                });
              }

              if(_chipList.length ==0){
                mensajeToast("No hay placas", Colors.redAccent,Colors.white);
                return;
              }else{
                _chipList.forEach((element){
                  GuiasElectronicasPlacasModel mod = new GuiasElectronicasPlacasModel();
                  if(element.tipo =="VEHICULO"){
                    mod.vehiculosFk = element.id;
                    if (element.esPrincipal ==true){
                      mod.plreEstado = "1";
                    }
                  }else{
                    mod.placasFk = element.id;
                  }
                  guiaPlacasModel.add(mod);
                });
              }


              print("Camtidad DEtalles: "+productoLista.length.toString() ) ;
              productoLista.forEach((element){
                GuiasElectronicasDetalleModel mod = new GuiasElectronicasDetalleModel();
                mod.productosFk = element.productosFk;
                mod.tipoProductoUnidadMedidaFk = element.tipoProductoUnidadMedidaFk;
                mod.tipoProductoUnidadMedidaFkDesc = element.tipoProductoUnidadMedidaFkDesc;
                mod.gudePrecioUnitario = element.gudePrecioUnitario;
                //mod.gudePesoUnitario = element.gudePesoUnitario;
                mod.gudeMontoTotal= element.gudeMontoTotal;

                guiaDetalleModel.add(mod);
              });

              guiaModel.detalle = guiaDetalleModel;
              guiaModel.detalleConductores = guiaConductoresModel;
              guiaModel.detallePlacas = guiaPlacasModel;

             // print(guiaModel.toJson().toString());




              String s = guiaModel.toJson().toString();
              debugPrint(" =======> " + s, wrapWidth: 1024);


              // String json = guiaModel.toString();
              // int length = json.length;
              //
              //
              // for(int i=0; i<length; i+=1024)
              // {
              //   if(i+1024<length)
              //     log.d("JSON OUTPUT", json.substring(i, i+1024));
              //   else
              //     Log.d("JSON OUTPUT", json.substring(i, length));
              // }

            },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
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

                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Direccion Partida",
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
                        value: _selectedUbigeoPartida,
                        items: _ubigeoPartidaDropdownMenuItems,
                        onChanged: onUbigeoPartidaChangeDropdownItem,
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
                          labelText: "Direccion Llegada",
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
                        value: _selectedUbigeoLlegada,
                        items: _ubigeoLlegadaDropdownMenuItems,
                        onChanged: onUbigeoLlegadaChangeDropdownItem,
                        elevation: 2,
                        style: TextStyle(color: Colors.black54, fontSize: 16),
                        isDense: true,
                        iconSize: 40.0,
                      ),

                      SizedBox(
                        height: 20.0,
                      ),


                      searchRemitente = fieldRemitente(),
                      SizedBox(
                        height: 20.0,
                      ),


                      tieneSubclientes== false ? (searchDestinatario= fieldDestinatario()) :DropdownButtonFormField(
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
                  //    SizedBox(height: 20.0,),

                      // Text("Fecha Emision",
                      //     style: TextStyle(
                      //         color: Colors.black,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 18)),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       color: Colors.black,
                      //       borderRadius: BorderRadius.circular(10),
                      //       boxShadow: [
                      //         BoxShadow(
                      //             color: Colors.white,
                      //             blurRadius: 3)
                      //       ]),
                      //   child: CupertinoButton(
                      //     padding: EdgeInsets.zero,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: <Widget>[
                      //         Icon(
                      //           Icons.date_range,
                      //           color: Colors.white,
                      //         ),
                      //         SizedBox(
                      //           width: 7.0,
                      //         ),
                      //         Text(
                      //           selDate,
                      //           style: TextStyle(
                      //               color: Colors.white, fontSize: 18),
                      //         )
                      //       ],
                      //     ),
                      //     onPressed: () {
                      //       _selectSelDate(context);
                      //     },
                      //   ),
                      // ),
                      SizedBox(height: 20.0,),

                      Text("Fecha Traslado",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
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
                                selDate_tras,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              )
                            ],
                          ),
                          onPressed: () {
                            _selectSelDate_tras(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Conductores",
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
                        value: _selectedConductores,
                        items: _conductoresDropdownMenuItems,
                        onChanged: onConductoresChangeDropdownItem,
                        elevation: 2,
                        style: TextStyle(color: Colors.black54, fontSize: 12, overflow: TextOverflow.ellipsis),
                        isDense: true,
                        iconSize: 40.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      /// todo: CHIPS CONDUCTORES
                      Wrap(
                        spacing: 3,
                        children: _chipListConductores.map((chipConductor) => Chip(
                          label: Text(chipConductor.name),
                          labelStyle: TextStyle(fontSize: 12, color: Colors.white),
                          backgroundColor: chipConductor.colorcito ,
                          onDeleted: (){

                            deleteConductoresChips(chipConductor.id);

                            // print("Cantidad Lista Actual: "+_chipListConductores.length.toString());
                            //
                            // if (_chipListConductores.length !=1 && chipConductor.esPrincipal==false){
                            //   deleteConductoresChips(chipConductor.id);
                            // }else if(_chipListConductores.length ==1 && chipConductor.esPrincipal==true){
                            //   deleteConductoresChips(chipConductor.id);
                            // }
                            // else{
                            //   mensajeToast("No puede eliminarse el conductor principal, mientras existan otras placas", Colors.redAccent, Colors.white);
                            // }
                          },


                        )).toList(),
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

                      /// todo: CHIPS PLACAS
                      Wrap(
                        spacing: 3,
                        children: _chipList.map((chip) => Chip(
                          label: Text(chip.name),
                          labelStyle: TextStyle(fontSize: 12, color: Colors.white),
                          backgroundColor: chip.colorcito ,
                          onDeleted: (){
                            print("Cantidad Lista Actual: "+_chipList.length.toString());

                            if (_chipList.length !=1 && chip.esPrincipal==false){
                              deleteChips(chip.id);
                            }else if(_chipList.length ==1 && chip.esPrincipal==true){
                              deleteChips(chip.id);
                          //    serieEditingController.text = "";
                           //   guiaModel.gutrSerie = "";
                            }
                              else{
                              mensajeToast("No puede eliminarse la placa principal, mientras existan otras placas", Colors.redAccent, Colors.white);
                            }
                          },
                  

                        )).toList(),
                      ),




                      //searchPlacaPreferencial = fieldPlacaPreferencial(),
                      //
                      // DropdownButtonFormField(
                      //   decoration: InputDecoration(
                      //     labelText: "Placa Referencial",
                      //     prefixIcon: Container(
                      //       width: 20,
                      //       height: 40,
                      //       padding: EdgeInsets.all(10),
                      //       child: SvgPicture.asset(
                      //         "assets/icons/car-parking.svg", color: Colors.black54,),
                      //     ),
                      //     contentPadding: EdgeInsets.all(10.0),
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10)),
                      //   ),
                      //   isExpanded: true,
                      //   value: _selectedPlacaReferencial,
                      //   items: _placaReferencialDropdownMenuItems,
                      //   onChanged: onPlancasReferencialChangeDropdownItem,
                      //   elevation: 2,
                      //   style: TextStyle(color: Colors.black54, fontSize: 16),
                      //   isDense: true,
                      //   iconSize: 40.0,
                      // ),

                      SizedBox(
                        height: 20.0,
                      ),


                      // TextFormField(
                      //   readOnly: true,
                      //   enableInteractiveSelection: true,
                      //   controller: serieEditingController,
                      //   decoration: InputDecoration(
                      //     hintText: "Serie",
                      //     labelText: "Serie",
                      //     prefixIcon: Container(
                      //       width: 20,
                      //       height: 40,
                      //       padding: EdgeInsets.all(10),
                      //       child: SvgPicture.asset(
                      //           "assets/icons/send.svg"),
                      //     ),
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10)),
                      //   ),
                      //   keyboardType: TextInputType.emailAddress,
                      //   keyboardAppearance: Brightness.light,
                      //   textInputAction: TextInputAction.next,
                      //   onFieldSubmitted: (String text) {},
                      //   onChanged: (value) {
                      //     setState(() {});
                      //   },
                      // ),

                      SizedBox(
                        height: 20.0,
                      ),

                      // TextFormField(
                      //   controller: numeroEditingController,
                      //   keyboardType: TextInputType.number,
                      //   decoration: InputDecoration(
                      //     hintText: "Número",
                      //     labelText: "Número",
                      //     prefixIcon: Container(
                      //       width: 20,
                      //       height: 40,
                      //       padding: EdgeInsets.all(10),
                      //       child: SvgPicture.asset(
                      //           "assets/icons/send.svg"),
                      //     ),
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10)),
                      //   ),
                      //   //keyboardType: TextInputType.emailAddress,
                      //   keyboardAppearance: Brightness.light,
                      //   textInputAction: TextInputAction.next,
                      //   onFieldSubmitted: (String text) {},
                      //   onChanged: (value) {
                      //     guiaModel.gutrNumero = value.toString();
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 20.0,
                      // ),
                      //
                      // TextFormField(
                      //   controller: guiaremisionEditingController,
                      //   decoration: InputDecoration(
                      //     hintText: "009-200",
                      //     labelText: "Guia Remision",
                      //     prefixIcon: Container(
                      //       width: 20,
                      //       height: 40,
                      //       padding: EdgeInsets.all(10),
                      //       child: SvgPicture.asset(
                      //           "assets/icons/adress.svg"),
                      //     ),
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10)),
                      //   ),
                      //   maxLines: 1,
                      //   keyboardType: TextInputType.emailAddress,
                      //   keyboardAppearance: Brightness.light,
                      //   textInputAction: TextInputAction.next,
                      //   onChanged: (value) {
                      //     guiaModel.gutrGuiaRemision = value;
                      //   },
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
                      //searchProducto = fieldTipoProducto(),


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
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: "Unidad de Medida",
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
                        value: _selectedtipoUnidadMedida,
                        items: _tipoUnidadMedidaDropdownMenuItems,
                        onChanged: onTipoUnidadMedidaChangeDropdownItem,
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
                        readOnly: true,
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
                          SizedBox(
                            width: 7.0,
                          ),
                          // Expanded(
                          //   child: TextFormField(
                          //     controller: pesoEditingController,
                          //     keyboardType: TextInputType.number,
                          //     decoration: InputDecoration(
                          //       hintText: "Peso",
                          //       labelText: "Peso",
                          //       prefixIcon: Container(
                          //         width: 20,
                          //         height: 40,
                          //         padding: EdgeInsets.all(10),
                          //         child: SvgPicture.asset(
                          //           "assets/icons/gear.svg",
                          //           color: Colors.black54,
                          //         ),
                          //       ),
                          //       border: OutlineInputBorder(
                          //           borderRadius:
                          //           BorderRadius.circular(10)),
                          //     ),
                          //     keyboardAppearance: Brightness.light,
                          //     textInputAction: TextInputAction.next,
                          //     onFieldSubmitted: (String text) {},
                          //     onChanged: (value) {
                          //       setState(() {});
                          //     },
                          //   ),
                          // ),
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
                        //  &&  pesoEditingController.text.length > 0
                            ? () {
                          var prod = new GuiasElectronicasDetalleModel(
                            // tipoProductoFk: _selectedTipoTipo!.tipoId,
                            // tipoProductoFkDesc: _selectedTipoTipo!.tipoDescripcion,
                              productosFk: _selectedTipoProducto!.tipoId,
                              productosFkDesc:
                              descripcionEditingController.text,
                              tipoProductoUnidadMedidaFk: _selectedtipoUnidadMedida!.tipoId,
                              tipoProductoUnidadMedidaFkDesc: _selectedtipoUnidadMedida!.tipoDescripcion,
                              gudeCantidad:
                              cantidadEditingController.text,
                              gudePrecioUnitario:
                              precioEditingController.text,
                              // gudePesoUnitario:
                              // pesoEditingController.text,

                              gudeMontoTotal: _total(
                                  cantidadEditingController
                                      .text,
                                  precioEditingController.text)
                                  .toString(),
                              subProductoFk: _selectedTipoSubProducto!.tipoId
                          );

                          addItemProducto(prod);

                          descripcionEditingController.clear();
                          precioEditingController.clear();
                        //  pesoEditingController.clear();
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
                                          .productosFkDesc!
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 17.0,
                                          color: Colors.black54),
                                    ),
                                    subtitle: Text(
                                      "Cant.: ${productoLista[index].gudeCantidad} | Precio: S/. ${productoLista[index].gudePrecioUnitario}| Total: ${_total(productoLista[index].gudePrecioUnitario!, productoLista[index].gudeCantidad!)}",
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
                          String validar = validado();
                          if (validar.length > 0) {
                            print("Pre");
                            showMessajeAW(DialogType.ERROR, "Validacion", validar,0);
                            print("Pos");
                            // print(validar);
                            return;
                          }
                          else
                          {
                            AwesomeDialog(
                              dismissOnTouchOutside: false,
                              context: context,
                              dialogType: DialogType.QUESTION,
                              headerAnimationLoop: false,
                              animType: AnimType.TOPSLIDE,
                              showCloseIcon: true,
                              closeIcon: const Icon(Icons.close_fullscreen_outlined),
                              title: "Confirmacion",
                              descTextStyle: TextStyle(fontSize: 18),
                              desc: "¿Desea Guardar la Guia Electronica?",
                              btnCancelOnPress: () {},
                              onDissmissCallback: (type) {
                                debugPrint('Dialog Dissmiss from callback $type');
                              },
                              btnOkOnPress: () {
                                 _sendData();
                              },
                            ).show();

                          }


//                           showDialog(
//                               context: context,
//                               barrierDismissible: true,
//                               builder: (context) {
//                                 return AlertDialog(
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                       BorderRadius.circular(20.0)),
//                                   title: Text("Atención"),
//                                   content: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
//                                       Text(
//                                           "Generar y enviar Guia de Remisión"),
//                                       SizedBox(
//                                         height: 10.0,
//                                       ),
// //                                      Icon(Icons.warning, size: 45.0, color: Colors.yellow,)
//                                     ],
//                                   ),
//                                   actions: <Widget>[
//                                     FlatButton(
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                       },
//                                       child: Text("Cancelar"),
//                                     ),
//                                     FlatButton(
//                                       onPressed: () {
//
//
//
//
//
//
//                                       // //  _sendData();
//                                       //   setState(() {
//                                       //
//                                       //   });
//                                       //   Navigator.pop(context);
//                                       },
//                                       child: Text("Enviar"),
//                                     )
//                                   ],
//                                 );
//                               });

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
  // mensajeToast(String mensaje, Color colorFondo, Color colorText) {
  //   Fluttertoast.showToast(
  //       msg: mensaje,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 3,
  //       backgroundColor: colorFondo,
  //       textColor: colorText,
  //       fontSize: 16.0);
  // }


  showMessajeAW(DialogType type, String titulo, String desc, int accion){
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: type,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_fullscreen_outlined),
      title: titulo,
      descTextStyle: TextStyle(fontSize: 18),
      desc: desc,
      //  btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {
        switch(accion) {
          case 0: {
            // nada
          }
          break;
          case 1: { //Cuando se genera la nota de entrada
            Navigator.pushReplacementNamed(context, 'guiasElectronicasHome',);
          }
          break;
        }
      },
    ).show();
  }


  String validado() {
    String errores = "";

    if (guiaModel.clientesFk == null){
      errores = errores + "♦Seleccione un Cliente";
    }
    if (_selectedUbigeoPartida ==null){
      errores = errores + "\n♦Sin Punto de Partida";
    }else{
      if (_selectedUbigeoPartida!.clubId == "0" || _selectedUbigeoPartida!.clubId == null){
        errores = errores + "\n♦Punto de Partida no Valido";
      }
    }
    if (_selectedUbigeoLlegada ==null){
      errores = errores + "\n♦Sin Punto de Llegada";
    }else{
      if (_selectedUbigeoLlegada!.clubId == "0" || _selectedUbigeoLlegada!.clubId == null){
        errores = errores + "\n♦Punto de Llegada no Valido";
      }
    }
    if (guiaModel.clienteRemitenteFk == null){
      errores = errores + "\n♦Seleccione un Remitente";
    }
    if (guiaModel.clienteDestinatarioFk == null){
      errores = errores + "\n♦Seleccione un Destinatario";
    }
    if(_chipListConductores.length ==0){
      errores = errores + "\n♦No se selecciono ningun conductor";
    }
    if(_chipList.length ==0){
      errores = errores + "\n♦No se selecciono ninguna placa";
    }
    if (productoLista.length == 0) {
      errores = errores + "\n♦Agrege Productos";
    }

    return errores;
  }



  // _sendData() async {
  //   GuiaService service = new GuiaService();
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String id = await prefs.getString("idUser")!;
  //   print(id);
  //   guiaModel.usuario = id;
  //   guiaModel.fechaGuia = selDate;
  //   guiaModel.detalle = productoLista;
  //
  //   if (tieneSubclientes == true){
  //
  //   }else {
  //     if(guiaModel.destinatario == "0"){
  //       mensajeToast("Error al seleccionar Destinatario", Colors.red, Colors.white);
  //       return;
  //     }
  //     // mensajeToast("Error al seleccionar Destinatario", Colors.green, Colors.white);
  //   }
  //
  //   setState(() {
  //     loadingSend = true;
  //   });
  //
  //   print(guiaModel);
  //   String res = await service.registrarGuia(guiaModel);
  //
  //
  //   if (res == "1") {
  //
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context){
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius:
  //                 BorderRadius.circular(20.0)),
  //             title: Text("Atención"),
  //             content: Text("Guia Generada y Enviada Correctamente"),
  //             actions: <Widget>[
  //               FlatButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                   Navigator.pop(context);
  //                   Navigator.pushReplacementNamed(context, 'home');
  //                 },
  //                 child: Text("Aceptar"),
  //               )
  //             ],
  //           );
  //         }
  //     );
  //
  //     setState(() {
  //       loadingSend = false;
  //     });
  //
  //   }else{
  //
  //     showDialog(
  //         context: context,
  //         builder: (BuildContext context){
  //           return AlertDialog(
  //             shape: RoundedRectangleBorder(
  //                 borderRadius:
  //                 BorderRadius.circular(20.0)),
  //             title: Text("Atención"),
  //             content: Text("Hubo un problema, inténtelo nuevamente."),
  //             actions: <Widget>[
  //               FlatButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text("Aceptar"),
  //               )
  //             ],
  //           );
  //         }
  //     );
  //     setState(() {
  //       loadingSend = false;
  //     });
  //   }
  //
  //
  // }

  _sendData() async {
    guiaDetalleModel = [];
    guiaConductoresModel = [];
    guiaPlacasModel = [];

    guiaModel.gutrFechaEmision = selDate;
    guiaModel.gutrFechaTraslado = selDate_tras;
    guiaModel.gutrPuntoPartida = _selectedUbigeoPartida!.clubDireccionPartida;
    guiaModel.gutrPuntoLlegada = _selectedUbigeoLlegada!.clubDireccionLlegada;

    guiaModel.unidadMedidaFk = _selectedtipoUnidadMedida!.tipoId;
    guiaModel.unidadMedidaFkDesc = _selectedtipoUnidadMedida!.tipoDescripcion;


    //
    // GuiasElectronicasDetalleModel test = new GuiasElectronicasDetalleModel();
    // guiaDetalleModel.add(test);

    if(_chipListConductores.length ==0){
      mensajeToast("No hay conductores", Colors.redAccent,Colors.white);
      return;
    }else{
      _chipListConductores.forEach((element){
        GuiasElectronicasConductoresModel mod = new GuiasElectronicasConductoresModel();
        mod.conductoresFk = element.id;
        mod.conductoresFkDesc = element.name;
        guiaConductoresModel.add(mod);
      });
    }

    if(_chipList.length ==0){
      mensajeToast("No hay placas", Colors.redAccent,Colors.white);
      return;
    }else{
      _chipList.forEach((element){
        GuiasElectronicasPlacasModel mod = new GuiasElectronicasPlacasModel();
        if(element.tipo =="VEHICULO"){
          mod.vehiculosFk = element.id;
          if (element.esPrincipal ==true){
            mod.plreEstado = "1";
          }
        }else{
          mod.placasFk = element.id;
        }
        guiaPlacasModel.add(mod);
      });
    }


    print("Camtidad DEtalles: "+productoLista.length.toString() ) ;
    productoLista.forEach((element){
      GuiasElectronicasDetalleModel mod = new GuiasElectronicasDetalleModel();
      mod.productosFk = element.productosFk;
      mod.tipoProductoUnidadMedidaFk = element.tipoProductoUnidadMedidaFk;
      mod.tipoProductoUnidadMedidaFkDesc = element.tipoProductoUnidadMedidaFkDesc;
      mod.gudePrecioUnitario = element.gudePrecioUnitario;
      //mod.gudePesoUnitario = element.gudePesoUnitario;
      mod.gudeMontoTotal= element.gudeMontoTotal;

      guiaDetalleModel.add(mod);
    });

    guiaModel.detalle = guiaDetalleModel;
    guiaModel.detalleConductores = guiaConductoresModel;
    guiaModel.detallePlacas = guiaPlacasModel;

    String s = guiaModel.toJson().toString();
    debugPrint(" =======> " + s, wrapWidth: 1024);

    setState(() {
      loadingSend = true;
    });
    String res =
    await _guiasElectronicasServices.GuiasElectronicas_GrabarGuiaElectronica(guiaModel);

    print(res);
    if (res == "1") {
      // ShowMessage("Pedido generado correctamente.", 1);
      showMessajeAW(DialogType.SUCCES, "Confirmacion",
          "Pedido generado correctamente.", 1);
      // Navigator.pushReplacementNamed(context, 'home',);
    } else {
      // ShowMessage("Ocurrio un error al generar el pedido, revise la informacion.", 0);
      showMessajeAW(DialogType.ERROR, "Error",
          "Ocurrio un error al generar la guia electronica, revise la informacion.", 0);
    }
    loadingSend = false;
    setState(() {});
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

  AutoCompleteTextField<TiposModel> fieldConductor() {
    return AutoCompleteTextField<TiposModel>(
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
        return item.tipoDescripcion!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.tipoDescripcion!.compareTo(b.tipoDescripcion!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchConductor!.textField!.controller!.text = item.tipoDescripcion!;
        //  guiaModel.conductoresRelacionFk = item.id;  //revisar
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowConductor(item);
      },
    );
  }

  AutoCompleteTextField<TiposModel> fieldCliente() {

    return AutoCompleteTextField<TiposModel>(
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
        return item.tipoDescripcion!.toLowerCase().contains(query.toLowerCase()) || item.extraNumero!.toLowerCase().contains(query.toLowerCase()) ;
      },
      itemSorter: (a, b) {
        return a.tipoDescripcion!.compareTo(b.tipoDescripcion!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchCliente!.textField!.controller!.text = item.tipoDescripcion! ;
          guiaModel.clientesFk = item.tipoId;
          guiaModel.clientesFkDesc = item.tipoDescripcion;
          subclientes = [];

          _selectedTipoSubClientes =null;
          //pene 2
          obtenerSubClientes(item.tipoId!);  //12/12/2023
          print("Enviando: "+ item.tipoId!);


          ActualizadoresTipo(1, item.tipoId!); //13/02/2024
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

  AutoCompleteTextField<TiposModel> fieldRemitente() {

    return AutoCompleteTextField<TiposModel>(
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
        return item.tipoDescripcion!.toLowerCase().contains(query.toLowerCase()) || item.extraNumero!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.tipoDescripcion!.compareTo(b.tipoDescripcion!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchRemitente!.textField!.controller!.text = item.tipoDescripcion!;
          guiaModel.clienteRemitenteFk = item.tipoId;
          guiaModel.clienteRemitenteFkDesc = item.tipoDescripcion;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowRemitente(item);
      },
    );
  }

  // AutoCompleteTextField<Destinatario> fieldDestinatario() {
  AutoCompleteTextField<TiposModel> fieldDestinatario() {

    return  AutoCompleteTextField<TiposModel>(
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
        return item.tipoDescripcion!.toLowerCase().contains(query.toLowerCase()) || item.extraNumero!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.tipoDescripcion!.compareTo(b.tipoDescripcion!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchDestinatario!.textField!.controller!.text = item.tipoDescripcion!;
          guiaModel.clienteDestinatarioFk = item.tipoId;
          guiaModel.clienteDestinatarioFkDesc = item.tipoDescripcion;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowDestinatario(item);
      },
    );
  }

  AutoCompleteTextField<TiposModel> fieldPlaca() {
    return AutoCompleteTextField<TiposModel>(
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
        return item.tipoDescripcion!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.tipoDescripcion!.compareTo(b.tipoDescripcion!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchPlaca!.textField!.controller!.text = item.tipoDescripcion!;
          // guiaModel.placa = item.descripcion;
        //  guiaModel.placasRelacionFk = item.id;
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
  //
  // AutoCompleteTextField<PlacaPreferencial> fieldPlacaPreferencial() {
  //   return AutoCompleteTextField<PlacaPreferencial>(
  //     key: keyPlacaPreferencial,
  //     clearOnSubmit: false,
  //     suggestions: placasPreferenciales,
  //     style: TextStyle(color: Colors.black54, fontSize: 16.0),
  //     decoration: InputDecoration(
  //       hintText: "Placa Referencial",
  //       labelText: "Placa Referencial",
  //       hintStyle: TextStyle(color: Colors.black54),
  //       prefixIcon: Container(
  //         padding: EdgeInsets.all(10),
  //         width: 17.0,
  //         height: 17.0,
  //         child: SvgPicture.asset(
  //           "assets/icons/car-parking.svg",
  //           color: Colors.black87.withOpacity(0.6),
  //         ),
  //       ),
  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  //     ),
  //     itemFilter: (item, query) {
  //       return item.descripcion!.toLowerCase().contains(query.toLowerCase());
  //     },
  //     itemSorter: (a, b) {
  //       return a.descripcion!.compareTo(b.descripcion!);
  //     },
  //     itemSubmitted: (item) {
  //       setState(() {
  //         searchPlacaPreferencial!.textField!.controller!.text = item.descripcion!;
  //         guiaModel.placaReferencial = item.descripcion;
  //       });
  //     },
  //     itemBuilder: (context, item) {
  //       // ui for the autocompelete row
  //       return rowPlacaPreferencial(item);
  //     },
  //   );
  // }

  AutoCompleteTextField<TiposModel> fieldTipoSituacion() {
    return AutoCompleteTextField<TiposModel>(
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
        return item.tipoDescripcion!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.tipoDescripcion!.compareTo(b.tipoDescripcion!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchSituacion!.textField!.controller!.text = item.tipoDescripcion!;
          guiaModel.tipoEstadoSituacionFk = item.tipoId;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowTipoSituacion(item);
      },
    );
  }

  AutoCompleteTextField<TiposModel> fieldTipoProducto() {
    return AutoCompleteTextField<TiposModel>(
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
        return item.tipoDescripcion!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.tipoDescripcion!.compareTo(b.tipoDescripcion!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchProducto!.textField!.controller!.text = item.tipoDescripcion!;
          idAddProducto = item.tipoId!;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowTipoProducto(item);
      },
    );
  }

  AutoCompleteTextField<TiposModel> fieldTipoTipos() {
    return AutoCompleteTextField<TiposModel>(
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
        return item.tipoDescripcion!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.tipoDescripcion!.compareTo(b.tipoDescripcion!);
      },
      itemSubmitted: (item) {
        setState(() {
          searchTipoTipos!.textField!.controller!.text = item.tipoDescripcion!;
          //guiaModel.tipoProducto = item.id;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowTipoTipos(item);
      },
    );
  }




  Widget rowConductor(TiposModel conductor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              conductor.tipoDescripcion!,
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
              conductor.extraNumero!,
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
  Widget rowCliente(TiposModel cliente) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              cliente.tipoDescripcion!,
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
              cliente.extraNumero!,
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


  Widget rowRemitente(TiposModel remitente) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              remitente.tipoDescripcion!,
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
              remitente.extraNumero!,
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


  Widget rowDestinatario(TiposModel destinatario) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              destinatario.tipoDescripcion!,
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
              destinatario.extraNumero!,
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

  Widget rowPlaca(TiposModel placa) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              placa.tipoDescripcion!,
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
              placa.tipoDescripcion!,
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

  Widget rowTipoSituacion(TiposModel situacion) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              situacion.tipoDescripcion!,
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
              situacion.tipoDescripcionCorta!,
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

  Widget rowTipoProducto(TiposModel producto) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              producto.tipoDescripcion!,
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
              producto.tipoDescripcionCorta!,  //improvisado
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

  Widget rowTipoTipos(TiposModel tipo) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              tipo.tipoDescripcion!,
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
              tipo.tipoDescripcionCorta!,
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
        firstDate: DateTime.parse(origDate).add(const Duration(days: 0)),
        lastDate: DateTime.parse(origDate));

    if (picked != null)
      setState(() {
        selDate = picked.toString().substring(0, 10);
        print(selDate);
        //  _listViaje(context, viaje);
      });
  }
 Future<Null> _selectSelDate_tras(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: DateTime.parse(selDate_tras),
        firstDate: DateTime.parse(origDate_tras),
        lastDate: DateTime.parse(origDate_tras).add(const Duration(days: 30)));

    if (picked != null)
      setState(() {
        selDate_tras = picked.toString().substring(0, 10);
        print(selDate_tras);
        //  _listViaje(context, viaje);
      });
  }














}
