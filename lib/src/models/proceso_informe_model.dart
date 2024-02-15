
class ProcesoInformeModel {
  ProcesoInformeModel({
    this.idCabezera,
    this.idDetalle,
    this.idAccion,
    this.comentarioProcesado,
    this.idResponsableProcesado,
    this.IdTipoSolucionado,
    this.comentarioSolucionado,
    this.idResponsableSolucionado,
    this.comentarioAnulado,
    this.idUsuarioAnulado,
  });

  String? idCabezera;
  String? idDetalle;
  int? idAccion;
  String? comentarioProcesado;
  String? idResponsableProcesado;
  String? IdTipoSolucionado;
  String? comentarioSolucionado;
  String? idResponsableSolucionado;
  String? comentarioAnulado;
  String? idUsuarioAnulado;

  factory ProcesoInformeModel.fromJson(Map<String, dynamic> json) => ProcesoInformeModel(
    idCabezera: json["IdCabezera"],
    idDetalle: json["IdDetalle"],
    idAccion: json["IdAccion"],
    comentarioProcesado: json["ComentarioProcesado"],
    idResponsableProcesado: json["IdResponsableProcesado"],
    IdTipoSolucionado: json["IdTipoSolucionado"],
    comentarioSolucionado: json["ComentarioSolucionado"],
    idResponsableSolucionado: json["IdResponsableSolucionado"],
    comentarioAnulado: json["ComentarioAnulado"],
    idUsuarioAnulado: json["IdUsuarioAnulado"],
  );

  Map<String, dynamic> toJson() => {
    "IdCabezera": idCabezera,
    "IdDetalle": idDetalle,
    "IdAccion": idAccion,
    "ComentarioProcesado": comentarioProcesado,
    "IdResponsableProcesado": idResponsableProcesado,
    "IdTipoSolucionado": IdTipoSolucionado,
    "ComentarioSolucionado": comentarioSolucionado,
    "IdResponsableSolucionado": idResponsableSolucionado,
    "ComentarioAnulado": comentarioAnulado,
    "IdUsuarioAnulado": idUsuarioAnulado,
  };
}
