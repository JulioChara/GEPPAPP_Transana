



import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/constants/constants.dart';
import 'package:transana_app/src/models/informes_preventivos/alertas_model.dart';

class ParametrosServices
{



  Future<List<TiposModel>> getTiposEditableList() async {
    List<TiposModel> TiposList = [];

    // String url = kUrl + "/Listado_TiposGeneralesEditable";
    // http.Response response = await http.get(
    //     url,
    //     headers: {
    //       'Content-type': 'application/json',
    //       'Accept': 'application/json'
    //     },

    String url = kUrl + "/Listado_TiposGeneralesEditable";
    http.Response response= await http.get(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });

    //  body: jsonEncode({'FecIni': initDate, 'FecFin': endDate})
   // );
    if(response.statusCode == 200){
      List list = jsonDecode(response.body);
      TiposList = list.map((e) => TiposModel.fromJson(e)).toList();
      return TiposList;
    }
    return TiposList;

  }




  Future<String> accionesParametrosTipos(TiposModel model) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      model.usuario = prefs.getString('idUser');
      print(model.toJson());
      // var resp = await http.post(kUrl+"/Parametros_AccionesTipos",

      String url = kUrl + "/Parametros_AccionesTipos";
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
    }
  }







}



