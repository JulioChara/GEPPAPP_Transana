import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/viaje_model.dart';
import 'package:transana_app/src/constants/constants.dart';
import 'package:transana_app/src/models/viajes_documentos/viajes_documentos_model.dart';


class ViajeService {


  Future<List<ViajeModel>> cargarViaje(String initDate, String endDate) async {
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String  idUser =  prefs.getString('idUser')!;

      // var resp = await http.post(kUrl+"/ListadoViajes",
      String url = kUrl + "/ListadoViajes";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'FecIni': initDate, 'FecFin': endDate, 'usr':idUser}));

      var decodeData = json.decode(resp.body);

      final List<ViajeModel> viajes = [];

      decodeData.forEach((viajeMap) {
        final prodTemp = ViajeModel.fromJson(viajeMap);
        viajes.add(prodTemp);
      });
      return viajes;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<String> estadoAnularViaje(String id,String idUser) async {

    try{

      // var resp = await http.post(kUrl+"/AnularViaje",
      String url = kUrl + "/AnularViaje";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'Id': id,
            'usr': idUser,}));

      var decodeData = json.decode(resp.body);

      return decodeData["resultado"];


    }catch(e){
      print(e);
      return "0";
    }

  }



  Future<String> registrarViaje(ViajeModel viaje) async{

    try {

      ViajeModel f = new  ViajeModel();


      print(viaje.toJson());

      // var resp = await http.post(kUrl+"/GenerarViaje",

      String url = kUrl + "/GenerarViaje";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(viaje.toJson()));
      print(jsonEncode(viaje.toJson()));
      var decodeData = json.decode(resp.body);

      print(decodeData["resultado"]);

      return decodeData["resultado"];



    } catch (e) {
      print(e);
      return "0";
    }
  }


  Future<String> finalizarViaje(ViajeModel viaje) async{

    try {

      ViajeModel f = new  ViajeModel();
      print(viaje.toJson());
      // var resp = await http.post(kUrl+"/FinalizarViaje",
      String url = kUrl + "/FinalizarViaje";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(viaje.toJson()));
      print(jsonEncode(viaje.toJson()));
      var decodeData = json.decode(resp.body);

      print(decodeData["resultado"]);

      return decodeData["resultado"];



    } catch (e) {
      print(e);
      return "0";
    }
  }




  Future<List<ViajeDocumentosModel>> getViajeDocumentosList(String initDate, String endDate) async {
    List<ViajeDocumentosModel> viajesDocList = [];

    // String url = kUrl + "/ViajesDocumentos_ListarDocumentos";
    // http.Response response = await http.post(
    //     url,
    String url = kUrl + "/ViajesDocumentos_ListarDocumentos";
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({'FecIni': initDate, 'FecFin': endDate})
    );
    if(response.statusCode == 200){
      List list = jsonDecode(response.body);
      viajesDocList = list.map((e) => ViajeDocumentosModel.fromJson(e)).toList();
      return viajesDocList;
    }
    return viajesDocList;

  }

  Future<List<ViajeDocumentosModel>> getViajeDocumentosRestList() async {
    List<ViajeDocumentosModel> viajesDocList = [];

    // String url = kUrl + "/ViajesDocumentos_ListadoMinimalista";
    // http.Response response = await http.get(
    //   url,
    String url = kUrl + "/ViajesDocumentos_ListadoMinimalista";
    http.Response response = await http.post(Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
    if(response.statusCode == 200){
      List list = jsonDecode(response.body);
      viajesDocList = list.map((e) => ViajeDocumentosModel.fromJson(e)).toList();
      return viajesDocList;
    }
    return viajesDocList;

  }








}
