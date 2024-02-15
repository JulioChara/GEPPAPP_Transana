import 'dart:convert';

ViajeModel viajeFromJson(String str) => ViajeModel.fromJson(json.decode(str));

String viajeToJson(ViajeModel data) => json.encode(data.toJson());

class ViajeModel {
  String? ViajId;
  String? correlativo;
  String? conductor;
  String? vehiculo;
  String? origen;
  String? destino;
  String? kilometraje;
  String? kilometrajeFinal;
  String? saldoInicial;
  String? comentarios;
  String? usercreacion;
  String? fechacreacion;
  String? estado;
  String? mensaje;
  String? resultado;
  String? precinto;
  String? precinto2;

  ViajeModel({
    this.ViajId,
    this.correlativo,
    this.conductor,
    this.vehiculo,
    this.origen,
    this.destino,
    this.kilometraje,
    this.kilometrajeFinal,
    this.saldoInicial,
    this.comentarios,
    this.usercreacion,
    this.fechacreacion,
    this.estado,
    this.mensaje,
    this.resultado,
    this.precinto,
    this.precinto2,
  });

  factory ViajeModel.fromJson(Map<String, dynamic> json) => ViajeModel(
    ViajId: json["ViajId"] ?? "",
    correlativo: json["correlativo"] ?? "",
    conductor: json["conductor"] ?? "",
    vehiculo: json["vehiculo"] ?? "",
    origen: json["origen"] ?? "",
    destino: json["destino"] ?? "",
    kilometraje: json["kilometraje"] ?? "",
    kilometrajeFinal: json["kilometrajeFinal"] ?? "",
    saldoInicial: json["saldoInicial"] ?? "",
    comentarios: json["comentarios"] ?? "",
    fechacreacion: json["fechacreacion"] ?? "",
    usercreacion: json["usercreacion"] ?? "",
    estado: json["estado"] ?? "",
    mensaje: json["mensaje"] ?? "",
    resultado: json["resultado"] ?? "",
    precinto: json["precinto"] ?? "",
    precinto2: json["precinto2"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "ViajId": ViajId,
    "correlativo": correlativo,
    "conductor": conductor,
    "vehiculo": vehiculo,
    "origen": origen,
    "destino": destino,
    "kilometraje": kilometraje,
    "kilometrajeFinal": kilometrajeFinal,
    "saldoInicial": saldoInicial,
    "comentarios": comentarios,
    "fechacreacion": fechacreacion,
    "usercreacion": usercreacion,
    "estado": estado,
    "mensaje": mensaje,
    "resultado": resultado,
    "precinto": precinto,
    "precinto2": precinto2,
  };
}
