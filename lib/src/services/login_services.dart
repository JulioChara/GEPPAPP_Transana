import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transana_app/src/constants/constants.dart';
import 'package:transana_app/utils/sp_global.dart';


class LoginServices {
  SPGlobal _prefs = SPGlobal();
  Future<String> login(String user, String pwd) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // var resp = await http.post(kUrl + "/LoginApp",
      String url = kUrl + "/LoginApp";
      http.Response resp = await http.post(Uri.parse(url),
          headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
          body: jsonEncode({'usr': user, 'pwd': pwd}));

      print(resp.statusCode);

      var decodeData = json.decode(resp.body);

      var result = decodeData["resultado"];

      print(decodeData);

      if(result == "1"){
        _prefs.isLogin = true;
        _prefs.rolId = decodeData["rolid"];
        _prefs.idUser = decodeData["id"];
        _prefs.usNombre = decodeData["usNombre"];
        _prefs.rolName = decodeData["rolName"];

        ///todo: Nuevas 11/01/2024
        // _prefs.usIdPlaca = IdPlaca;
        // _prefs.usIdPlacaDesc = IdPlacaDesc;
        // _prefs.usIdPlacaRef = IdPlacaRef;
        // _prefs.usIdPlacaRefDesc = IdPlacaRefDesc;

        await prefs.setBool("wasLogin", true);
        await prefs.setString("idUser", decodeData["id"]);
        await prefs.setString("nameUser", user);
        await prefs.setString("rol", decodeData["rol"]);
        await prefs.setString("rolId", decodeData["rolid"]);


        return decodeData["id"];
      }
      else{
        return decodeData["resultado"];
      }


    } catch (e) {
      print(e);
      return "0";
    }
  }
}