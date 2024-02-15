

class ViajeDocumentosModel {
  ViajeDocumentosModel({
    this.descripcion,
    this.entidadFk,
    this.fechaDocumento,
    this.idAccion,
    this.idDoc,
    this.mensaje,
    this.monto,
    this.numero,
    this.razonSocial,
    this.minimalista,
    this.restante,
    this.resultado,
    this.ruc,
    this.serie,
    this.tipoDocumentoFk,
    this.tipoDocumentoFkDesc,
    this.usuario,
  });

  String? descripcion;
  String? entidadFk;
  String? fechaDocumento;
  String? idAccion;
  String? idDoc;
  String? mensaje;
  String? monto;
  String? numero;
  String? razonSocial;
  String? minimalista;
  String? restante;
  String? resultado;
  String? ruc;
  String? serie;
  String? tipoDocumentoFk;
  String? tipoDocumentoFkDesc;
  String? usuario;

  factory ViajeDocumentosModel.fromJson(Map<String, dynamic> json) => ViajeDocumentosModel(
    descripcion: json["descripcion"],
    entidadFk: json["entidadFk"],
    fechaDocumento: json["fechaDocumento"],
    idAccion: json["idAccion"],
    idDoc: json["idDoc"],
    mensaje: json["mensaje"],
    monto: json["monto"],
    numero: json["numero"],
    razonSocial: json["razonSocial"],
    minimalista: json["minimalista"],
    restante: json["restante"],
    resultado: json["resultado"],
    ruc: json["ruc"],
    serie: json["serie"],
    tipoDocumentoFk: json["tipoDocumentoFk"],
    tipoDocumentoFkDesc: json["tipoDocumentoFkDesc"],
    usuario: json["usuario"],
  );

  Map<String, dynamic> toJson() => {
    "descripcion": descripcion,
    "entidadFk": entidadFk,
    "fechaDocumento": fechaDocumento,
    "idAccion": idAccion,
    "idDoc": idDoc,
    "mensaje": mensaje,
    "monto": monto,
    "numero": numero,
    "razonSocial": razonSocial,
    "minimalista": minimalista,
    "restante": restante,
    "resultado": resultado,
    "ruc": ruc,
    "serie": serie,
    "tipoDocumentoFk": tipoDocumentoFk,
    "tipoDocumentoFkDesc": tipoDocumentoFkDesc,
    "usuario": usuario,
  };
}







