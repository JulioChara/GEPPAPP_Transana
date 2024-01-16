


class AlertasListadoModel {
  AlertasListadoModel({
    this.documento,
    this.fechaCaducidad,
    this.kmActual,
    this.kmCaducidad,
    this.alertaKM,
    this.kmMantenimiento,
    this.documentoGeneral,
    this.tipoDocumentoFk,
    this.tipoDocumentoFkDesc,
    this.vehiId,
    this.idTab,
    this.estadoAlerta,
    this.mensaje,
    this.resultado,
  });

  String documento;
  String fechaCaducidad;
  String kmActual;
  String kmCaducidad;
  String kmMantenimiento;
  String alertaKM;
  String documentoGeneral;
  String tipoDocumentoFk;
  String tipoDocumentoFkDesc;
  String vehiId;
  String idTab;
  String estadoAlerta;
  String mensaje;
  String resultado;

  factory AlertasListadoModel.fromJson(Map<String, dynamic> json) => AlertasListadoModel(
    documento: json["Documento"],
    fechaCaducidad: json["FechaCaducidad"],
    kmActual: json["KmActual"],
    kmCaducidad: json["KmCaducidad"],
    kmMantenimiento: json["KmMantenimiento"],
    alertaKM: json["alertaKM"],
    documentoGeneral: json["DocumentoGeneral"],
    tipoDocumentoFk: json["TipoDocumentoFk"],
    tipoDocumentoFkDesc: json["TipoDocumentoFkDesc"],
    vehiId: json["VehiId"],
    idTab: json["IdTab"],
    estadoAlerta: json["estadoAlerta"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "Documento": documento,
    "FechaCaducidad": fechaCaducidad,
    "KmActual": kmActual,
    "KmCaducidad": kmCaducidad,
    "KmMantenimiento": kmMantenimiento,
    "alertaKM": alertaKM,
    "DocumentoGeneral": documentoGeneral,
    "TipoDocumentoFk": tipoDocumentoFk,
    "TipoDocumentoFkDesc": tipoDocumentoFkDesc,
    "VehiId": vehiId,
    "IdTab": idTab,
    "estadoAlerta": estadoAlerta,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}



class TiposModel {
  TiposModel({
    this.idAccion,
    this.tipoDescripcionCorta,
    this.idTipoGeneralFk,
    this.idTipoGeneralFkDesc,
    this.usuario,
    this.tipoDescripcion,
    this.tipoId,
    this.mensaje,
    this.resultado,
  });




  String idAccion;
  String tipoDescripcionCorta;
  String idTipoGeneralFk;
  String idTipoGeneralFkDesc;
  String usuario;
  String tipoDescripcion;
  String tipoId;
  String mensaje;
  String resultado;

  factory TiposModel.fromJson(Map<String, dynamic> json) => TiposModel(
    idAccion: json["idAccion"],
    tipoDescripcionCorta: json["tipoDescripcionCorta"],
    idTipoGeneralFk: json["idTipoGeneralFk"],
    idTipoGeneralFkDesc: json["idTipoGeneralFkDesc"],
    usuario: json["usuario"],
    tipoDescripcion: json["TipoDescripcion"],
    tipoId: json["TipoId"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "idAccion": idAccion,
    "tipoDescripcionCorta": tipoDescripcionCorta,
    "idTipoGeneralFk": idTipoGeneralFk,
    "idTipoGeneralFkDesc": idTipoGeneralFkDesc,
    "usuario": usuario,
    "TipoDescripcion": tipoDescripcion,
    "TipoId": tipoId,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}



//PARA SALVAR EN DOCUMENTOS


class AlertasDocumentosModel {
  AlertasDocumentosModel({
    this.idAccion,
    this.vehiculoFk,
    this.tipoDocFk,
    this.documemtoRef,
    this.fechaEmision,
    this.fechaCaducidad,
    this.usuario,
    this.idC,
  });

  String idAccion;
  String vehiculoFk;
  String tipoDocFk;
  String documemtoRef;
  String fechaEmision;
  String fechaCaducidad;
  String usuario;
  String idC;

  factory AlertasDocumentosModel.fromJson(Map<String, dynamic> json) => AlertasDocumentosModel(
    idAccion: json["IdAccion"],
    vehiculoFk: json["vehiculoFk"],
    tipoDocFk: json["tipoDocFk"],
    documemtoRef: json["documemtoRef"],
    fechaEmision: json["fechaEmision"],
    fechaCaducidad: json["fechaCaducidad"],
    usuario: json["usuario"],
    idC: json["idC"],
  );

  Map<String, dynamic> toJson() => {
    "IdAccion": idAccion,
    "vehiculoFk": vehiculoFk,
    "tipoDocFk": tipoDocFk,
    "documemtoRef": documemtoRef,
    "fechaEmision": fechaEmision,
    "fechaCaducidad": fechaCaducidad,
    "usuario": usuario,
    "idC": idC,
  };
}





class AlertasMantenimientosModel {
  AlertasMantenimientosModel({
    this.idAccion,
    this.vehiculoFk,
    this.tipoDocFk,
    this.tipoControl,
    this.fechaEmision,
    this.fechaCaducidad,
    this.kilometroInicial,
    this.kilometroMantenimiento,
    this.kilometroCaducidad,
    this.usuario,
    this.idC,
  });

  int idAccion;
  String vehiculoFk;
  String tipoDocFk;
  String tipoControl;
  String fechaEmision;
  String fechaCaducidad;
  String kilometroInicial;
  String kilometroMantenimiento;
  String kilometroCaducidad;
  String usuario;
  String idC;

  factory AlertasMantenimientosModel.fromJson(Map<String, dynamic> json) => AlertasMantenimientosModel(
    idAccion: json["IdAccion"],
    vehiculoFk: json["vehiculoFk"],
    tipoDocFk: json["tipoDocFk"],
    tipoControl: json["tipoControl"],
    fechaEmision: json["fechaEmision"],
    fechaCaducidad: json["fechaCaducidad"],
    kilometroInicial: json["kilometroInicial"],
    kilometroMantenimiento: json["kilometroMantenimiento"],
    kilometroCaducidad: json["kilometroCaducidad"],
    usuario: json["usuario"],
    idC: json["idC"],
  );

  Map<String, dynamic> toJson() => {
    "IdAccion": idAccion,
    "vehiculoFk": vehiculoFk,
    "tipoDocFk": tipoDocFk,
    "tipoControl": tipoControl,
    "fechaEmision": fechaEmision,
    "fechaCaducidad": fechaCaducidad,
    "kilometroInicial": kilometroInicial,
    "kilometroMantenimiento": kilometroMantenimiento,
    "kilometroCaducidad": kilometroCaducidad,
    "usuario": usuario,
    "idC": idC,
  };
}




class SubProductosModel {
  String tipoDescripcion;
  String tipoDescripcionCorta;
  String tipoEstado;
  String tipoId;
  String tiposGeneralFk;

  SubProductosModel({
    this.tipoDescripcion,
    this.tipoDescripcionCorta,
    this.tipoEstado,
    this.tipoId,
    this.tiposGeneralFk,
  });

  factory SubProductosModel.fromJson(Map<String, dynamic> json) => SubProductosModel(
    tipoDescripcion: json["TipoDescripcion"],
    tipoDescripcionCorta: json["TipoDescripcionCorta"],
    tipoEstado: json["TipoEstado"],
    tipoId: json["TipoId"],
    tiposGeneralFk: json["TiposGeneralFk"],
  );

  Map<String, dynamic> toJson() => {
    "TipoDescripcion": tipoDescripcion,
    "TipoDescripcionCorta": tipoDescripcionCorta,
    "TipoEstado": tipoEstado,
    "TipoId": tipoId,
    "TiposGeneralFk": tiposGeneralFk,
  };
}




