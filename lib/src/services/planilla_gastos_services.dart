






import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/constants/constants.dart';
import 'package:transana_app/src/models/empleado_model.dart';
import 'package:transana_app/src/models/planilla_gastos_model.dart';
import 'package:transana_app/src/models/viajes_documentos/viajes_documentos_model.dart';

class PlanillaGastosServices {
  Future<List<PlanillaGastosModel>> getPlanillaGastosDetalles(String ViajeFk) async {
    List<PlanillaGastosModel> informeList = [];
    // String url = kUrl + "/PlanillaGastos_ObtenerDetallesxId";
    // http.Response response = await http.post(
    //   url,
    String url = kUrl + "/PlanillaGastos_ObtenerDetallesxId";
    http.Response response = await http.post(Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "ViajeFk": ViajeFk
        },
      ),
    );
    if(response.statusCode == 200){
      List list = json.decode(response.body);
      informeList = list.map<PlanillaGastosModel>((e) => PlanillaGastosModel.fromJson(e)).toList();
      return informeList;
    }
    return informeList;
  }






  // PlanillaDocumentosModel
  Future<List<PlanillaDocumentosModel>> getPlanillasDocumentos() async {
    List<PlanillaDocumentosModel> informeList = [];
    // String url = kUrl + "/PlanillaGastos_ObtenerTiposDocumentoGastos";
    // http.Response response = await http.get(
    //   url,
    //   headers: {
    //     "Content-Type": "application/json",
    //   },
    // );
    String url = kUrl + "/PlanillaGastos_ObtenerTiposDocumentoGastos";
    http.Response response= await http.get(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
    if(response.statusCode == 200){
      List list = json.decode(response.body);
      informeList = list.map<PlanillaDocumentosModel>((e) => PlanillaDocumentosModel.fromJson(e)).toList();
      return informeList;
    }
    return informeList;
  }

  Future<List<DestinosPeajesModel>> getPeajesDestinos() async {
    List<DestinosPeajesModel> informeList = [];
    // String url = kUrl + "/PlanillaGastos_ObtenerDestinosPeajes";
    // http.Response response = await http.get(
    //   url,
    //   headers: {
    //     "Content-Type": "application/json",
    //   },
    // );
    String url = kUrl + "/PlanillaGastos_ObtenerDestinosPeajes";
    http.Response response= await http.get(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
    if(response.statusCode == 200){
      List list = json.decode(response.body);
      informeList = list.map<DestinosPeajesModel>((e) => DestinosPeajesModel.fromJson(e)).toList();
      return informeList;
    }
    return informeList;
  }



  Future<List<PlanillaComprobantesModel>> getTiposComprobantes() async {
    List<PlanillaComprobantesModel> informeList = [];
    // String url = kUrl + "/PlanillaGastos_ObtenerTiposComprobantes";
    // http.Response response = await http.get(
    //   url,
    //   headers: {
    //     "Content-Type": "application/json",
    //   },
    // );
    String url = kUrl + "/PlanillaGastos_ObtenerTiposComprobantes";
    http.Response response= await http.get(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
    if(response.statusCode == 200){
      List list = json.decode(response.body);
      informeList = list.map<PlanillaComprobantesModel>((e) => PlanillaComprobantesModel.fromJson(e)).toList();
      return informeList;
    }
    return informeList;
  }


  Future<List<PlanillaTipos_Compras_Servicios_Model>> getTiposCompras() async {
    List<PlanillaTipos_Compras_Servicios_Model> informeList = [];
    // String url = kUrl + "/PlanillaGastos_ObtenerTiposCompras";
    // http.Response response = await http.get(
    //   url,
    //   headers: {
    //     "Content-Type": "application/json",
    //   },
    // );
    String url = kUrl + "/PlanillaGastos_ObtenerTiposCompras";
    http.Response response= await http.get(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
    if(response.statusCode == 200){
      List list = json.decode(response.body);
      informeList = list.map<PlanillaTipos_Compras_Servicios_Model>((e) => PlanillaTipos_Compras_Servicios_Model.fromJson(e)).toList();
      return informeList;
    }
    return informeList;
  }


  Future<List<PlanillaTipos_Compras_Servicios_Model>> getTiposServicios() async {
    List<PlanillaTipos_Compras_Servicios_Model> informeList = [];
    // String url = kUrl + "/PlanillaGastos_ObtenerTiposServicios";
    // http.Response response = await http.get(
    //   url,
    //   headers: {
    //     "Content-Type": "application/json",
    //   },
    // );
    String url = kUrl + "/PlanillaGastos_ObtenerTiposServicios";
    http.Response response= await http.get(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
    if(response.statusCode == 200){
      List list = json.decode(response.body);
      informeList = list.map<PlanillaTipos_Compras_Servicios_Model>((e) => PlanillaTipos_Compras_Servicios_Model.fromJson(e)).toList();
      return informeList;
    }
    return informeList;
  }







//PARA GUARDAR PEAJES
  /*
  Future<String> registrarPlanillaPeajes(PlanillaGastosPeajes model) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    model.usuario = prefs.getString('idUser');
    String url = kUrl + "/PlanillaGastos_PeajesAcciones";
    http.Response response = await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({
        "viajeFk" : model.viajeFk,
        "tipoDocGasto" : model.tipoDocGasto,
        "fecha" : model.fecha,
        "concepto" : model.concepto,
        "monto" : model.monto,
        "lugar" :  model.lugar,
        "ruc" : model.ruc,
        "serie" : model.serie,
        "numero" : model.numero,
        "usuario" : model.usuario,
        "idAccion" : "1"
      }),
    );
    print(response.statusCode);
    if(response.statusCode == 200){
      Map<String, dynamic> myMap = json.decode(response.body);
      print(jsonEncode(model.toJson()));
      print(response.body);
      return myMap["resultado"];
    }

  }
*/


  Future<String> AccionesPlanillaPeajes(PlanillaGastosPeajesModel model) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      model.usuario = prefs.getString('idUser');
      print(model.toJson());
      // var resp = await http.post(kUrl+"/PlanillaGastos_PeajesAcciones",
      String url = kUrl + "/PlanillaGastos_PeajesAcciones";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(model.toJson()));
      print(jsonEncode(model.toJson()));

      var decodeData = json.decode(resp.body);
      print(decodeData["resultado"]);
      return decodeData["resultado"];

    } catch (e) {
      print(e);
      return "0";
    }
  }


  // PARA ELIMINAR CUALQUIER REGISTRO

  Future<String> eliminarPlanillaDetalles(PlanillaGastosEliminarModel model) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
   //   print(model.toJson());
   //    var resp = await http.post(kUrl+"/PlanillaGastos_Eliminar",
      String url = kUrl + "/PlanillaGastos_Eliminar";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(model.toJson()));
//      print(jsonEncode(model.toJson()));
      var decodeData = json.decode(resp.body);

      print(decodeData["resultado"]);
      return decodeData["resultado"];

    } catch (e) {
      print(e);
      return "0";
    }
  }




  Future<String> accionesPlanillaAlimentos(PlanillaGastosAlimentosModel model) async{
    try {
      print("PN");
      SharedPreferences prefs = await SharedPreferences.getInstance();
     // model.fecha =
      model.usuario = prefs.getString('idUser');
      print(model.toJson());
      // var resp = await http.post(kUrl+"/PlanillaGastos_AlimentosAcciones",
      String url = kUrl + "/PlanillaGastos_AlimentosAcciones";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(model.toJson()));
      print(jsonEncode(model.toJson()));
      var decodeData = json.decode(resp.body);
      print(decodeData["resultado"]);
      return decodeData["resultado"];
    } catch (e) {

      print(e);
      return "0";
    }
  }






  Future<String> accionesPlanillaEstacionamiento(PlanillaGastosEstacionamientoModel model) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      model.usuario = prefs.getString('idUser');
      print(model.toJson());
      // var resp = await http.post(kUrl+"/PlanillaGastos_EstacionamientoAcciones",
      String url = kUrl + "/PlanillaGastos_EstacionamientoAcciones";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(model.toJson()));
      print(jsonEncode(model.toJson()));
      var decodeData = json.decode(resp.body);
      print(decodeData["resultado"]);
      return decodeData["resultado"];
    } catch (e) {

      print(e);
      return "0";
    }
  }



  Future<String> accionesPlanillaMovilidad(PlanillaGastosMovilidadModel model) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      model.usuario = prefs.getString('idUser');
      //print("Raaaa");
      print(model.toJson());
      // var resp = await http.post(kUrl+"/PlanillaGastos_MovilidadAcciones",
      String url = kUrl + "/PlanillaGastos_MovilidadAcciones";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(model.toJson()));
      print(jsonEncode(model.toJson()));
      var decodeData = json.decode(resp.body);
      print(decodeData["resultado"]);
      return decodeData["resultado"];
    } catch (e) {
      print(e);
      return "0";
    }
  }



  Future<String> accionesPlanillaHospedaje(PlanillaGastosHospedajeModel model) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      model.usuario = prefs.getString('idUser');
      print(model.toJson());
      // var resp = await http.post(kUrl+"/PlanillaGastos_HospedajeAcciones",
      String url = kUrl + "/PlanillaGastos_HospedajeAcciones";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(model.toJson()));
      print(jsonEncode(model.toJson()));
      var decodeData = json.decode(resp.body);
      print(decodeData["resultado"]);
      return decodeData["resultado"];
    } catch (e) {
      print(e);
      return "0";
    }
  }


  Future<String> accionesPlanillaPasajes(PlanillaGastosPasajesModel model) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      model.usuario = prefs.getString('idUser');
      print(model.toJson());
      // var resp = await http.post(kUrl+"/PlanillaGastos_PasajesAcciones",
      String url = kUrl + "/PlanillaGastos_PasajesAcciones";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(model.toJson()));
      print(jsonEncode(model.toJson()));
      var decodeData = json.decode(resp.body);
      print(decodeData["resultado"]);
      return decodeData["resultado"];
    } catch (e) {
      print(e);
      return "0";
    }
  }



  Future<String> accionesPlanillaCompras(PlanillaGastosComprasModel model) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      model.usuario = prefs.getString('idUser');
      print(model.toJson());
      // var resp = await http.post(kUrl+"/PlanillaGastos_ComprasAcciones"
      String url = kUrl + "/PlanillaGastos_ComprasAcciones";
      http.Response resp = await http.post(Uri.parse(url),

          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(model.toJson()));
      print(jsonEncode(model.toJson()));
      var decodeData = json.decode(resp.body);
      print(decodeData["resultado"]);
      return decodeData["resultado"];
    } catch (e) {
      print(e);
      return "0";
    }
  }



  Future<String> accionesPlanillaServicios(PlanillaGastosServiciosModel model) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      model.usuario = prefs.getString('idUser');
      print(model.toJson());
      // var resp = await http.post(kUrl+"/PlanillaGastos_ServiciosAcciones",

      String url = kUrl + "/PlanillaGastos_ServiciosAcciones";
      http.Response resp = await http.post(Uri.parse(url),

          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(model.toJson()));
      print(jsonEncode(model.toJson()));
      var decodeData = json.decode(resp.body);
      print(decodeData["resultado"]);
      return decodeData["resultado"];
    } catch (e) {
      print(e);
      return "0";
    }
  }


////obtener full visor
//   Future<List<PlanillaGastosVisorModel>> getPlanillaGastosVisor(String tipoGasto, String idPlanilla) async{
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       print("Tipo: "+tipoGasto);
//       print("IdPlanilla: "+idPlanilla);
//       var resp = await http.post(kUrl+"/PlanillaGastos_ShowDocumento",
//         headers: {
//           "Content-Type": "application/json",
//         },
//         body: json.encode(
//           {
//             "TipoDocGasto": tipoGasto,
//             "IdPlanilla": idPlanilla
//           },
//         ),
//       );
//    //   print(jsonEncode(model.toJson()));
//       var decodeData = json.decode(resp.body);
//       print(decodeData["resultado"]);
//       return decodeData["resultado"];
//     } catch (e) {
//       print(e);
//     }
//   }

  Future<List<PlanillaGastosVisorModel>> getPlanillaGastosVisor(String tipoGasto, String idPlanilla) async {
    List<PlanillaGastosVisorModel> informeList = [];
    // String url = kUrl + "/PlanillaGastos_ShowDocumento";
    // http.Response response = await http.post(
    //   url,

    String url = kUrl + "/PlanillaGastos_ShowDocumento";
    http.Response response = await http.post(Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "TipoDocGasto": tipoGasto,
          "IdPlanilla": idPlanilla
        },
      ),
    );
    if(response.statusCode == 200){
      List list = json.decode(response.body);
      print(list);
      informeList = list.map<PlanillaGastosVisorModel>((e) => PlanillaGastosVisorModel.fromJson(e)).toList();
      print(informeList);
      return informeList;
    }
    return informeList;
  }



  //Future<List<PlanillaGastosConsultaSunatModel>> getConsultaSunat(String ruc) async {
  Future<PlanillaGastosConsultaSunatModel> getConsultaSunat(String ruc) async {  //NO RETORNA LISTA
    print("Documento a Consultar: " + ruc);
    List<PlanillaGastosConsultaSunatModel> informeList = [];
    // String url = "http://intranet.gepp.pe:8029/Service/Service1.svc/ObtenerValoresRuc";
    // http.Response response = await http.post(
    //   url,

    String url = kUrl + "/http://intranet.gepp.pe:8029/Service/Service1.svc/ObtenerValoresRuc";
    http.Response response = await http.post(Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode(
        {
          "ruc": ruc
        },
      ),
    );
    print("Estado: "+ response.statusCode.toString());
    if(response.statusCode == 200){
      print(response.body); // NO RETORENA UNA LISTA
      return PlanillaGastosConsultaSunatModel.fromJson(json.decode(response.body));
    }
    return PlanillaGastosConsultaSunatModel.fromJson(json.decode(response.body));
  }

  //
  // if (response.statusCode == 200) {
  // // If the call to the server was successful, parse the JSON
  // return Post.fromJson(json.decode(response.body));
  // } else {
  // // If that call was not successful, throw an error.
  // throw Exception('Failed to load post');
  // }
  //



  Future<List<EmpleadoModel>> getEntidadesList() async {
    List<EmpleadoModel> entidadesList = [];

    // String url = kUrl + "/ListadoEntidades";
    // http.Response response = await http.get(
    //   url,
    String url = kUrl + "/ListadoEntidades";
    http.Response response = await http.post(Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
    if(response.statusCode == 200){
      List list = jsonDecode(response.body);
      entidadesList = list.map((e) => EmpleadoModel.fromJson(e)).toList();
      return entidadesList;
    }
    return entidadesList;

  }


//--------------PARA DOCUMENTOS VIAJES ------------------//



  Future<String> accionesViajesDocumentos(ViajeDocumentosModel model) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      model.usuario = prefs.getString('idUser');
      print(model.toJson());
      // var resp = await http.post(kUrl+"/ViajesDocumentos_AccionesDocumento",
      String url = kUrl + "/ViajesDocumentos_AccionesDocumento";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(model.toJson()));
      print(jsonEncode(model.toJson()));
      var decodeData = json.decode(resp.body);
      print(decodeData["resultado"]);
      return decodeData["resultado"];
    } catch (e) {
      print(e);
      return "0";
    }
  }









}
