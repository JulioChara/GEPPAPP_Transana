import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transana_app/src/constants/constants.dart';
import 'package:transana_app/src/models/incidencias_model.dart';
import 'package:transana_app/src/models/informe_detalle_model.dart';

class InformeDetalleService {

  Future<List<InformeDetalleModel>> getInformeDetalle(String id) async {
    List<InformeDetalleModel> informeDetalleList = [];
    // String url = kUrl + "/ListadoInformesDetalles";
    // http.Response response = await http.post(
    //   url,
    String url = kUrl + "/ListadoInformesDetalles";
    http.Response resp = await http.post(Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({
        "idInun": id,
      }),
    );
    if(resp.statusCode == 200){
      List list = jsonDecode(resp.body);
      informeDetalleList = list.map((e) => InformeDetalleModel.fromJson(e)).toList();
      return informeDetalleList;
    }

    return informeDetalleList;
  }




  Future<List<SubIncidenciasModel>> getIncidenciasDetalles(String id) async {
    List<SubIncidenciasModel> subIncidenciasList = [];
    // String url = kUrl + "/SubIncidencias";
    // http.Response response = await http.post(
    //   url,
    String url = kUrl + "/SubIncidencias";
    http.Response resp = await http.post(Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({
        "idDesc": id,
      }),
    );
    if(resp.statusCode == 200){
      List list = jsonDecode(resp.body);
      subIncidenciasList = list.map((e) => SubIncidenciasModel.fromJson(e)).toList();
      return subIncidenciasList;
    }

    return subIncidenciasList;
  }




  Future<List<InformeDetalleModel>> getInformeDetallesxId(String id) async {
    List<InformeDetalleModel> InformeDetalleList = [];
    // String url = kUrl + "/ListadoInformesDetallesxId";
    // http.Response response = await http.post(
    //   url,
    String url = kUrl + "/ListadoInformesDetallesxId";
    http.Response response = await http.post(Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({
        "idDetalle": id,
      }),
    );
    if(response.statusCode == 200){
      List list = jsonDecode(response.body);
      InformeDetalleList = list.map((e) => InformeDetalleModel.fromJson(e)).toList();
      return InformeDetalleList;
    }

    return InformeDetalleList;
  }





}
