
import 'dart:convert';

List<PlacaPreferencial> placaFromJson(String str) => List<PlacaPreferencial>.from(json.decode(str).map((x) => PlacaPreferencial.fromJson(x)));

String placaToJson(List<PlacaPreferencial> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlacaPreferencial {
  String? categoria;
  String? descripcion;
  String? id;
  String? titulo;

  PlacaPreferencial({
    this.categoria,
    this.descripcion,
    this.id,
    this.titulo,
  });

  factory PlacaPreferencial.fromJson(Map<String, dynamic> json) => PlacaPreferencial(
    categoria: json["Categoria"] ?? "",
    descripcion: json["Descripcion"] ?? "",
    id: json["Id"] ?? "",
    titulo: json["Titulo"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Categoria": categoria,
    "Descripcion": descripcion,
    "Id": id,
    "Titulo": titulo,
  };
}
