
import 'dart:convert';

List<Placa> placaFromJson(String str) => List<Placa>.from(json.decode(str).map((x) => Placa.fromJson(x)));

String placaToJson(List<Placa> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Placa {
  String? categoria;
  String? descripcion;
  String? id;
  String? Serie;
  String? titulo;

  Placa({
    this.categoria,
    this.descripcion,
    this.id,
    this.Serie,
    this.titulo,
  });

  factory Placa.fromJson(Map<String, dynamic> json) => Placa(
    categoria: json["Categoria"] ?? "",
    descripcion: json["Descripcion"] ?? "",
    id: json["Id"] ?? "",
    Serie: json["Serie"] ?? "",
    titulo: json["Titulo"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Categoria": categoria,
    "Descripcion": descripcion,
    "Id": id,
    "Serie": Serie,
    "Titulo": titulo,
  };
}
