import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/constants/constants.dart';
import 'package:transana_app/src/models/general_model.dart';
import 'package:transana_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transana_app/src/models/informes_preventivos/vehiculos_model.dart';

class InformePreventivoService {
  Future<List<VehiculosModel>> getVehiculos() async {
    List<VehiculosModel> informeList = [];
    // String url = kUrl + "/ObtenerVehiculos";
    // http.Response response = await http.get(
    //   url,
    //   headers: {
    //     "Content-Type": "application/json",
    //   },
    // );
    String url = kUrl + "/ObtenerVehiculos";
    http.Response response = await http.get(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
    if (response.statusCode == 200) {
      List list = json.decode(response.body);
      informeList =
          list.map<VehiculosModel>((e) => VehiculosModel.fromJson(e)).toList();
      return informeList;
    }
    return informeList;
  }

  Future<List<AlertasListadoModel>> getAlertasListado(String id) async {
    List<AlertasListadoModel> alertasList = [];
    // String url = kUrl + "/ListadoAlertas";
    // http.Response response = await http.post(
    //   url,
    String url = kUrl + "/ListadoAlertas";
    http.Response response = await http.post(Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({
        "id": id,
      }),
    );
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      alertasList = list.map((e) => AlertasListadoModel.fromJson(e)).toList();
      return alertasList;
    }

    return alertasList;
  }

  Future<List<AlertasListadoModel>> getAlertaxId(String tipo, String id) async {
    List<AlertasListadoModel> alertasList = [];
    // String url = kUrl + "/ListadoAlertasxId";
    // http.Response response = await http.post(
    //   url,
    String url = kUrl + "/ListadoAlertasxId";
    http.Response response = await http.post(Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({"tipo": tipo, "id": id}),
    );
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      alertasList = list.map((e) => AlertasListadoModel.fromJson(e)).toList();
      return alertasList;
    }

    return alertasList;
  }

  Future<List<TiposModel>> getAlertasTiposDocumentos() async {
    List<TiposModel> tiposAlertasList = [];
    // String url = kUrl + "/Alertas_ObtenerTiposDocumentos";
    // http.Response response = await http.get(
    //   url,
    String url = kUrl + "/Alertas_ObtenerTiposDocumentos";
    http.Response response= await http.get(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
    if (response.statusCode == 200) {
      List list = json.decode(response.body);
      tiposAlertasList =
          list.map<TiposModel>((e) => TiposModel.fromJson(e)).toList();
      return tiposAlertasList;
    }
    return tiposAlertasList;
  }

  Future<List<TiposModel>> getAlertasTiposMantenimientos() async {
    List<TiposModel> tiposAlertasList = [];
    // String url = kUrl + "/Alertas_ObtenerTiposMantenimientos";
    // http.Response response = await http.get(
    //   url,
    String url = kUrl + "/Alertas_ObtenerTiposMantenimientos";
    http.Response response= await http.get(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        });
    if (response.statusCode == 200) {
      List list = json.decode(response.body);
      tiposAlertasList =
          list.map<TiposModel>((e) => TiposModel.fromJson(e)).toList();
      return tiposAlertasList;
    }
    return tiposAlertasList;
  }

  //////////////////////    SAVE    ///////////////////////

  Future<String> accionesAlertasDocumentos(AlertasDocumentosModel model) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      model.usuario = prefs.getString('idUser');
      print(model.toJson());
      // var resp = await http.post(kUrl + "/Alertas_DocumentoAcciones",
      String url = kUrl + "/Alertas_DocumentoAcciones";
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: jsonEncode(model.toJson()));
      print(jsonEncode(model.toJson()));

      var decodeData = json.decode(response.body);
      print(decodeData["resultado"]);
      return decodeData["resultado"];
    } catch (e) {
      print(e);
      return "0";
    }
  }

  Future<String> accionesAlertasMantenimientos(
      AlertasMantenimientosModel model) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      model.usuario = prefs.getString('idUser');
      print(model.toJson());
      // var resp = await http.post(kUrl + "/Alertas_MantenimientoAcciones",
      String url = kUrl + "/Alertas_MantenimientoAcciones";
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

  //////////////////////////////// UPDATE /////////////////////////
  Future<String> renovarDocumento(AlertasDocumentosModel model) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      model.usuario = prefs.getString('idUser');
      print(model.toJson());
      // var resp = await http.post(kUrl + "/Alertas_RenovarDocumento",
      String url = kUrl + "/Alertas_RenovarDocumento";
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

  Future<String> actualizarKM(AlertasMantenimientosModel model) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      model.usuario = prefs.getString('idUser');
      print(model.toJson());
      // var resp = await http.post(kUrl + "/Alertas_ActualizarKM",
      String url = kUrl + "/Alertas_ActualizarKM";
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

  //
  // Future<String> finalzarAlerta(IdsModel model) async{
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     model.usuario = prefs.getString('idUser');
  //     print(model.toJson());
  //     var resp = await http.post(kUrl+"/Alertas_FinalizarAlerta",
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //         },
  //         body: jsonEncode(model.toJson()));
  //     print(jsonEncode(model.toJson()));
  //
  //     var decodeData = json.decode(resp.body);
  //     print(decodeData["resultado"]);
  //     return decodeData["resultado"];
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<String> finalzarAlerta(IdsModel model) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      model.usuario = prefs.getString('idUser');
      print(model.toJson());
      // final http.Response response = await http.post(kUrl + "/Alertas_FinalizarAlerta",
      String url = kUrl + "/Alertas_FinalizarAlerta";
      http.Response response = await http.post(Uri.parse(url),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(model.toJson()));

      print(response.statusCode);
      if (response.statusCode == 200) {
        var decodeData = json.decode(response.body);
        return decodeData["resultado"];
      } else {
        throw Exception('Album loading failed!');
      }
    } catch (e) {
      print(e);
      return "0";
    }
  }






}
