import 'package:flutter/material.dart';
import 'package:transana_app/src/pages/general_page.dart';
import 'package:transana_app/src/pages/guia_page.dart';
import 'package:transana_app/src/pages/guiasElectronicas/guiasElectronicas_create.dart';
import 'package:transana_app/src/pages/guiasElectronicas/guiasElectronicas_page.dart';
import 'package:transana_app/src/pages/home_page.dart';
import 'package:transana_app/src/pages/informes_page_admin.dart';
import 'package:transana_app/src/pages/login_page.dart';
import 'package:transana_app/src/pages/parametros/parametros_page.dart';
import 'package:transana_app/src/pages/reportes/home_reporte_page.dart';
import 'package:transana_app/src/pages/viajes_page.dart';
import 'package:transana_app/src/pages/viajesCreate_page.dart';
import 'package:transana_app/src/pages/informes_page.dart';
import 'package:transana_app/src/pages/informesCreate_page.dart';
import 'package:transana_app/src/pages/consumosViajes_page.dart';
import 'package:transana_app/src/pages/viajeVinculacion_page.dart';
import 'package:transana_app/src/pages/viajeFinalizar_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:transana_app/src/pages/viajes_planilla_gastos_page.dart';
import 'package:transana_app/utils/sp_global.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SPGlobal prefs = SPGlobal();
  await prefs.initShared();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        title: 'Transana',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: LoginPage(),
        home: PreInit(),
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'), // English
          const Locale('es'), // Hebrew
          const Locale.fromSubtags(languageCode: 'zh'), // Chinese *See Advanced Locales below*
          // ... other locales the app supports
        ],
        routes: {
          'home' :  (BuildContext context) => HomePage(),
          'login':  (BuildContext context) => LoginPage(),
          'guia':  (BuildContext context) => GuiaPage(),
          'general':  (BuildContext context) => GeneralPage(),
          'viajes':  (BuildContext context) => ViajePage(),
          'viajesCreate':  (BuildContext context) => ViajeCreatePage(),
          'informe':  (BuildContext context) => InformePage(),
          'informeAdm':  (BuildContext context) => InformeAdmPage(),
          'informeCreate':  (BuildContext context) => InformeCreatePage(),
          'consumosListado':  (BuildContext context) => ConsumoPage(),
          'vincularviaje':  (BuildContext context) => viajeVinculacionPage(),
          'viajeFinalizar':  (BuildContext context) => viajeFinalizarPage(),

          'reportes':  (BuildContext context) => HomeReportePage(),

          //nuevas para viajes
         // 'test':  (BuildContext context) => AquaEjemplo(),
          'planillaGastos':  (BuildContext context) => PlanillaGastosPage(),
          'InformesHomePage':  (BuildContext context) => InformeAdmPage(),
          //
          'parametros':  (BuildContext context) => ParametrosPage(),


          //todo: GUIAS ELECTRONICAS
          'guiasElectronicasHome':  (BuildContext context) => GuiasElectronicasPage(),
          'guiasElectronicasCreate':  (BuildContext context) => GuiasElectronicasCreatePage(),

        },
      ),
      onTap: (){
        final FocusScopeNode focus =  FocusScope.of(context);
        if(!focus.hasPrimaryFocus){

          focus.unfocus();

        }
      },
    );
  }
}

class PreInit extends StatelessWidget {
  SPGlobal _prefs = SPGlobal();
  @override
  Widget build(BuildContext context) {
    // return _prefs.isLogin ? ((_prefs.rolId == "1"|| _prefs.rolId == "13" )? HomePage(): OfflinePedidosEntregasPage()) : LoginPage();
    // return _prefs.isLogin ? HomePage() : LoginPage();
    return  LoginPage();
    //return  MyHomePage();
    //    return CarpetasPage();
  }
}