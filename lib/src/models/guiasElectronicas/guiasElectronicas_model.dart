



import 'dart:convert';


class GuiasElectronicasModel {
  String? gutrId;
  String? empresasFk;
  String? tipoGuiaFk;
  String? tipoGuiaFkDesc;
  String? unidadMedidaFk;
  String? unidadMedidaFkDesc;
  String? clientesFk;
  String? clientesFkDesc;
  String? transportistasFk;
  String? transportistasFkDesc;
  String? clienteRemitenteFk;
  String? clienteRemitenteFkDesc;
  String? clienteDestinatarioFk;
  String? clienteDestinatarioFkDesc;
  String? proveedorFk;
  String? proveedorFkDesc;
  String? compradorFk;
  String? compradorFkDesc;
  String? tipoServicioFk;
  String? tipoServicioFkDesc;
  String? tipoEstadoSituacionFk;
  String? tipoEstadoSituacionFkDesc;
  String? gutrPuntoLlegada;
  String? gutrPuntoLlegadaUbigeo;
  String? gutrPuntoPartida;
  String? gutrPuntoPartidaUbigeo;
  String? gutrGuiaRemision;
  String? gutrSerie;
  String? gutrNumero;
  String? gutrPesoTotal;
  String? gutrMontoTotal;
  String? gutrEstado;
  String? gutrObservaciones;
  String? gutrFechaEmision;
  String? gutrFechaTraslado;
  String? guirFechaRegistro;
  String? gutrFecCreacion;
  String? gutrUsrCreacion;
  String? gutrFecModificacion;
  String? gutrUsrModificacion;
  String? gutrMotivoAnulacion;
  String? codigoAnterior;
  String? estadoSunatFk;
  String? estadoSunatFkDesc;
  String? gutrTicketSunat;
  String? gutrCodigoValidacionSunat;
  String? gutrCodigoHash;
  List<GuiasElectronicasDetalleModel>? detalle;
  List<GuiasElectronicasConductoresModel>? detalleConductores;
  List<GuiasElectronicasPlacasModel>? detallePlacas;

  GuiasElectronicasModel({
    this.gutrId,
    this.empresasFk,
    this.tipoGuiaFk,
    this.tipoGuiaFkDesc,
    this.unidadMedidaFk,
    this.unidadMedidaFkDesc,
    this.clientesFk,
    this.clientesFkDesc,
    this.transportistasFk,
    this.transportistasFkDesc,
    this.clienteRemitenteFk,
    this.clienteRemitenteFkDesc,
    this.clienteDestinatarioFk,
    this.clienteDestinatarioFkDesc,
    this.proveedorFk,
    this.proveedorFkDesc,
    this.compradorFk,
    this.compradorFkDesc,
    this.tipoServicioFk,
    this.tipoServicioFkDesc,
    this.tipoEstadoSituacionFk,
    this.tipoEstadoSituacionFkDesc,
    this.gutrPuntoLlegada,
    this.gutrPuntoLlegadaUbigeo,
    this.gutrPuntoPartida,
    this.gutrPuntoPartidaUbigeo,
    this.gutrGuiaRemision,
    this.gutrSerie,
    this.gutrNumero,
    this.gutrPesoTotal,
    this.gutrMontoTotal,
    this.gutrEstado,
    this.gutrObservaciones,
    this.gutrFechaEmision,
    this.gutrFechaTraslado,
    this.guirFechaRegistro,
    this.gutrFecCreacion,
    this.gutrUsrCreacion,
    this.gutrFecModificacion,
    this.gutrUsrModificacion,
    this.gutrMotivoAnulacion,
    this.codigoAnterior,
    this.estadoSunatFk,
    this.estadoSunatFkDesc,
    this.gutrTicketSunat,
    this.gutrCodigoValidacionSunat,
    this.gutrCodigoHash,
    this.detalle,
    this.detalleConductores,
    this.detallePlacas,
  });

  factory GuiasElectronicasModel.fromJson(Map<String, dynamic> json) => GuiasElectronicasModel(
    gutrId: json["GutrId"],
    empresasFk: json["EmpresasFk"],
    tipoGuiaFk: json["TipoGuiaFk"],
    tipoGuiaFkDesc: json["TipoGuiaFkDesc"],
    unidadMedidaFk: json["UnidadMedidaFk"],
    unidadMedidaFkDesc: json["UnidadMedidaFkDesc"],
    clientesFk: json["ClientesFk"],
    clientesFkDesc: json["ClientesFkDesc"],
    transportistasFk: json["TransportistasFk"],
    transportistasFkDesc: json["TransportistasFkDesc"],
    clienteRemitenteFk: json["ClienteRemitenteFk"],
    clienteRemitenteFkDesc: json["ClienteRemitenteFkDesc"],
    clienteDestinatarioFk: json["ClienteDestinatarioFk"],
    clienteDestinatarioFkDesc: json["ClienteDestinatarioFkDesc"],
    proveedorFk: json["ProveedorFk"],
    proveedorFkDesc: json["ProveedorFkDesc"],
    compradorFk: json["CompradorFk"],
    compradorFkDesc: json["CompradorFkDesc"],
    tipoServicioFk: json["TipoServicioFk"],
    tipoServicioFkDesc: json["TipoServicioFkDesc"],
    tipoEstadoSituacionFk: json["TipoEstadoSituacionFk"],
    tipoEstadoSituacionFkDesc: json["TipoEstadoSituacionFkDesc"],
    gutrPuntoLlegada: json["GutrPuntoLlegada"],
    gutrPuntoLlegadaUbigeo: json["GutrPuntoLlegadaUbigeo"],
    gutrPuntoPartida: json["GutrPuntoPartida"],
    gutrPuntoPartidaUbigeo: json["GutrPuntoPartidaUbigeo"],
    gutrGuiaRemision: json["GutrGuiaRemision"],
    gutrSerie: json["GutrSerie"],
    gutrNumero: json["GutrNumero"],
    gutrPesoTotal: json["GutrPesoTotal"],
    gutrMontoTotal: json["GutrMontoTotal"],
    gutrEstado: json["GutrEstado"],
    gutrObservaciones: json["GutrObservaciones"],
    gutrFechaEmision: json["GutrFechaEmision"],
    gutrFechaTraslado: json["GutrFechaTraslado"],
    guirFechaRegistro: json["GuirFechaRegistro"],
    gutrFecCreacion: json["GutrFecCreacion"],
    gutrUsrCreacion: json["GutrUsrCreacion"],
    gutrFecModificacion: json["GutrFecModificacion"],
    gutrUsrModificacion: json["GutrUsrModificacion"],
    gutrMotivoAnulacion: json["GutrMotivoAnulacion"],
    codigoAnterior: json["CodigoAnterior"],
    estadoSunatFk: json["EstadoSunatFk"],
    estadoSunatFkDesc: json["EstadoSunatFkDesc"],
    gutrTicketSunat: json["GutrTicketSunat"],
    gutrCodigoValidacionSunat: json["GutrCodigoValidacionSunat"],
    gutrCodigoHash: json["GutrCodigoHash"],
    detalle: List<GuiasElectronicasDetalleModel>.from(json["Detalle"]?.map((x) => GuiasElectronicasDetalleModel.fromJson(x))),
    detalleConductores: List<GuiasElectronicasConductoresModel>.from(json["DetalleConductores"]?.map((x) => GuiasElectronicasConductoresModel.fromJson(x))),
    detallePlacas: List<GuiasElectronicasPlacasModel>.from(json["DetallePlacas"]?.map((x) => GuiasElectronicasPlacasModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "GutrId": gutrId,
    "EmpresasFk": empresasFk,
    "TipoGuiaFk": tipoGuiaFk,
    "TipoGuiaFkDesc": tipoGuiaFkDesc,
    "UnidadMedidaFk": unidadMedidaFk,
    "UnidadMedidaFkDesc": unidadMedidaFkDesc,
    "ClientesFk": clientesFk,
    "ClientesFkDesc": clientesFkDesc,
    "TransportistasFk": transportistasFk,
    "TransportistasFkDesc": transportistasFkDesc,
    "ClienteRemitenteFk": clienteRemitenteFk,
    "ClienteRemitenteFkDesc": clienteRemitenteFkDesc,
    "ClienteDestinatarioFk": clienteDestinatarioFk,
    "ClienteDestinatarioFkDesc": clienteDestinatarioFkDesc,
    "ProveedorFk": proveedorFk,
    "ProveedorFkDesc": proveedorFkDesc,
    "CompradorFk": compradorFk,
    "CompradorFkDesc": compradorFkDesc,
    "TipoServicioFk": tipoServicioFk,
    "TipoServicioFkDesc": tipoServicioFkDesc,
    "TipoEstadoSituacionFk": tipoEstadoSituacionFk,
    "TipoEstadoSituacionFkDesc": tipoEstadoSituacionFkDesc,
    "GutrPuntoLlegada": gutrPuntoLlegada,
    "GutrPuntoLlegadaUbigeo": gutrPuntoLlegadaUbigeo,
    "GutrPuntoPartida": gutrPuntoPartida,
    "GutrPuntoPartidaUbigeo": gutrPuntoPartidaUbigeo,
    "GutrGuiaRemision": gutrGuiaRemision,
    "GutrSerie": gutrSerie,
    "GutrNumero": gutrNumero,
    "GutrPesoTotal": gutrPesoTotal,
    "GutrMontoTotal": gutrMontoTotal,
    "GutrEstado": gutrEstado,
    "GutrObservaciones": gutrObservaciones,
    "GutrFechaEmision": gutrFechaEmision,
    "GutrFechaTraslado": gutrFechaTraslado,
    "GuirFechaRegistro": guirFechaRegistro,
    "GutrFecCreacion": gutrFecCreacion,
    "GutrUsrCreacion": gutrUsrCreacion,
    "GutrFecModificacion": gutrFecModificacion,
    "GutrUsrModificacion": gutrUsrModificacion,
    "GutrMotivoAnulacion": gutrMotivoAnulacion,
    "CodigoAnterior": codigoAnterior,
    "EstadoSunatFk": estadoSunatFk,
    "EstadoSunatFkDesc": estadoSunatFkDesc,
    "GutrTicketSunat": gutrTicketSunat,
    "GutrCodigoValidacionSunat": gutrCodigoValidacionSunat,
    "GutrCodigoHash": gutrCodigoHash,
    "Detalle": List<dynamic>.from(detalle!.map((x) => x.toJson())),
    "DetalleConductores": List<dynamic>.from(detalleConductores!.map((x) => x.toJson())),
    "DetallePlacas": List<dynamic>.from(detallePlacas!.map((x) => x.toJson())),
  };
}

class GuiasElectronicasDetalleModel {
  String? gudeId;
  String? empresasFk;
  String? guiaTransportistasElectronicaFk;
  String? productosFk;
  String? productosFkDesc;
  String? tipoProductoFk;
  String? tipoProductoFkDesc;
  String? tipoProductoUnidadMedidaFk;
  String? tipoProductoUnidadMedidaFkDesc;
  String? gudeItem;
  String? gudeProductoDescripcion;
  String? gudeCantidad;
  String? gudePrecioUnitario;
  String? gudePesoUnitario;
  String? gudeMontoTotal;
  String? gudePesoTotal;
  String? gudeFecCreacion;
  String? gudeUsrCreacion;
  String? gudeFecModificacion;
  String? gudeUsrModificacion;
  String? subProductoFk;
  GuiasElectronicasDetalleModel({
    this.gudeId,
    this.empresasFk,
    this.guiaTransportistasElectronicaFk,
    this.productosFk,
    this.productosFkDesc,
    this.tipoProductoFk,
    this.tipoProductoFkDesc,
    this.tipoProductoUnidadMedidaFk,
    this.tipoProductoUnidadMedidaFkDesc,
    this.gudeItem,
    this.gudeProductoDescripcion,
    this.gudeCantidad,
    this.gudePrecioUnitario,
    this.gudePesoUnitario,
    this.gudeMontoTotal,
    this.gudePesoTotal,
    this.gudeFecCreacion,
    this.gudeUsrCreacion,
    this.gudeFecModificacion,
    this.gudeUsrModificacion,
    this.subProductoFk,
  });

  factory GuiasElectronicasDetalleModel.fromJson(Map<String, dynamic> json) => GuiasElectronicasDetalleModel(
    gudeId: json["GudeId"],
    empresasFk: json["EmpresasFk"],
    guiaTransportistasElectronicaFk: json["GuiaTransportistasElectronicaFk"],
    productosFk: json["ProductosFk"],
    productosFkDesc: json["ProductosFkDesc"],
    tipoProductoFk: json["TipoProductoFk"],
    tipoProductoFkDesc: json["TipoProductoFkDesc"],
    tipoProductoUnidadMedidaFk: json["TipoProductoUnidadMedidaFk"],
    tipoProductoUnidadMedidaFkDesc: json["TipoProductoUnidadMedidaFkDesc"],
    gudeItem: json["GudeItem"],
    gudeProductoDescripcion: json["GudeProductoDescripcion"],
    gudeCantidad: json["GudeCantidad"],
    gudePrecioUnitario: json["GudePrecioUnitario"],
    gudePesoUnitario: json["GudePesoUnitario"],
    gudeMontoTotal: json["GudeMontoTotal"],
    gudePesoTotal: json["GudePesoTotal"],
    gudeFecCreacion: json["GudeFecCreacion"],
    gudeUsrCreacion: json["GudeUsrCreacion"],
    gudeFecModificacion: json["GudeFecModificacion"],
    gudeUsrModificacion: json["GudeUsrModificacion"],
    subProductoFk: json["SubProductoFk"],
  );

  Map<String, dynamic> toJson() => {
    "GudeId": gudeId,
    "EmpresasFk": empresasFk,
    "GuiaTransportistasElectronicaFk": guiaTransportistasElectronicaFk,
    "ProductosFk": productosFk,
    "ProductosFkDesc": productosFkDesc,
    "TipoProductoFk": tipoProductoFk,
    "TipoProductoFkDesc": tipoProductoFkDesc,
    "TipoProductoUnidadMedidaFk": tipoProductoUnidadMedidaFk,
    "TipoProductoUnidadMedidaFkDesc": tipoProductoUnidadMedidaFkDesc,
    "GudeItem": gudeItem,
    "GudeProductoDescripcion": gudeProductoDescripcion,
    "GudeCantidad": gudeCantidad,
    "GudePrecioUnitario": gudePrecioUnitario,
    "GudePesoUnitario": gudePesoUnitario,
    "GudeMontoTotal": gudeMontoTotal,
    "GudePesoTotal": gudePesoTotal,
    "GudeFecCreacion": gudeFecCreacion,
    "GudeUsrCreacion": gudeUsrCreacion,
    "GudeFecModificacion": gudeFecModificacion,
    "GudeUsrModificacion": gudeUsrModificacion,
    "SubProductoFk": subProductoFk,
  };
}

class GuiasElectronicasConductoresModel {
  String? coreId;
  String? conductoresFk;
  String? conductoresFkDesc;
  String? guiaTransportistaElectronicaFk;
  String? coreEstado;
  String? coreFecCreacion;
  String? coreUsrCreacion;
  String? coreFecModificacion;
  String? coreUsrModificacion;

  GuiasElectronicasConductoresModel({
    this.coreId,
    this.conductoresFk,
    this.conductoresFkDesc,
    this.guiaTransportistaElectronicaFk,
    this.coreEstado,
    this.coreFecCreacion,
    this.coreUsrCreacion,
    this.coreFecModificacion,
    this.coreUsrModificacion,
  });

  factory GuiasElectronicasConductoresModel.fromJson(Map<String, dynamic> json) => GuiasElectronicasConductoresModel(
    coreId: json["CoreId"],
    conductoresFk: json["ConductoresFk"],
    conductoresFkDesc: json["ConductoresFkDesc"],
    guiaTransportistaElectronicaFk: json["GuiaTransportistaElectronicaFk"],
    coreEstado: json["CoreEstado"],
    coreFecCreacion: json["CoreFecCreacion"],
    coreUsrCreacion: json["CoreUsrCreacion"],
    coreFecModificacion: json["CoreFecModificacion"],
    coreUsrModificacion: json["CoreUsrModificacion"],
  );

  Map<String, dynamic> toJson() => {
    "CoreId": coreId,
    "ConductoresFk": conductoresFk,
    "ConductoresFkDesc": conductoresFkDesc,
    "GuiaTransportistaElectronicaFk": guiaTransportistaElectronicaFk,
    "CoreEstado": coreEstado,
    "CoreFecCreacion": coreFecCreacion,
    "CoreUsrCreacion": coreUsrCreacion,
    "CoreFecModificacion": coreFecModificacion,
    "CoreUsrModificacion": coreUsrModificacion,
  };
}

class GuiasElectronicasPlacasModel {
  String? plreId;
  String? vehiculosFk;
  String? vehiculosFkDesc;
  String? placasFk;
  String? placasFkDesc;
  String? guiaTransportistasElectronicaFk;
  String? plreEstado;
  String? plreFecCreacion;
  String? plreUsrCreacion;
  String? plreFecModificacion;
  String? preUsrModificacion;

  GuiasElectronicasPlacasModel({
    this.plreId,
    this.vehiculosFk,
    this.vehiculosFkDesc,
    this.placasFk,
    this.placasFkDesc,
    this.guiaTransportistasElectronicaFk,
    this.plreEstado,
    this.plreFecCreacion,
    this.plreUsrCreacion,
    this.plreFecModificacion,
    this.preUsrModificacion,
  });

  factory GuiasElectronicasPlacasModel.fromJson(Map<String, dynamic> json) => GuiasElectronicasPlacasModel(
    plreId: json["PlreId"],
    vehiculosFk: json["VehiculosFk"],
    vehiculosFkDesc: json["VehiculosFkDesc"],
    placasFk: json["PlacasFk"],
    placasFkDesc: json["PlacasFkDesc"],
    guiaTransportistasElectronicaFk: json["GuiaTransportistasElectronicaFk"],
    plreEstado: json["PlreEstado"],
    plreFecCreacion: json["PlreFecCreacion"],
    plreUsrCreacion: json["PlreUsrCreacion"],
    plreFecModificacion: json["PlreFecModificacion"],
    preUsrModificacion: json["PreUsrModificacion"],
  );

  Map<String, dynamic> toJson() => {
    "PlreId": plreId,
    "VehiculosFk": vehiculosFk,
    "VehiculosFkDesc": vehiculosFkDesc,
    "PlacasFk": placasFk,
    "PlacasFkDesc": placasFkDesc,
    "GuiaTransportistasElectronicaFk": guiaTransportistasElectronicaFk,
    "PlreEstado": plreEstado,
    "PlreFecCreacion": plreFecCreacion,
    "PlreUsrCreacion": plreUsrCreacion,
    "PlreFecModificacion": plreFecModificacion,
    "PreUsrModificacion": preUsrModificacion,
  };
}










class ClientesUbigeoModel {
  String? clientesFk;
  String? clientesFkDesc;
  String? clubDireccionLlegada;
  String? clubDireccionPartida;
  String? clubEstado;
  String? clubFecCreacion;
  String? clubFecModificacion;
  String? clubId;
  String? clubUsrCreacion;
  String? clubUsrModificacion;
  String? ubigeoLlegadaFk;
  String? ubigeoLlegadaFkDesc;
  String? ubigeoPartidaFk;
  String? ubigeoPartidaFkDesc;

  ClientesUbigeoModel({
    this.clientesFk,
    this.clientesFkDesc,
    this.clubDireccionLlegada,
    this.clubDireccionPartida,
    this.clubEstado,
    this.clubFecCreacion,
    this.clubFecModificacion,
    this.clubId,
    this.clubUsrCreacion,
    this.clubUsrModificacion,
    this.ubigeoLlegadaFk,
    this.ubigeoLlegadaFkDesc,
    this.ubigeoPartidaFk,
    this.ubigeoPartidaFkDesc,
  });

  factory ClientesUbigeoModel.fromJson(Map<String, dynamic> json) => ClientesUbigeoModel(
    clientesFk: json["ClientesFk"],
    clientesFkDesc: json["ClientesFkDesc"],
    clubDireccionLlegada: json["ClubDireccionLlegada"],
    clubDireccionPartida: json["ClubDireccionPartida"],
    clubEstado: json["ClubEstado"],
    clubFecCreacion: json["ClubFecCreacion"],
    clubFecModificacion: json["ClubFecModificacion"],
    clubId: json["ClubId"],
    clubUsrCreacion: json["ClubUsrCreacion"],
    clubUsrModificacion: json["ClubUsrModificacion"],
    ubigeoLlegadaFk: json["UbigeoLlegadaFk"],
    ubigeoLlegadaFkDesc: json["UbigeoLlegadaFkDesc"],
    ubigeoPartidaFk: json["UbigeoPartidaFk"],
    ubigeoPartidaFkDesc: json["UbigeoPartidaFkDesc"],
  );

  Map<String, dynamic> toJson() => {
    "ClientesFk": clientesFk,
    "ClientesFkDesc": clientesFkDesc,
    "ClubDireccionLlegada": clubDireccionLlegada,
    "ClubDireccionPartida": clubDireccionPartida,
    "ClubEstado": clubEstado,
    "ClubFecCreacion": clubFecCreacion,
    "ClubFecModificacion": clubFecModificacion,
    "ClubId": clubId,
    "ClubUsrCreacion": clubUsrCreacion,
    "ClubUsrModificacion": clubUsrModificacion,
    "UbigeoLlegadaFk": ubigeoLlegadaFk,
    "UbigeoLlegadaFkDesc": ubigeoLlegadaFkDesc,
    "UbigeoPartidaFk": ubigeoPartidaFk,
    "UbigeoPartidaFkDesc": ubigeoPartidaFkDesc,
  };
}









