
class SubIncidenciasModel {
  SubIncidenciasModel({
    this.tipoDescripcion,
    this.tipoDescripcionCorta,
    this.tipoEstado,
    this.tipoId,
    this.tiposGeneralFk,
    this.mensaje,
    this.resultado,
  });

  String? tipoDescripcion;
  String? tipoDescripcionCorta;
  String? tipoEstado;
  String? tipoId;
  String? tiposGeneralFk;
  String? mensaje;
  String? resultado;

  factory SubIncidenciasModel.fromJson(Map<String, dynamic> json) => SubIncidenciasModel(
    tipoDescripcion: json["TipoDescripcion"],
    tipoDescripcionCorta: json["TipoDescripcionCorta"],
    tipoEstado: json["TipoEstado"],
    tipoId: json["TipoId"],
    tiposGeneralFk: json["TiposGeneralFk"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "TipoDescripcion": tipoDescripcion,
    "TipoDescripcionCorta": tipoDescripcionCorta,
    "TipoEstado": tipoEstado,
    "TipoId": tipoId,
    "TiposGeneralFk": tiposGeneralFk,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}
