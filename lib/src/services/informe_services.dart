import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/models/informes_model.dart';
import 'package:transana_app/src/constants/constants.dart';


class InformeService {


  Future<List<InformelistaModel>> cargarInforme(String initDate, String endDate) async {
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String  idUser =  prefs.getString('idUser')! ;

      // var resp = await http.post(kUrl+"/ListadoInformes",
      String url = kUrl + "/ListadoInformes";
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'FecIni': initDate, 'FecFin': endDate, 'usr':idUser}));

      var decodeData = json.decode(response.body);

      final List<InformelistaModel> informes = [];

      decodeData.forEach((informeMap) {
        final prodTemp = InformelistaModel.fromJson(informeMap);
        informes.add(prodTemp);
      });
      return informes;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<String> estadoAnularInforme(String id,String idUser) async {

    try{
      print(jsonEncode({'Id': id,'usr': idUser,}));
      String url = kUrl + "/AnularInforme";
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode({'Id': id,'usr': idUser,}));

      var decodeData = json.decode(response.body);

      return decodeData["resultado"];


    }catch(e){
      print(e);
      return "0";
    }

  }



  Future<String> registrarInforme(InformeModel informe) async{
    try {
      InformeModel f = new  InformeModel();
      print(informe.toJson());
      String url = kUrl + "/GenerarInforme";
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(informe.toJson()));
      print(jsonEncode(informe.toJson()));
      var decodeData = json.decode(response.body);

      print(decodeData["resultado"]);

      return decodeData["resultado"];



    } catch (e) {
      print(e);
      return "0";
    }
  }


}
