




import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:transana_app/src/constants/constants.dart';
import 'package:transana_app/src/models/guia_model.dart';
import 'package:transana_app/src/models/guiasElectronicas/guiasElectronicas_model.dart';
import 'package:transana_app/src/models/informes_preventivos/alertas_model.dart';
import 'package:transana_app/utils/sp_global.dart';

class GuiasElectronicasServices {

  SPGlobal _prefs = SPGlobal();




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





  Future<List<TiposModel>> GuiasElectronicas_ObtenerConductores() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerConductores";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => TiposModel.fromJson(e)).toList();
        return tiposList;
      }
      return tiposList;
    } catch (e) {
      print(e);
      return [];
    }
  }



  Future<List<TiposModel>> GuiasElectronicas_ObtenerClientes() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerClientes";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => TiposModel.fromJson(e)).toList();
        return tiposList;
      }
      return tiposList;
    } catch (e) {
      print(e);
      return [];
    }
  }


  Future<List<TiposModel>> GuiasElectronicas_ObtenerPlacasAll() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerPlacasAll";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => TiposModel.fromJson(e)).toList();
        return tiposList;
      }
      return tiposList;
    } catch (e) {
      print(e);
      return [];
    }
  }


  Future<List<TiposModel>> GuiasElectronicas_ObtenerTipoSituacion() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerTipoSituacion";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => TiposModel.fromJson(e)).toList();
        return tiposList;
      }
      return tiposList;
    } catch (e) {
      print(e);
      return [];
    }
  }




  Future<List<TiposModel>> GuiasElectronicas_ObtenerTipoTipos() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerTipoTipos";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => TiposModel.fromJson(e)).toList();
        return tiposList;
      }
      return tiposList;
    } catch (e) {
      print(e);
      return [];
    }
  }



  Future<List<TiposModel>> GuiasElectronicas_ObtenerUbigeoFinal() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerUbigeoFinal";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => TiposModel.fromJson(e)).toList();
        return tiposList;
      }
      return tiposList;
    } catch (e) {
      print(e);
      return [];
    }
  }



  Future<List<TiposModel>> GuiasElectronicas_ObtenerUbigeoFinalPost(String term) async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerUbigeoFinalPost";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({'Text': term,}));

      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => TiposModel.fromJson(e)).toList();
        return tiposList;
      }
      return tiposList;
    } catch (e) {
      print(e);
      return [];
    }
  }



  // todo: OLD

  List<TiposModel> Old_cargarTipoSituacion() {
    List<TiposModel> list = [
      new TiposModel(
          tipoDescripcion: "CONTADO",
          tipoId: "10181"),
          // titulo: "TipoSituacion"),
      new TiposModel(
        //  categoria: "",
          tipoDescripcion: "CREDITO",
          tipoId: "10182"),
       //  titulo: "TipoSituacion"),
    ];

    return list;
  }


  List<TiposModel> Old_cargarTipoProducto() {
    List<TiposModel> list = [
      new TiposModel(
          tipoDescripcionCorta: "",
          tipoDescripcion: "COMBUSTIBLE",
          tipoId: "75"),
         // titulo: "TiposProductos"),
      new TiposModel(
          tipoDescripcionCorta: "",
          tipoDescripcion: "AGUA",
          tipoId: "76"),
         // titulo: "TiposProductos"),
      new TiposModel(
          tipoDescripcionCorta: "",
          tipoDescripcion: "SERVICIO DE CARGA DE AGREGADOS - TOLVA OTROS",
          tipoId: "79"),
         // titulo: "TiposProductos"),
    ];

    return list;
  }



  Future<String> DescargarGuiaElectronicaPDF(String IdGuia) async {
    try {

      String url = kUrl + "/GuiasElectronicas_DescargarPDF";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({'Id': IdGuia}));
      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
      //  tiposList = list.map((e) => TiposModel.fromJson(e)).toList();
        return 'a';
      }
      return 'a';
    } catch (e) {
      print(e);
      return 'a';
    }
  }

  Future<List<GuiasElectronicasModel>> GuiasElectronicas_ObtenerListaGeneral(String id, String FecIni, String FecFin) async {
    List<GuiasElectronicasModel> modelList = [];
    String url = kUrl + "/GuiasElectronicas_ObtenerListaGeneral";
    print("Send Data---------");
    print(id);
    print(FecIni);
    print(FecFin);
    print(_prefs.idUser);
    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({'Id': id,
          "FecIni": FecIni,
          "FecFin": FecFin,
          "idUsuario": _prefs.idUser
        }));
    print(response.statusCode);
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      List list = jsonDecode(response.body);
      modelList = list.map((e) => GuiasElectronicasModel.fromJson(e)).toList();
      return modelList;
    }
    return modelList;
  }


  //
  // Future<String> DescargarGuiaElectronicaPDF() async {
  //   try {
  //
  //     String url = kUrl + "/Download";
  //     http.Response resp = await http.get(Uri.parse(url),
  //         headers: {
  //           'Content-type': 'application/json',
  //           'Accept': 'application/json'
  //         });
  //     if (resp.statusCode == 200) {
  //       List list = jsonDecode(resp.body);
  //       //  tiposList = list.map((e) => TiposModel.fromJson(e)).toList();
  //       return 'a';
  //     }
  //     return 'a';
  //   } catch (e) {
  //     print(e);
  //     return 'a';
  //   }
  // }



  //
  // Future<String> readHello() async {
  //   try {
  //     String url = kUrl + "/Download";
  //     http.Response resp = await http.get(Uri.parse(url),
  //     final file = await http.get(Uri.parse(url); //Line 1
  //     // Read the file.
  //     return await file.readAsString(); //Line 2
  //   } catch (e) {
  //     // If encountering an error, return 0.
  //     return "Can't read";
  //   }
  // }

    //
    //
    // Future<String> DescargarGuiaElectronicaPDF(String url, String fileName, String dir) async {
    //   HttpClient httpClient = new HttpClient();
    //   File file;
    //   String filePath = '';
    //   String myUrl = '';
    //
    //   try {
    //     myUrl = url+'/'+fileName;
    //     var request = await httpClient.getUrl(Uri.parse(myUrl));
    //     var response = await request.close();
    //     if(response.statusCode == 200) {
    //       var bytes = await consolidateHttpClientResponseBytes(response);
    //       filePath = '$dir/$fileName';
    //       file = File(filePath);
    //       await file.writeAsBytes(bytes);
    //     }
    //     else
    //       filePath = 'Error code: '+response.statusCode.toString();
    //   }
    //   catch(ex){
    //     filePath = 'Can not fetch url';
    //   }
    //
    //   return filePath;
    // }
    //

  Future<List<ClientesUbigeoModel>> GuiasElectronicas_ObtenerDireccionesxCliente(String Id) async {
    try {
      List<ClientesUbigeoModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerDireccionesxCliente";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({'Id': Id,}));

      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => ClientesUbigeoModel.fromJson(e)).toList();
        return tiposList;
      }
      return tiposList;
    } catch (e) {
      print(e);
      return [];
    }
  }



  Future<List<TiposModel>> GuiasElectronicas_ObtenerTipoUnidadMedida() async {
    try {
      List<TiposModel> tiposList = [];
      String url = kUrl + "/GuiasElectronicas_ObtenerTipoUnidadMedida";
      http.Response resp = await http.get(Uri.parse(url),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json'
          });
      if (resp.statusCode == 200) {
        List list = jsonDecode(resp.body);
        tiposList = list.map((e) => TiposModel.fromJson(e)).toList();
        return tiposList;
      }
      return tiposList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<String> GuiasElectronicas_GrabarGuiaElectronica(GuiasElectronicasModel model) async {
    try {
  //    print(model.toJson());

      String url = kUrl + "/GuiasElectronicas_GrabarGuiaElectronica";
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


}