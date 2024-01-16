import 'dart:typed_data';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:transana_app/src/models/informes_model.dart';
import 'package:transana_app/src/models/placa_model.dart';
import 'package:transana_app/src/models/reportes/informe_unidad_reporte_model.dart';
import 'package:transana_app/src/services/detail_services.dart';
import 'package:transana_app/src/services/reportes_services.dart';

class InformeUnidadReportePage extends StatefulWidget {
  @override
  _InformeUnidadReportePageState createState() =>
      _InformeUnidadReportePageState();
}

class _InformeUnidadReportePageState extends State<InformeUnidadReportePage> {
  List<InformeUnidadReporteModel> informeList = [];

  ReporteServices reporteServices = ReporteServices();

  var objDetailServices = new DetailServices();
  static List<Placa> placas = new List<Placa>();
  GlobalKey<AutoCompleteTextFieldState<Placa>> keyPlaca = new GlobalKey();
  List<DropdownMenuItem<Placa>> _placaDropdownMenuItems;
  InformeModel informeModel = new InformeModel();
  Placa _selectedPlaca;
  bool loading = true;
  bool isData = true;
  String initDate = DateTime.now().toString().substring(0, 10);
  String endDate = DateTime.now().toString().substring(0, 10);

  void getData() async {
    try {
      placas = await objDetailServices.cargarPlaca();
      _placaDropdownMenuItems = buildDropDownMenuItems(placas);

      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  List<DropdownMenuItem<Placa>> buildDropDownMenuItems(List placas) {
    List<DropdownMenuItem<Placa>> items = List();
    for (Placa placa in placas) {
      items.add(DropdownMenuItem(
        value: placa,
        child: Text(placa.descripcion),
      ));
    }
    return items;
  }

  onChangeDropdownItem(Placa selectedPlaca) {
    informeModel.vehiculo = selectedPlaca.descripcion;
    setState(() {
      _selectedPlaca = selectedPlaca;
      print(_selectedPlaca.descripcion);
    });
  }

  getDataDocumentGenerate() async {
    List<InformeUnidadReporteModel> list = await reporteServices
        .getInformeUnidadReporte(_selectedPlaca.descripcion, initDate, endDate);

    final ByteData bytesLogo = await rootBundle.load('assets/logo.jpg');
    final Uint8List byteListLogo = bytesLogo.buffer.asUint8List();

    pw.Document pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        maxPages: 40,
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Image(
                  pw.MemoryImage(
                    byteListLogo,
                  ),
                  fit: pw.BoxFit.fitHeight,
                  height: 100.0),
            ],
          ),
          pw.SizedBox(
            height: PdfPageFormat.cm * 1.5,
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text("Desde: " + initDate),
              pw.Text("Hasta: " + endDate),
            ],
          ),
          pw.SizedBox(
            height: PdfPageFormat.cm * 1,
          ),
          ...List.generate(
            list.length,
            (index) => pw.Table(
              children: [
                //Cabecera
                pw.TableRow(
                  children: [
                    pw.Table(
                      border: pw.TableBorder(
                        horizontalInside: pw.BorderSide(
                          width: 0.5,
                        ),
                        top: pw.BorderSide(
                          width: 2.0,
                        ),
                        bottom: pw.BorderSide(
                          width: 2.0,
                        ),
                        left: pw.BorderSide(
                          width: 2.0,
                        ),
                        right: pw.BorderSide(
                          width: 2.0,
                        ),
                      ),
                      children: [
                        pw.TableRow(
                          children: [
                            // pw.Text("Placa: ${list[index].placa}"),
                            pw.RichText(
                              text: pw.TextSpan(
                                text: "Placa: ",
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                children: [
                                  pw.TextSpan(
                                    text: list[index].placa,
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.RichText(
                              text: pw.TextSpan(
                                text: "Conductor: ",
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                children: [
                                  pw.TextSpan(
                                    text: list[index].conductor,
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.RichText(
                              text: pw.TextSpan(
                                text: "Prioridad: ",
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                children: [
                                  pw.TextSpan(
                                    text: list[index].idPrioridadDesc,
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.RichText(
                              text: pw.TextSpan(
                                text: "Estado: ",
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                children: [
                                  pw.TextSpan(
                                    text: list[index].idEstadoAtencionDesc,
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.TableRow(
                          children: [
                            pw.RichText(
                              text: pw.TextSpan(
                                text: "Fecha: ",
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                                children: [
                                  pw.TextSpan(
                                    text: list[index].fechaCreacion,
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                //Detalle
                ...List.generate(
                  list[index].detalle.length,
                  (i) => pw.TableRow(
                    children: [
                      pw.Table(
                        children: [
                          pw.TableRow(
                            children: [
                              pw.RichText(
                                text: pw.TextSpan(
                                  text: "Informado: ",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  children: [
                                    pw.TextSpan(
                                      text:
                                          list[index].detalle[i].fechaCreacion,
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.RichText(
                                text: pw.TextSpan(
                                  text: "Descripción Incidencia: ",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  children: [
                                    pw.TextSpan(
                                      text: list[index].detalle[i].descripcion,
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.RichText(
                                text: pw.TextSpan(
                                  text: "Procesado Asignado: ",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  children: [
                                    pw.TextSpan(
                                      text: list[index]
                                                  .detalle[i]
                                                  .idResponsableProcesado ==
                                              "0"
                                          ? "-"
                                          : list[index]
                                              .detalle[i]
                                              .fechaProcesar,
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.RichText(
                                text: pw.TextSpan(
                                  text: "Procesado Descripción: ",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  children: [
                                    pw.TextSpan(
                                      text: list[index]
                                                  .detalle[i]
                                                  .idResponsableProcesado ==
                                              "0"
                                          ? "-"
                                          : list[index]
                                              .detalle[i]
                                              .idResponsableProcesadoDesc,
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.RichText(
                                text: pw.TextSpan(
                                  text: "Solucionado: ",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  children: [
                                    pw.TextSpan(
                                      text: list[index]
                                                  .detalle[i]
                                                  .idResponsableSolucionado ==
                                              "0"
                                          ? "-"
                                          : list[index]
                                              .detalle[i]
                                              .fechaSolucionado,
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.RichText(
                                text: pw.TextSpan(
                                  text: "Solucionado Asignado: ",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  children: [
                                    pw.TextSpan(
                                      text: list[index]
                                              .detalle[i]
                                              .idResponsableSolucionadoDesc
                                              .isEmpty
                                          ? "-"
                                          : list[index]
                                              .detalle[i]
                                              .idResponsableSolucionadoDesc,
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.RichText(
                                text: pw.TextSpan(
                                  text: "Solucionado Categoría: ",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  children: [
                                    pw.TextSpan(
                                      text: list[index]
                                                  .detalle[i]
                                                  .idResponsableSolucionado ==
                                              "0"
                                          ? "-"
                                          : list[index]
                                              .detalle[i]
                                              .idTipoIncidenciaDesc,
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              // pw.Text("Solucionado Descripción:"),

                              pw.RichText(
                                text: pw.TextSpan(
                                  text: "Solucionado Categoría: ",
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  children: [
                                    pw.TextSpan(
                                      text: list[index]
                                              .detalle[i]
                                              .comentarioSolucionado
                                              .isEmpty
                                          ? "-"
                                          : list[index]
                                              .detalle[i]
                                              .comentarioSolucionado,
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          pw.TableRow(
                            children: [
                              pw.Text(
                                  "---------------------------------------"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ).toList()
              ],
            ),
          ),
          // pw.Column(
          //   children: List.generate(
          //     list.length,
          //     (index) => pw.Column(
          //       children: [
          //         pw.Container(
          //           padding: pw.EdgeInsets.all(6.0),
          //           margin: pw.EdgeInsets.symmetric(vertical: 5.0),
          //           decoration: pw.BoxDecoration(
          //             border: pw.Border.all(
          //               color: PdfColors.black,
          //               width: 1.5,
          //             ),
          //           ),
          //           child: pw.Row(
          //             children: [
          //               pw.Column(
          //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
          //                 children: [
          //                   pw.Text("Placa:"),
          //                   pw.Container(
          //                     margin: pw.EdgeInsets.symmetric(vertical: 0.0),
          //                     child: pw.Text("Conductor:"),
          //                   ),
          //                   pw.Text("Prioridad:"),
          //                   pw.Text("Estado:"),
          //                   pw.Text("Fecha:"),
          //                 ],
          //               ),
          //               pw.SizedBox(width: 12.0),
          //               pw.Expanded(
          //                 child: pw.Column(
          //                   crossAxisAlignment: pw.CrossAxisAlignment.start,
          //                   children: [
          //                     pw.Text(list[index].placa ?? "-"),
          //                     pw.Text(
          //                       list[index].conductor ?? "-",
          //                     ),
          //                     pw.Text(list[index].idPrioridadDesc ?? "-"),
          //                     pw.Text(list[index].idEstadoAtencionDesc ?? "-"),
          //                     pw.Text(list[index].fechaCreacion ?? "-"),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //         // pw.Column(
          //         //   children: List.generate(
          //         //     list[index].detalle.length ?? 0,
          //         //         (indexDetalle) => pw.Container(
          //         //       padding: pw.EdgeInsets.all(6.0),
          //         //       margin: pw.EdgeInsets.symmetric(vertical: 5.0),
          //         //       decoration: pw.BoxDecoration(
          //         //         border: pw.Border.all(
          //         //           color: PdfColors.black,
          //         //           width: 1.5,
          //         //         ),
          //         //       ),
          //         //       child: pw.Row(
          //         //         children: [
          //         //           pw.Column(
          //         //             mainAxisSize: pw.MainAxisSize.min,
          //         //             crossAxisAlignment: pw.CrossAxisAlignment.start,
          //         //             children: [
          //         //               pw.Text(
          //         //                 "Informado:",
          //         //               ),
          //         //               pw.Text(
          //         //                 "Descripción Incidencia:",
          //         //               ),
          //         //               pw.Text(
          //         //                 "Procesado:",
          //         //               ),
          //         //               pw.Text(
          //         //                 "Procesado Asignado:",
          //         //               ),
          //         //               pw.Text(
          //         //                 "Procesado Descripción:",
          //         //               ),
          //         //               pw.Text(
          //         //                 "Solucionado:",
          //         //               ),
          //         //               pw.Text(
          //         //                 "Solucionado:",
          //         //               ),
          //         //               pw.Text(
          //         //                 "Solucionado:",
          //         //               ),
          //         //
          //         //             ],
          //         //           ),
          //         //
          //         //         ],
          //         //       ),
          //         //     ),
          //         //   ),
          //         // ),
          //
          //
          //
          //         // pw.Table(
          //         //   children: List.generate(
          //         //     list[index].detalle.length ?? 0,
          //         //     (index) => pw.TableRow(
          //         //       children: [
          //         //         pw.Container(
          //         //           child: pw.Column(
          //         //             children: [
          //         //               pw.Text(
          //         //                 "Informado:",
          //         //               ),
          //         //               pw.Text(
          //         //                 "Descripción Incidencia:",
          //         //               ),
          //         //               pw.Text(
          //         //                 "Procesado:",
          //         //               ),
          //         //               pw.Text(
          //         //                 "Procesado Asignado:",
          //         //               ),
          //         //               pw.Text(
          //         //                 "Procesado Descripción:",
          //         //               ),
          //         //               pw.Text(
          //         //                 "Solucionado:",
          //         //               ),
          //         //               pw.Text(
          //         //                 "Solucionado:",
          //         //               ),
          //         //             ],
          //         //           ),
          //         //         ),
          //         //       ],
          //         //     ),
          //         //   ),
          //         // ),
          //
          //         pw.SizedBox(
          //           height: PdfPageFormat.cm * 1.5,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );

    final bytes = await pdf.save();
    final path = await getApplicationDocumentsDirectory();
    final file = File("${path.path}/example.pdf");
    File pdfx = await file.writeAsBytes(bytes);
    // await OpenFile.open(pdfx.path);
    pdf = pw.Document();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informe de Unidades - Reporte"),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    //AQUA CAMBIOS
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
                                      color: Colors.grey.shade400,
                                      blurRadius: 3)
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
                                      color: Colors.grey.shade400,
                                      blurRadius: 3)
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
                    ),

                    SizedBox(
                      height: 20.0,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: "Placa",
                        prefixIcon: Container(
                          width: 20,
                          height: 40,
                          padding: EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            "assets/icons/car-parking.svg",
                            color: Colors.black54,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      isExpanded: true,
                      value: _selectedPlaca,
                      items: _placaDropdownMenuItems,
                      onChanged: onChangeDropdownItem,
                      elevation: 2,
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                      isDense: true,
                      iconSize: 40.0,
                    ),

                    const SizedBox(
                      height: 12.0,
                    ),
                    !isData
                        ? Text(
                            "No hay data",
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : SizedBox(),
                    const SizedBox(
                      height: 12.0,
                    ),
                    ElevatedButton(
                      onPressed: _selectedPlaca == null
                          ? null
                          : () {
                              getDataDocumentGenerate();

                              // reporteServices
                              //     .getInformeUnidadReporte(
                              //         _selectedPlaca.descripcion,
                              //         initDate,
                              //         endDate)
                              //     .then((value) async {
                              //   informeList = value;
                              //
                              //   if (informeList.isEmpty) {
                              //     isData = false;
                              //     setState(() {});
                              //     return;
                              //   }
                              //
                              //   isData = true;
                              //   setState(() {});
                              //
                              //
                              // });
                            },
                      child: Text(
                        "Generar Reporte",
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Future<Null> _selectDateInit(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: new DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        initDate = picked.toString().substring(0, 10);
        print(initDate);
        //_listViaje(context, viaje);
      });
  }

  Future<Null> _selectDateEnd(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: new DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null)
      setState(() {
        endDate = picked.toString().substring(0, 10);
        print(endDate);
        //  _listViaje(context, viaje);
      });
  }
}
