

class EmpleadoModel {
  EmpleadoModel({
    this.entiId,
    this.entiNroDocumento,
    this.entiRazonSocial,
    this.mensaje,
    this.resultado,
  });

  String? entiId;
  String? entiNroDocumento;
  String? entiRazonSocial;
  String? mensaje;
  String? resultado;

  factory EmpleadoModel.fromJson(Map<String, dynamic> json) => EmpleadoModel(
    entiId: json["EntiId"],
    entiNroDocumento: json["EntiNroDocumento"],
    entiRazonSocial: json["EntiRazonSocial"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "EntiId": entiId,
    "EntiNroDocumento": entiNroDocumento,
    "EntiRazonSocial": entiRazonSocial,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}
