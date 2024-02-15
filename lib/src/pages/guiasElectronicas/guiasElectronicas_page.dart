
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transana_app/src/models/guiasElectronicas/guiasElectronicas_model.dart';
import 'package:transana_app/src/services/guiasElectronicas/guiasElectronicas_services.dart';
import 'package:transana_app/src/widgets/menu_widget.dart';
import 'package:transana_app/utils/sp_global.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:transana_app/src/constants/constants.dart';

class GuiasElectronicasPage extends StatefulWidget {

  @override
  State<GuiasElectronicasPage> createState() => _GuiasElectronicasPageState();

}



// const fileName = '/pspdfkit-flutter-quickstart-guide.pdf';
// const fileName = '/archivo.pdf';
// const imageUrl = 'http://192.168.2.92:9091/Service/Service1.svc/Download';

class _GuiasElectronicasPageState extends State<GuiasElectronicasPage> {


  SPGlobal _prefs = SPGlobal();





  var _dataServices = new GuiasElectronicasServices();

  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().add(const Duration(days: 1)).toString().substring(0, 10);

  int Accion = 0;

  TextEditingController inputFieldDateController = new TextEditingController();
  DateTime selectedDate = DateTime.now();
  List<GuiasElectronicasModel> listaModel = [];
  bool isLoading = true;

  double progress = 0;
  bool didDownloadPDF = false;
  String progressString = 'no';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print("Dataaaa");

  }


  getData(){
    isLoading = true;
    _dataServices.GuiasElectronicas_ObtenerListaGeneral("0", initDate, endDate).then((value) {
      listaModel = value;
      //  informeModelList3.addAll(informeModelList2);
      Accion = 0;
      setState(() {
        isLoading = false;
      });
     });
  }

  Future download(Dio dio, String url, String IdGuia, String savePath) async {
    try {
      Response response = await dio.post(
        url,
        data: {
          'Id': IdGuia,
        },
        onReceiveProgress: updateProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) { return status! < 500; }
        ),
      );
      print(savePath);
      var file = File(savePath).openSync(mode: FileMode.write);
      file.writeFromSync(response.data);
      await file.close();

    } catch (e) {
      print(e);
    }
  }
  void updateProgress(done, total) {
    progress = done / total;
    setState(() {
      if (progress >= 1) {
        progressString = '✅ File has finished downloading. Try opening the file.';
        didDownloadPDF = true;
        mensajeToast("Documento Descargado", Colors.green, Colors.white);
      } else {
        progressString = 'Download progress: ' + (progress * 100).toStringAsFixed(0) + '% done.';
      }
    });
  }

  _openAndroidPrivateFile(String ruta) async {
    final result = await OpenFilex.open(ruta);
  }

  existeCheckList() async{
    if(_prefs.usIdPlaca != "0" && _prefs.usIdPlaca != ""){ //cuando existe si podremos crear
      Navigator.pushNamed(context, 'checkListCreate');
    }else {
      showMessajeAWYesNo(DialogType.ERROR, "SIN PLACA","No se selecciono ninguna PLACA, ¿Desea Ingresarlo?", 1);
    }
  }


  showMessajeAWYesNo(DialogType type, String titulo, String desc, int accion) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: type,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_fullscreen_outlined),
      title: titulo,
      descTextStyle: TextStyle(fontSize: 18),
      desc: desc,
      btnCancelText: "No",
      btnOkText: "Si",
      btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {
        switch (accion) {
          case 0:
            {
              // nada
            }
            break;
          case 1:
            {
              Navigator.pushReplacementNamed(
                context,
                'login',
                // 'checkListCreate',
              );
            }
            break;
        }
      },
    ).show();
  }




  void Pruebas(String Id) async {
    try {
      var _guiasElectronicasServices = new GuiasElectronicasServices();
      String a = await _guiasElectronicasServices.DescargarGuiaElectronicaPDF(Id);
    }catch(ex){

    }
  }
  // _launchURL() async {
  //
  //   String FUrl = kUrl + "/Download";
  //   final Uri url = Uri.parse(FUrl);
  //   if (!await launchUrl(url)) {
  //     throw Exception('Could not launch ');
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista Guias Electronicas"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[_prefs.colorA, _prefs.colorB])),
        ),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            color: Colors.white,
            iconSize: 30.0,
            onPressed: () {
              //Navigator.pushNamed(context, 'general');
              Navigator.pushNamed(context, 'guiasElectronicasCreate');

             // existeCheckList();
            },
          )
        ],


      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
      //   tooltip: 'Increment',
      //   onPressed: (){
      //     print("Que riko aprietas kata");
      //     // print(_selectedTipoSubClientes!.scId);
      //   //  _launchURL();
      //    // Pruebas();
      //    // PDF().cachedFromUrl('http://192.168.2.92:9091/Service/Service1.svc/Download');
      //   },
      //   child: const Icon(Icons.add, color: Colors.white, size: 28),
      // ),
      drawer: MenuWidget(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => setState(() {
      //     getData();
      //   }),
      //   tooltip: 'Actualizar',
      //   child: const Icon(Icons.refresh),
      // ),
      body: !isLoading
          ? Column(
        children: <Widget>[


          ListTile(
            onTap: null,
            tileColor: Colors.white54,
            leading: CircleAvatar(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Sunat",style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold) ),
              //  Text(informeModelList2[i].cabNumero!, style: TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),backgroundColor: Colors.blue,
            ),
            // leading: CircleAvatar(
            //   backgroundColor: Colors.transparent,
            // ),
          //  leading: Expanded(child: Text("SUNAT",style: TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.activeBlue),)),
            title: Row(
                children: <Widget>[
                  Expanded(child: Text("Documento",style: TextStyle(fontWeight: FontWeight.bold),)),
                  Expanded(child: Text("Fecha",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                  Expanded(child: Text("Acciones",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.right,)),
                  //Expanded(child: Text("Id")),
                ]
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: listaModel.length,
              itemBuilder: (BuildContext context, int i) {
                return ListTile(
                  // tileColor: miColor,
                    onTap: () {
                      //print(listaModel[i].re!);
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${listaModel[i].gutrSerie}" + "-"+"${listaModel[i].gutrNumero}" ,
                          // "${informeModelList2[i].piFechaApertura}" +
                          //     "-" +
                          //     "${informeModelList2[i].usuarioCreacionDesc}",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 13,
                          ),
                        ),
                        Text(
                          // "${double.parse(informeModelList2[i].usuarioCreacionDesc!).toStringAsFixed(2)}",
                          listaModel[i].gutrFechaEmision!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    // subtitle: Text(informeModelList2[i].fecha!),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                             listaModel[i].clienteRemitenteFkDesc! ,
                          // "aaaaaaaal istaModel[i]. clienteRemiteneeeeeteFk Desc!" ,
                            //   "RESTANTES?",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent
                            ),
                          ),
                        ) ,
                    //Text(
                        //   // "${double.parse(informeModelList2[i].usuarioCreacionDesc!).toStringAsFixed(2)}",
                        //   listaModel[i].fechaCreacion!,
                        //   overflow: TextOverflow.ellipsis,
                        //   maxLines: 1,
                        //   style: const TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.green),
                        // ),

                      ],
                    ),


                    leading: listaModel[i].estadoSunatFk! =="56" ? IconButton(
                      icon: Icon(Icons.check_circle, color: Colors.green, size: 30,),
                      onPressed: () {

                      },
                    ) :IconButton(
                      icon: Icon(Icons.warning_outlined, color: Colors.orangeAccent, size: 30,),
                      onPressed: () {

                      },
                    )
                  ,

                  trailing: Wrap(
                    spacing: 12, // space between two icons
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.download_for_offline,
                            color: Colors.green),
                        // onPressed: didDownloadPDF ? null : () async {
                        onPressed: () async {
                          var tempDir = await getTemporaryDirectory();
                          var imageUrl = kUrl + "/GuiasElectronicas_DescargarPDF";
                          download(Dio(), imageUrl, listaModel[i].gutrId!, tempDir.path +'/'+listaModel[i].gutrSerie! + listaModel[i].gutrNumero!+'.pdf' );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.remove_red_eye_outlined,
                            color: Colors.blue),
                        // onPressed: !didDownloadPDF ? null : () async {
                        onPressed:  () async {
                          var tempDir = await getTemporaryDirectory();
                          //_openAndroidPrivateFile(tempDir.path + fileName);
                          _openAndroidPrivateFile(tempDir.path+'/' +listaModel[i].gutrSerie! + listaModel[i].gutrNumero!+'.pdf' );
                        },
                      ),
                    ],
                  ),

                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0XFF51E2A7),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400, blurRadius: 3)
                      ]),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 7.0,
                        ),
                        Text(
                          initDate,
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                        )
                      ],
                    ),
                    onPressed: () {
                      _selectDateInit(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade400, blurRadius: 3)
                      ]),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.date_range,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 7.0,
                        ),
                        Text(
                          endDate,
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                        )
                      ],
                    ),
                    onPressed: () {
                      _selectDateEnd(context);
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }



  showMensajeriaAW(DialogType tipo, String titulo, String desc) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: tipo,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_fullscreen_outlined),
      title: titulo,
      descTextStyle: TextStyle(fontSize: 18),
      desc: desc,
      //  btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {},
    ).show().then((value) {
      getData();
      setState(() {});
    });
  }


  mensajeToast(String mensaje, Color colorFondo, Color colorText) {
    Fluttertoast.showToast(
        msg: mensaje,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: colorFondo,
        textColor: colorText,
        fontSize: 16.0);
  }

  showMessajeAW(DialogType type, String titulo, String desc, int accion) {
    AwesomeDialog(
      dismissOnTouchOutside: false,
      context: context,
      dialogType: type,
      headerAnimationLoop: false,
      animType: AnimType.TOPSLIDE,
      showCloseIcon: true,
      closeIcon: const Icon(Icons.close_fullscreen_outlined),
      title: titulo,
      descTextStyle: TextStyle(fontSize: 18),
      desc: desc,
      //  btnCancelOnPress: () {},
      onDissmissCallback: (type) {
        debugPrint('Dialog Dissmiss from callback $type');
      },
      btnOkOnPress: () {
        switch (accion) {
          case 0:
            {
              // nada
            }
            break;
          case 1:
            {
              //Cuando se genera el pedido
              Navigator.pushReplacementNamed(
                context,
                'home',
              );
            }
            break;
        }
      },
    ).show();
  }


  Future<Null> _selectDateInit(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: DateTime.parse(initDate),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        initDate = picked.toString().substring(0, 10);
        //_listInforme(context, informe);
        getData();
      });
  }

  Future<Null> _selectDateEnd(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: DateTime.parse(endDate),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        endDate = picked.toString().substring(0, 10);
        //_listInforme(context, informe);
        getData();
      });
  }









}
