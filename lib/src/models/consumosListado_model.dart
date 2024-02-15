import 'dart:convert';

consumoModel conusmoFromJson(String str) => consumoModel.fromJson(json.decode(str));

String consumoToJson(consumoModel data) => json.encode(data.toJson());

class consumoModel {
  String? idCompra;
  String? idViaje;
  String? fecha;
  String? documento;
  String? galones;
  String? proveedor;
  String? total;
  String? usercreacion;
  String? mensaje;
  String? resultado;

  consumoModel({
    this.idCompra,
    this.idViaje,
    this.fecha,
    this.documento,
    this.galones,
    this.proveedor,
    this.total,
    this.usercreacion,
    this.mensaje,
    this.resultado,
  });

  factory consumoModel.fromJson(Map<String, dynamic> json) => consumoModel(
    idCompra: json["idCompra"] ?? "",
    idViaje : json["idViaje"] ?? "",
    fecha: json["fecha"] ?? "",
    documento: json["documento"] ?? "",
    galones: json["galones"] ?? "",
    proveedor: json["proveedor"] ?? "",
    total: json["total"] ?? "",
    usercreacion: json["usercreacion"] ?? "",
    mensaje: json["mensaje"] ?? "",
    resultado: json["resultado"] ?? "",

  );

  Map<String, dynamic> toJson() => {
    "idCompra": idCompra,
    "idViaje": idViaje,
    "fecha": fecha,
    "documento": documento,
    "galones": galones,
    "proveedor": proveedor,
    "total": total,
    "usercreacion": usercreacion,
    "mensaje": mensaje,
    "resultado": resultado,

  };
}


class vinculacionModel {
  String? Id;
  String? fecha;
  String? documento;
  String? cantidad;
  String? proveedor;
  String? total;
  String? descripcion;


  vinculacionModel({
    this.Id,
    this.fecha,
    this.documento,
    this.cantidad,
    this.proveedor,
    this.total,
    this.descripcion,
  });

  factory vinculacionModel.fromJson(Map<String, dynamic> json) => vinculacionModel(
    Id: json["Id"] ?? "",
    fecha: json["fecha"] ?? "",
    documento: json["documento"] ?? "",
    cantidad: json["cantidad"] ?? "",
    proveedor: json["proveedor"] ?? "",
    total: json["total"] ?? "",
    descripcion: json["descripcion"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Id": Id,
    "fecha": fecha,
    "documento": documento,
    "cantidad": cantidad,
    "proveedor": proveedor,
    "total": total,
    "descripcion": descripcion,
  };
}
