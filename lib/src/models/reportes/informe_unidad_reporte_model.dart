
class InformeUnidadReporteModel {
  InformeUnidadReporteModel({
    this.conductor,
    this.detalle,
    this.fechaCreacion,
    this.idCabezera,
    this.idPrioridad,
    this.idPrioridadDesc,
    this.idEstadoAtencion,
    this.idEstadoAtencionDesc,
    this.placa,
    this.mensaje,
    this.resultado,
  });

  String? conductor;
  List<Detalle>? detalle;
  String? fechaCreacion;
  String? idCabezera;
  String? idPrioridad;
  String? idPrioridadDesc;
  String? idEstadoAtencion;
  String? idEstadoAtencionDesc;
  String? placa;
  String? mensaje;
  String? resultado;

  factory InformeUnidadReporteModel.fromJson(Map<String, dynamic> json) => InformeUnidadReporteModel(
    conductor: json["Conductor"],
    detalle: List<Detalle>.from(json["Detalle"]?.map((x) => Detalle.fromJson(x))),
    fechaCreacion: json["FechaCreacion"],
    idCabezera: json["IdCabezera"],
    idPrioridad: json["IdPrioridad"],
    idPrioridadDesc: json["IdPrioridadDesc"],
    idEstadoAtencion: json["IdEstadoAtencion"],
    idEstadoAtencionDesc: json["IdEstadoAtencionDesc"],
    placa: json["Placa"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "Conductor": conductor,
    "Detalle": List<dynamic>.from(detalle!.map((x) => x.toJson())),
    "FechaCreacion": fechaCreacion,
    "IdCabezera": idCabezera,
    "IdPrioridad": idPrioridad,
    "IdPrioridadDesc": idPrioridadDesc,
    "IdEstadoAtencion": idEstadoAtencion,
    "IdEstadoAtencionDesc": idEstadoAtencionDesc,
    "Placa": placa,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}

class Detalle {
  Detalle({
    this.comentarioAnulado,
    this.comentarioProcesado,
    this.comentarioSolucionado,
    this.descripcion,
    this.fechaAnulado,
    this.fechaCreacion,
    this.fechaModificacion,
    this.fechaProcesar,
    this.fechaSolucionado,
    this.idDetalle,
    this.idResponsableProcesado,
    this.idResponsableProcesadoDesc,
    this.idResponsableSolucionado,
    this.idResponsableSolucionadoDesc,
    this.idTipoEstadoAtencion,
    this.idTipoEstadoAtencionDesc,
    this.idTipoIncidencia,
    this.idTipoIncidenciaDesc,
    this.idTipoSolucionado,
    this.idUsuarioAnulado,
    this.idUsuarioAnuladoDesc,
    this.idUsuarioCreacion,
    this.idUsuarioCreacionDesc,
  });

  String? comentarioAnulado;
  String? comentarioProcesado;
  String? comentarioSolucionado;
  String? descripcion;
  String? fechaAnulado;
  String? fechaCreacion;
  String? fechaModificacion;
  String? fechaProcesar;
  String? fechaSolucionado;
  String? idDetalle;
  String? idResponsableProcesado;
  String? idResponsableProcesadoDesc;
  String? idResponsableSolucionado;
  String? idResponsableSolucionadoDesc;
  String? idTipoEstadoAtencion;
  String? idTipoEstadoAtencionDesc;
  String? idTipoIncidencia;
  String? idTipoIncidenciaDesc;
  String? idTipoSolucionado;
  String? idUsuarioAnulado;
  String? idUsuarioAnuladoDesc;
  String? idUsuarioCreacion;
  String? idUsuarioCreacionDesc;

  factory Detalle.fromJson(Map<String, dynamic> json) => Detalle(
    comentarioAnulado: json["ComentarioAnulado"],
    comentarioProcesado: json["ComentarioProcesado"],
    comentarioSolucionado: json["ComentarioSolucionado"],
    descripcion: json["Descripcion"],
    fechaAnulado: json["FechaAnulado"],
    fechaCreacion: json["FechaCreacion"],
    fechaModificacion: json["FechaModificacion"],
    fechaProcesar: json["FechaProcesar"],
    fechaSolucionado: json["FechaSolucionado"],
    idDetalle: json["IdDetalle"],
    idResponsableProcesado: json["IdResponsableProcesado"],
    idResponsableProcesadoDesc: json["IdResponsableProcesadoDesc"],
    idResponsableSolucionado: json["IdResponsableSolucionado"],
    idResponsableSolucionadoDesc: json["IdResponsableSolucionadoDesc"],
    idTipoEstadoAtencion: json["IdTipoEstadoAtencion"],
    idTipoEstadoAtencionDesc: json["IdTipoEstadoAtencionDesc"],
    idTipoIncidencia: json["IdTipoIncidencia"],
    idTipoIncidenciaDesc: json["IdTipoIncidenciaDesc"],
    idTipoSolucionado: json["IdTipoSolucionado"],
    idUsuarioAnulado: json["IdUsuarioAnulado"],
    idUsuarioAnuladoDesc: json["IdUsuarioAnuladoDesc"],
    idUsuarioCreacion: json["IdUsuarioCreacion"],
    idUsuarioCreacionDesc: json["IdUsuarioCreacionDesc"],
  );

  Map<String, dynamic> toJson() => {
    "ComentarioAnulado": comentarioAnulado,
    "ComentarioProcesado": comentarioProcesado,
    "ComentarioSolucionado": comentarioSolucionado,
    "Descripcion": descripcion,
    "FechaAnulado": fechaAnulado,
    "FechaCreacion": fechaCreacion,
    "FechaModificacion": fechaModificacion,
    "FechaProcesar": fechaProcesar,
    "FechaSolucionado": fechaSolucionado,
    "IdDetalle": idDetalle,
    "IdResponsableProcesado": idResponsableProcesado,
    "IdResponsableProcesadoDesc": idResponsableProcesadoDesc,
    "IdResponsableSolucionado": idResponsableSolucionado,
    "IdResponsableSolucionadoDesc": idResponsableSolucionadoDesc,
    "IdTipoEstadoAtencion": idTipoEstadoAtencion,
    "IdTipoEstadoAtencionDesc": idTipoEstadoAtencionDesc,
    "IdTipoIncidencia": idTipoIncidencia,
    "IdTipoIncidenciaDesc": idTipoIncidenciaDesc,
    "IdTipoSolucionado": idTipoSolucionado,
    "IdUsuarioAnulado": idUsuarioAnulado,
    "IdUsuarioAnuladoDesc": idUsuarioAnuladoDesc,
    "IdUsuarioCreacion": idUsuarioCreacion,
    "IdUsuarioCreacionDesc": idUsuarioCreacionDesc,
  };
}
