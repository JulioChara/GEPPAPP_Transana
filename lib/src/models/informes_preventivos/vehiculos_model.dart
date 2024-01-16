



class VehiculosModel {
  VehiculosModel({
    this.empresasFk,
    this.observaciones,
    this.tipoServicioVehiculoFk,
    this.tipoServicioVehiculoFkDesc,
    this.vehiCapacidad,
    this.vehiCertificado,
    this.vehiEstado,
    this.vehiFecCreacion,
    this.vehiFecModificacion,
    this.vehiId,
    this.vehiMarca,
    this.vehiModelo,
    this.vehiPlaca,
    this.vehiPromedio,
    this.vehiUsrCreacion,
    this.vehiUsrModificacion,
    this.mensaje,
    this.resultado,
  });

  dynamic empresasFk;
  dynamic observaciones;
  String tipoServicioVehiculoFk;
  String tipoServicioVehiculoFkDesc;
  dynamic vehiCapacidad;
  dynamic vehiCertificado;
  String vehiEstado;
  dynamic vehiFecCreacion;
  dynamic vehiFecModificacion;
  String vehiId;
  String vehiMarca;
  String vehiModelo;
  String vehiPlaca;
  dynamic vehiPromedio;
  dynamic vehiUsrCreacion;
  dynamic vehiUsrModificacion;
  String mensaje;
  String resultado;

  factory VehiculosModel.fromJson(Map<String, dynamic> json) => VehiculosModel(
    empresasFk: json["EmpresasFk"],
    observaciones: json["Observaciones"],
    tipoServicioVehiculoFk: json["TipoServicioVehiculoFk"],
    tipoServicioVehiculoFkDesc: json["TipoServicioVehiculoFkDesc"],
    vehiCapacidad: json["VehiCapacidad"],
    vehiCertificado: json["VehiCertificado"],
    vehiEstado: json["VehiEstado"],
    vehiFecCreacion: json["VehiFecCreacion"],
    vehiFecModificacion: json["VehiFecModificacion"],
    vehiId: json["VehiId"],
    vehiMarca: json["VehiMarca"],
    vehiModelo: json["VehiModelo"],
    vehiPlaca: json["VehiPlaca"],
    vehiPromedio: json["VehiPromedio"],
    vehiUsrCreacion: json["VehiUsrCreacion"],
    vehiUsrModificacion: json["VehiUsrModificacion"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "EmpresasFk": empresasFk,
    "Observaciones": observaciones,
    "TipoServicioVehiculoFk": tipoServicioVehiculoFk,
    "TipoServicioVehiculoFkDesc": tipoServicioVehiculoFkDesc,
    "VehiCapacidad": vehiCapacidad,
    "VehiCertificado": vehiCertificado,
    "VehiEstado": vehiEstado,
    "VehiFecCreacion": vehiFecCreacion,
    "VehiFecModificacion": vehiFecModificacion,
    "VehiId": vehiId,
    "VehiMarca": vehiMarca,
    "VehiModelo": vehiModelo,
    "VehiPlaca": vehiPlaca,
    "VehiPromedio": vehiPromedio,
    "VehiUsrCreacion": vehiUsrCreacion,
    "VehiUsrModificacion": vehiUsrModificacion,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}
