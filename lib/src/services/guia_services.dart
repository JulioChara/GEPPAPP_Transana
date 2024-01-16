import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:transana_app/src/models/guia_envio_model.dart';
import 'package:transana_app/src/models/guia_model.dart';
import 'package:transana_app/src/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuiaService {


  Future<List<GuiaModel>> cargarGuia(String initDate, String endDate) async {
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String  idUser =  prefs.getString('idUser') ;

      // var resp = await http.post(kUrl+"/ListadoGuias",
      String url = kUrl + "/ListadoGuias";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'FecIni': initDate, 'FecFin': endDate, 'usr':idUser}));

      var decodeData = json.decode(resp.body);

      final List<GuiaModel> guias =[];

      decodeData.forEach((guiaMap) {
        final prodTemp = GuiaModel.fromJson(guiaMap);
        guias.add(prodTemp);
      });
      return guias;
    } catch (e) {
      print(e);
    }
  }

  Future<String> estadoAnularGuia(String id,String idusr) async {

    try{

      // var resp = await http.post(kUrl+"/AnularGuia",
      String url = kUrl + "/AnularGuia";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'Id': id,
          'usr':idusr,
          }));

      var decodeData = json.decode(resp.body);

      return decodeData["resultado"];


    }catch(e){
      print(e);
    }

  }

  Future<String> estadoEnviarSunat(String id) async {

    try{

      // var resp = await http.post(kUrl+"/EnviarSunat",
      String url = kUrl + "/EnviarSunat";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'Id': id,}));

      var decodeData = json.decode(resp.body);

      return decodeData["resultado"];


    }catch(e){
      print(e);
    }

  }


  Future<String> registrarGuia(GuiaEnvioModel guia) async{

    try {

        GuiaEnvioModel f = new  GuiaEnvioModel();

        print("Guia Parametros Json abajito de mi xd");
        print(guia.toJson());

      // var resp = await http.post(kUrl+"/GenerarGuia",
        String url = kUrl + "/GenerarGuia";
        http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(guia.toJson()));

      var decodeData = json.decode(resp.body);

      print(decodeData["resultado"]);

      return decodeData["resultado"];



    } catch (e) {
      print(e);
    }
  }


  Future<List<SubClientesModel>> obtenerSubClientesxCliente(String idCliente) async {
    try {
      String url = kUrl + "/SubClientes_ObtenerSubClientesxCliente";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({'Id': idCliente}));
      print(resp.statusCode);
      var decodeData = json.decode(resp.body);
      final List<SubClientesModel> modelData = [];
      decodeData.forEach((map) {
        final prodTemp = SubClientesModel.fromJson(map);
        modelData.add(prodTemp);
      });
      return modelData;
    } catch (e) {
      print(e);
      return [];
    }
  }



}
