

class IdsModel {
  IdsModel({
    this.idC,
    this.idD,
    this.usuario,
  });

  String idC;
  String idD;
  String usuario;

  factory IdsModel.fromJson(Map<String, dynamic> json) => IdsModel(
    idC: json["idC"],
    idD: json["idD"],
    usuario: json["usuario"],
  );

  Map<String, dynamic> toJson() => {
    "idC": idC,
    "idD": idD,
    "usuario": usuario,
  };
}

