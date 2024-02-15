import 'dart:convert';

List<Cliente> clienteFromJson(String str) => List<Cliente>.from(json.decode(str).map((x) => Cliente.fromJson(x)));

String clienteToJson(List<Cliente> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cliente {
  String? direccion;
  String? documento;
  String? id;
  String? razonSocial;
  String? titulo;

  Cliente({
    this.direccion,
    this.documento,
    this.id,
    this.razonSocial,
    this.titulo,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
    direccion: json["Direccion"] == null ? null : json["Direccion"],
    documento: json["Documento"],
    id: json["Id"],
    razonSocial: json["RazonSocial"],
    titulo: json["Titulo"],
  );

  Map<String, dynamic> toJson() => {
    "Direccion": direccion == null ? null : direccion,
    "Documento": documento,
    "Id": id,
    "RazonSocial": razonSocial,
    "Titulo": titulo
  };
}

class Remitente {
  String? direccion;
  String? documento;
  String? id;
  String? razonSocial;
  String? titulo;

  Remitente({
    this.direccion,
    this.documento,
    this.id,
    this.razonSocial,
    this.titulo,
  });

  factory Remitente.fromJson(Map<String, dynamic> json) => Remitente(
    direccion: json["Direccion"] == null ? null : json["Direccion"],
    documento: json["Documento"],
    id: json["Id"],
    razonSocial: json["RazonSocial"],
    titulo: json["Titulo"],
  );

  Map<String, dynamic> toJson() => {
    "Direccion": direccion == null ? null : direccion,
    "Documento": documento,
    "Id": id,
    "RazonSocial": razonSocial,
    "Titulo": titulo
  };
}

class Destinatario {
  String? direccion;
  String? documento;
  String? id;
  String? razonSocial;
  String? titulo;

  Destinatario({
    this.direccion,
    this.documento,
    this.id,
    this.razonSocial,
    this.titulo,
  });

  factory Destinatario.fromJson(Map<String, dynamic> json) => Destinatario(
    direccion: json["Direccion"] == null ? null : json["Direccion"],
    documento: json["Documento"],
    id: json["Id"],
    razonSocial: json["RazonSocial"],
    titulo: json["Titulo"],
  );

  Map<String, dynamic> toJson() => {
    "Direccion": direccion == null ? null : direccion,
    "Documento": documento,
    "Id": id,
    "RazonSocial": razonSocial,
    "Titulo": titulo
  };
}