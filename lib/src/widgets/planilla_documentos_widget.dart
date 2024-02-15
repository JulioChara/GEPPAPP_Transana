



import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:transana_app/src/models/planilla_gastos_model.dart';
import 'package:transana_app/src/services/planilla_gastos_services.dart';

class PlanillaDocumentosWidget extends StatefulWidget {

  String? idViajeW="";
   PlanillaDocumentosWidget({
     this.idViajeW
   });

  @override
  State<PlanillaDocumentosWidget> createState() => _PlanillaDocumentosWidgetState();
}

class _PlanillaDocumentosWidgetState extends State<PlanillaDocumentosWidget> {

  static List<PlanillaDocumentosModel> documentos = []; // Documentos
  static List<DestinosPeajesModel> destinos = []; // destinos

  GlobalKey<AutoCompleteTextFieldState<DestinosPeajesModel>> keyDestinos = new GlobalKey();

  AutoCompleteTextField? searchDestino;
  var objDetailServices = new PlanillaGastosServices();
  String idDocumentoDef = ""; //
  var loading = true;

  String idPeaje = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }

  void getData() async {
    try {


      documentos = await objDetailServices.getPlanillasDocumentos();
      destinos = await objDetailServices.getPeajesDestinos();

      idDocumentoDef = documentos[0].tipoId!;  // para que la lista no empieze en nada

      print("minisisnaDIS");
      print(documentos[0].tipoId);
      print(documentos[0].tipoDescripcion);

      // print(widget.incidenciaGen);
      // print(empleado.length);
      // print(subIncidencias.length);
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }







  @override
  Widget build(BuildContext context) {
    return  !loading ? AlertDialog(

      content: Form(
        // key: formKey,
        child: Container(
          // child: Text("ID VIAJE: "+widget.idViajeW),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("FORMULARIO DE INGRESO"),

                SizedBox(
                  height: 12.0,
                ),
                //com
                DropdownButton(
                  value: idDocumentoDef,
                  isExpanded: true,
                  items: documentos
                      .map(
                        (e) => DropdownMenuItem(
                      child: Text(
                        e.tipoDescripcion!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      value: e.tipoId,
                    ),
                  )
                      .toList(),
                  onChanged: (String? value) {
                    idDocumentoDef = value!;
                    setState(() {});
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(idDocumentoDef),
                idDocumentoDef =="10763" ? Text("Alimentacion New") : Container(),
                idDocumentoDef =="10764" ? Text("Peajes New") : Container(),
                idDocumentoDef =="10765" ? Text("Movilidad New") : Container(),
                Column(
                  // children: widget.idAccion != 3 ?
                 children: [
                    searchDestino = fieldPeajesDestinos(),
                  ] ,
                ),
              ],
            ),
          ),
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancelar",
          ),
        ),
      ],

    ) : Center(child: CircularProgressIndicator());
  }





  AutoCompleteTextField <DestinosPeajesModel> fieldPeajesDestinos() {
    //widget.idAccion != 3 ?
    return AutoCompleteTextField<DestinosPeajesModel>(
      key: keyDestinos,
      clearOnSubmit: false,
      suggestions: destinos,
      style: TextStyle(color: Colors.black54, fontSize: 16.0),
      decoration: InputDecoration(
        hintText: "Destino",
        labelText: "Destino",
        hintStyle: TextStyle(color: Colors.black54),
        prefixIcon: Container(
          padding: EdgeInsets.all(10),
          width: 17.0,
          height: 17.0,
          child: SvgPicture.asset(
            "assets/icons/frame.svg",
            color: Colors.black87.withOpacity(0.6),
          ),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      itemFilter: (item, query) {
        return item.destino!.toLowerCase().contains(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.destino!.compareTo(b.destino!);
      },
      itemSubmitted: (item) {
        print("Obtenemos:"+ item.destino!);
        setState(() {
          print("Obtenemos:"+ item.destino!);
          searchDestino!.textField!.controller!.text = item.destino!;

       //   idPeaje = item.id;
        });
      },
      itemBuilder: (context, item) {
        // ui for the autocompelete row
        return rowDestino(item);
      },
    );

  }

  Widget rowDestino(DestinosPeajesModel peajes) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              peajes.destino!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                // fontSize: 16.0,
                fontSize: 14.0,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: Text(
              peajes.monto!,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.black54,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }








}
