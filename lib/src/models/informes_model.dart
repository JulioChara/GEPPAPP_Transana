import 'dart:convert';
import 'package:transana_app/src/models/producto_model.dart';

InformeModel informeFromJson(String str) => InformeModel.fromJson(json.decode(str));

String informeToJson(InformeModel data) => json.encode(data.toJson());


class InformelistaModel {
  String? InunId;
  String? vehiculo;
  String? conductor;
  String? tipoprioridad;
  String? correlativo;
  String? concepto;
  String? tipoestado;
  String? fechacreacion;
  String? usercreacion;
  String? mensaje;
  String? resultado;

  InformelistaModel({
    this.InunId,
    this.vehiculo,
    this.conductor,
    this.tipoprioridad,
    this.correlativo,
    this.concepto,
    this.tipoestado,
    this.fechacreacion,
    this.usercreacion,
    this.mensaje,
    this.resultado,
  });

  factory InformelistaModel.fromJson(Map<String, dynamic> json) => InformelistaModel(
    InunId: json["InunId"] ?? "",
    vehiculo: json["vehiculo"] ?? "",
    conductor: json["conductor"] ?? "",
    tipoprioridad: json["tipoprioridad"] ?? "",
    correlativo: json["correlativo"] ?? "",
    concepto: json["concepto"] ?? "",
    tipoestado: json["tipoestado"] ?? "",
    fechacreacion: json["fechacreacion"] ?? "",
    usercreacion: json["usercreacion"] ?? "",
    mensaje: json["mensaje"] ?? "",
    resultado: json["resultado"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "InunId": InunId,
    "vehiculo": vehiculo,
    "conductor": conductor,
    "tipoprioridad": tipoprioridad,
    "correlativo": correlativo,
    "concepto": concepto,
    "tipoestado": tipoestado,
    "fechacreacion": fechacreacion,
    "usercreacion": usercreacion,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}


class InformeModel {
  String? InunId;
  String? vehiculo;
  String? conductor;
  String? tipoprioridad;
  String? correlativo;
  String? concepto;
  String? tipoestado;
  String? fechacreacion;
  String? usercreacion;
  String? mensaje;
  String? resultado;
  List<ProductoInformes>? Detalle;

  InformeModel({
    this.InunId,
    this.vehiculo,
    this.conductor,
    this.tipoprioridad,
    this.correlativo,
    this.concepto,
    this.tipoestado,
    this.fechacreacion,
    this.usercreacion,
    this.mensaje,
    this.resultado,
    this.Detalle,
  });

  factory InformeModel.fromJson(Map<String, dynamic> json) => InformeModel(
    InunId: json["InunId"] ?? "",
    vehiculo: json["vehiculo"] ?? "",
    conductor: json["conductor"] ?? "",
    tipoprioridad: json["tipoprioridad"] ?? "",
    correlativo: json["correlativo"] ?? "",
    concepto: json["concepto"] ?? "",
    tipoestado: json["tipoestado"] ?? "",
    fechacreacion: json["fechacreacion"] ?? "",
    usercreacion: json["usercreacion"] ?? "",
    mensaje: json["mensaje"] ?? "",
    resultado: json["resultado"] ?? "",
    Detalle: List<ProductoInformes>.from(json["Detalle"]?.map((x) => ProductoInformes.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "InunId": InunId,
    "vehiculo": vehiculo,
    "conductor": conductor,
    "tipoprioridad": tipoprioridad,
    "correlativo": correlativo,
    "concepto": concepto,
    "tipoestado": tipoestado,
    "fechacreacion": fechacreacion,
    "usercreacion": usercreacion,
    "mensaje": mensaje,
    "resultado": resultado,
    "Detalle": List<dynamic>.from(Detalle!.map((x) => x.toJson())),
  };
}
