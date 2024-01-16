import 'dart:convert';

import 'package:transana_app/src/models/producto_model.dart';

GuiaEnvioModel guiaModelFromJson(String str) => GuiaEnvioModel.fromJson(json.decode(str));

String guiaModelToJson(GuiaEnvioModel data) => json.encode(data.toJson());

class GuiaEnvioModel {
  String tipoProducto;
  String tipoSituacion;
  String cliente;
  String remitente;
  String destinatario;
  String conductor;
  String dirPartida;
  String dirLlegada;
  String placa;
  String placaReferencial;
  String usuario;
  String serie;
  String numero;
  String guiaremision;
  String fechaGuia;
  List<Producto> detalle;

  GuiaEnvioModel({
    this.tipoProducto,
    this.tipoSituacion,
    this.cliente,
    this.remitente,
    this.destinatario,
    this.conductor,
    this.dirPartida,
    this.dirLlegada,
    this.placa,
    this.placaReferencial,
    this.usuario,
    this.detalle,
    this.serie,
    this.numero,
    this.guiaremision,
    this.fechaGuia,
  });

  factory GuiaEnvioModel.fromJson(Map<String, dynamic> json) => GuiaEnvioModel(
    tipoProducto: json["TipoProducto"],
    tipoSituacion: json["TipoSituacion"],
    cliente: json["Cliente"],
    remitente: json["Remitente"],
    destinatario: json["Destinatario"],
    conductor: json["Conductor"],
    dirPartida: json["DirPartida"],
    dirLlegada: json["DirLlegada"],
    placa: json["Placa"],
    placaReferencial: json["PlacaReferencial"],
    usuario: json["Usuario"],
    serie: json["serie"],
    numero: json["numero"],
    guiaremision: json["guiaremision"],
    fechaGuia: json["fechaGuia"],
    detalle: List<Producto>.from(json["Detalle"].map((x) => Producto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TipoProducto": tipoProducto,
    "TipoSituacion": tipoSituacion,
    "Cliente": cliente,
    "Remitente": remitente,
    "Destinatario": destinatario,
    "Conductor": conductor,
    "DirPartida": dirPartida,
    "DirLlegada": dirLlegada,
    "Placa": placa,
    "PlacaReferencial": placaReferencial,
    "Usuario": usuario,
    "serie": serie,
    "numero": numero,
    "guiaremision": guiaremision,
    "fechaGuia": fechaGuia,
    "Detalle": List<dynamic>.from(detalle.map((x) => x.toJson())),
  };
}

