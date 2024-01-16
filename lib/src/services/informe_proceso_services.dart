
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/constants/constants.dart';
import 'package:transana_app/src/models/proceso_informe_model.dart';

class InformeProcesoService{


  Future<String> registrarInformeProceso(ProcesoInformeModel model) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    model.idUsuarioAnulado = prefs.getString('idUser');

    // String url = kUrl + "/ProcesarInformeUnidadDetalle";
    // http.Response response = await http.post(
    //   url,

    String url = kUrl + "/ProcesarInformeUnidadDetalle";
    http.Response response = await http.post(Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
      body: jsonEncode({
        "IdCabezera" : model.idCabezera,
        "IdDetalle": model.idDetalle,
        "IdAccion": model.idAccion,
        "ComentarioProcesado": model.comentarioProcesado,
        "IdResponsableProcesado": model.idResponsableProcesado,
        "IdTipoSolucionado": model.IdTipoSolucionado,  // nueva xd
        "ComentarioSolucionado": model.comentarioSolucionado,
        "IdResponsableSolucionado": model.idResponsableSolucionado,
        "ComentarioAnulado": model.comentarioAnulado,
        "IdUsuarioAnulado": model.idUsuarioAnulado,
      }),
    );
    print(jsonEncode(model.toJson()));
    print(response.statusCode);
    if(response.statusCode == 200){
      Map<String, dynamic> myMap = json.decode(response.body);
      print(response.body);
      return myMap["resultado"];
    }

  }


}