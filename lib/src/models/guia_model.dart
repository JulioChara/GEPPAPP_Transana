import 'dart:convert';

GuiaModel guiaFromJson(String str) => GuiaModel.fromJson(json.decode(str));

String guiaToJson(GuiaModel data) => json.encode(data.toJson());

class GuiaModel {
  String clientes;
  String codigoHash;
  String codigoValidacion;
  String conductores;
  String estadoSunat;
  String estadoSunatFk;
  String fecha;
  String idClientes;
  String idConductores;
  String montoTotal;
  String numero;
  String placa;
  String placaReferencia;
  String puntoLlegada;
  String puntoPartida;
  String serie;
  String tipoServicio;
  String tipoServicioId;
  String tipoSituacion;
  String tipoSituacionFk;
  String id;
  String mensaje;
  String resultado;

  GuiaModel({
    this.clientes,
    this.codigoHash,
    this.codigoValidacion,
    this.conductores,
    this.estadoSunat,
    this.estadoSunatFk,
    this.fecha,
    this.idClientes,
    this.idConductores,
    this.montoTotal,
    this.numero,
    this.placa,
    this.placaReferencia,
    this.puntoLlegada,
    this.puntoPartida,
    this.serie,
    this.tipoServicio,
    this.tipoServicioId,
    this.tipoSituacion,
    this.tipoSituacionFk,
    this.id,
    this.mensaje,
    this.resultado,
  });

  factory GuiaModel.fromJson(Map<String, dynamic> json) => GuiaModel(
    clientes: json["Clientes"] ?? "",
    codigoHash: json["CodigoHash"] ?? "",
    codigoValidacion: json["CodigoValidacion"] ?? "",
    conductores: json["Conductores"] ?? "",
    estadoSunat: json["EstadoSunat"] ?? "",
    estadoSunatFk: json["EstadoSunatFk"] ?? "",
    fecha: json["Fecha"] ?? "",
    idClientes: json["IdClientes"] ?? "",
    idConductores: json["IdConductores"] ?? "",
    montoTotal: json["MontoTotal"] ?? "",
    numero: json["Numero"] ?? "",
    placa: json["Placa"] ?? "",
    placaReferencia: json["PlacaReferencia"] ?? "",
    puntoLlegada: json["PuntoLlegada"] ?? "",
    puntoPartida: json["PuntoPartida"] ?? "",
    serie: json["Serie"] ?? "",
    tipoServicio: json["TipoServicio"] ?? "",
    tipoServicioId: json["TipoServicioId"] ?? "",
    tipoSituacion: json["TipoSituacion"] ?? "",
    tipoSituacionFk: json["TipoSituacionFk"] ?? "",
    id: json["id"] ?? "",
    mensaje: json["mensaje"] ?? "",
    resultado: json["resultado"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "Clientes": clientes,
    "CodigoHash": codigoHash,
    "CodigoValidacion": codigoValidacion,
    "Conductores": conductores,
    "EstadoSunat": estadoSunat,
    "EstadoSunatFk": estadoSunatFk,
    "Fecha": fecha,
    "IdClientes": idClientes,
    "IdConductores": idConductores,
    "MontoTotal": montoTotal,
    "Numero": numero,
    "Placa": placa,
    "PlacaReferencia": placaReferencia,
    "PuntoLlegada": puntoLlegada,
    "PuntoPartida": puntoPartida,
    "Serie": serie,
    "TipoServicio": tipoServicio,
    "TipoServicioId": tipoServicioId,
    "TipoSituacion": tipoSituacion,
    "TipoSituacionFk": tipoSituacionFk,
    "id": id,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}




class SubClientesModel {
  String clientesFk;
  String clientesFkDesc;
  String fechaCreacion;
  String scEstado;
  String scId;
  String subClientesFk;
  String subClientesFkDesc;
  String usuarioCreacion;

  SubClientesModel({
    this.clientesFk,
    this.clientesFkDesc,
    this.fechaCreacion,
    this.scEstado,
    this.scId,
    this.subClientesFk,
    this.subClientesFkDesc,
    this.usuarioCreacion,
  });

  factory SubClientesModel.fromJson(Map<String, dynamic> json) => SubClientesModel(
    clientesFk: json["ClientesFk"],
    clientesFkDesc: json["ClientesFkDesc"],
    fechaCreacion: json["FechaCreacion"],
    scEstado: json["ScEstado"],
    scId: json["ScId"],
    subClientesFk: json["SubClientesFk"],
    subClientesFkDesc: json["SubClientesFkDesc"],
    usuarioCreacion: json["UsuarioCreacion"],
  );

  Map<String, dynamic> toJson() => {
    "ClientesFk": clientesFk,
    "ClientesFkDesc": clientesFkDesc,
    "FechaCreacion": fechaCreacion,
    "ScEstado": scEstado,
    "ScId": scId,
    "SubClientesFk": subClientesFk,
    "SubClientesFkDesc": subClientesFkDesc,
    "UsuarioCreacion": usuarioCreacion,
  };
}
