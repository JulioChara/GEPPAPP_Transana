

class TipoProducto {
  String categoria;
  String descripcion;
  String id;
  String titulo;

  TipoProducto({
    this.categoria,
    this.descripcion,
    this.id,
    this.titulo,
  });

  factory TipoProducto.fromJson(Map<String, dynamic> json) => TipoProducto(
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



class TipoSituacion {
  String categoria;
  String descripcion;
  String id;
  String titulo;

  TipoSituacion({
    this.categoria,
    this.descripcion,
    this.id,
    this.titulo,
  });

  factory TipoSituacion.fromJson(Map<String, dynamic> json) => TipoSituacion(
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


class TipoTipo {
  String categoria;
  String descripcion;
  String id;
  String titulo;

  TipoTipo({
    this.categoria,
    this.descripcion,
    this.id,
    this.titulo,
  });

  factory TipoTipo.fromJson(Map<String, dynamic> json) => TipoTipo(
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


class TipoPrioridad {
  String categoria;
  String descripcion;
  String id;
  String titulo;

  TipoPrioridad({
    this.categoria,
    this.descripcion,
    this.id,
    this.titulo,
  });

  factory TipoPrioridad.fromJson(Map<String, dynamic> json) => TipoPrioridad(
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

class TipoInsidencia {
  String categoria;
  String descripcion;
  String id;
  String titulo;

  TipoInsidencia({
    this.categoria,
    this.descripcion,
    this.id,
    this.titulo,
  });

  factory TipoInsidencia.fromJson(Map<String, dynamic> json) => TipoInsidencia(
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


