import 'dart:convert';

List<Conductor> conductorFromJson(String str) => List<Conductor>.from(json.decode(str).map((x) => Conductor.fromJson(x)));

String conductorToJson(List<Conductor> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Conductor {
  String? direccion;
  String? documento;
  String? id;
  String? razonSocial;
  String? titulo;

  Conductor({
    this.direccion,
    this.documento,
    this.id,
    this.razonSocial,
    this.titulo,
  });

  factory Conductor.fromJson(Map<String, dynamic> json) => Conductor(
    direccion: json["Direccion"] ?? "",
    documento: json["Documento"] ?? "",
    id: json["Id"] ?? "",
    razonSocial: json["RazonSocial"] ?? "",
    titulo: json["Titulo"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Direccion": direccion,
    "Documento": documento,
    "Id": id,
    "RazonSocial": razonSocial,
    "Titulo": titulo,
  };
}


