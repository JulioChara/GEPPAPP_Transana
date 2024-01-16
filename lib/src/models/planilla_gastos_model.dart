
import 'package:flutter/material.dart';

class PlanillaGastosModel {
  PlanillaGastosModel({
    this.concepto,
    this.fecha,
    this.idDocumentoRelacionado,
    this.idTipoDocumento,
    this.idTipoDocumentoDesc,
    this.item,
    this.monto,
    this.plaId,
    this.viajeFk,
    this.mensaje,
    this.resultado,
  });

  String concepto;
  String fecha;
  String idDocumentoRelacionado;
  String idTipoDocumento;
  String idTipoDocumentoDesc;
  String item;
  String monto;
  String plaId;
  String viajeFk;
  String mensaje;
  String resultado;

  factory PlanillaGastosModel.fromJson(Map<String, dynamic> json) => PlanillaGastosModel(
    concepto: json["Concepto"],
    fecha: json["Fecha"],
    idDocumentoRelacionado: json["IdDocumentoRelacionado"],
    idTipoDocumento: json["IdTipoDocumento"],
    idTipoDocumentoDesc: json["IdTipoDocumentoDesc"],
    item: json["Item"],
    monto: json["Monto"],
    plaId: json["PlaId"],
    viajeFk: json["ViajeFk"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "Concepto": concepto,
    "Fecha": fecha,
    "IdDocumentoRelacionado": idDocumentoRelacionado,
    "IdTipoDocumento": idTipoDocumento,
    "IdTipoDocumentoDesc": idTipoDocumentoDesc,
    "Item": item,
    "Monto": monto,
    "PlaId": plaId,
    "ViajeFk": viajeFk,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}



class PlanillaDocumentosModel {
  PlanillaDocumentosModel({
    this.tipoDescripcion,
    this.tipoId,
    this.mensaje,
    this.resultado,
  });

  String tipoDescripcion;
  String tipoId;
  String mensaje;
  String resultado;

  factory PlanillaDocumentosModel.fromJson(Map<String, dynamic> json) => PlanillaDocumentosModel(
    tipoDescripcion: json["TipoDescripcion"],
    tipoId: json["TipoId"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "TipoDescripcion": tipoDescripcion,
    "TipoId": tipoId,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}


class PlanillaComprobantesModel {
  PlanillaComprobantesModel({
    this.tipoDescripcion,
    this.tipoId,
    this.mensaje,
    this.resultado,
  });

  String tipoDescripcion;
  String tipoId;
  String mensaje;
  String resultado;

  factory PlanillaComprobantesModel.fromJson(Map<String, dynamic> json) => PlanillaComprobantesModel(
    tipoDescripcion: json["TipoDescripcion"],
    tipoId: json["TipoId"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "TipoDescripcion": tipoDescripcion,
    "TipoId": tipoId,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}




class PlanillaTipos_Compras_Servicios_Model {
  PlanillaTipos_Compras_Servicios_Model({
    this.tipoDescripcion,
    this.tipoId,
    this.mensaje,
    this.resultado,
  });

  String tipoDescripcion;
  String tipoId;
  String mensaje;
  String resultado;

  factory PlanillaTipos_Compras_Servicios_Model.fromJson(Map<String, dynamic> json) => PlanillaTipos_Compras_Servicios_Model(
    tipoDescripcion: json["TipoDescripcion"],
    tipoId: json["TipoId"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "TipoDescripcion": tipoDescripcion,
    "TipoId": tipoId,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}





class DestinosPeajesModel {
  DestinosPeajesModel({
    this.destino,
    this.monto,
    this.tipoComprobante,
    this.razonSocial,
    this.ruc,
    this.id,
    this.mensaje,
    this.resultado,
  });

  String destino;
  String monto;
  String tipoComprobante;
  String razonSocial;
  String ruc;
  String id;
  String mensaje;
  String resultado;

  factory DestinosPeajesModel.fromJson(Map<String, dynamic> json) => DestinosPeajesModel(
    destino: json["Destino"],
    monto: json["Monto"],
    tipoComprobante: json["TipoComprobante"],
    razonSocial: json["RazonSocial"],
    ruc: json["RUC"],
    id: json["id"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "Destino": destino,
    "Monto": monto,
    "TipoComprobante": tipoComprobante,
    "RazonSocial": razonSocial,
    "RUC": ruc,
    "id": id,
    "mensaje": mensaje,
    "resultado": resultado,
  };


}

//PEAJES SAVE INI//


// To parse this JSON data, do
//
//     final planillaGastosPeajes = planillaGastosPeajesFromJson(jsonString);

class PlanillaGastosPeajesModel {
  PlanillaGastosPeajesModel({
    this.viajeFk,
    this.tipoDocGasto,
    this.item,
    this.fecha,
    this.concepto,
    this.monto,
    this.lugar,
    this.tipoComprobante,
    this.fechaDoc,
    this.razonSocial,
    this.ruc,
    this.serie,
    this.numero,
    this.usuario,
    this.idAccion,
    this.idPlanilla,
    this.idDetalle,
  });

  String viajeFk;
  String tipoDocGasto;
  String item;
  String fecha;
  String concepto;
  String monto;
  String lugar;
  String tipoComprobante;
  String fechaDoc;
  String razonSocial;
  String ruc;
  String serie;
  String numero;
  String usuario;
  int idAccion;
  String idPlanilla;
  String idDetalle;

  factory PlanillaGastosPeajesModel.fromJson(Map<String, dynamic> json) => PlanillaGastosPeajesModel(
    viajeFk: json["ViajeFk"],
    tipoDocGasto: json["TipoDocGasto"],
    item: json["Item"],
    //fecha: DateTime.parse(json["Fecha"]),
    fecha: json["Fecha"],
    concepto: json["Concepto"],
    monto: json["Monto"],
    lugar: json["Lugar"],
    tipoComprobante: json["TipoComprobante"],
    razonSocial: json["RazonSociales"],
    fechaDoc: json["FechaDoc"],
    ruc: json["RUC"],
    serie: json["Serie"],
    numero: json["Numero"],
    usuario: json["Usuario"],
    idAccion: json["IdAccion"],
    idPlanilla: json["IdPlanilla"],
    idDetalle: json["IdDetalle"],
  );

  Map<String, dynamic> toJson() => {
    "ViajeFk": viajeFk,
    "TipoDocGasto": tipoDocGasto,
    "Item": item,
    //"Fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
    "Fecha": fecha,
    "Concepto": concepto,
    "Monto": monto,
    "Lugar": lugar,
    "TipoComprobante": tipoComprobante,
    "FechaDoc": fechaDoc,
    "RazonSocial": razonSocial,
    "RUC": ruc,
    "Serie": serie,
    "Numero": numero,
    "Usuario": usuario,
    "IdAccion": idAccion,
    "IdPlanilla": idPlanilla,
    "IdDetalle": idDetalle,
  };
}

//PEAJES SAVE END//

//PLANILLA GASTOS ELIMINAR DETALLES //

class PlanillaGastosEliminarModel {
  PlanillaGastosEliminarModel({
    this.idPlanilla,
    this.idTipoDocGasto,
  });

  String idPlanilla;
  String idTipoDocGasto;

  factory PlanillaGastosEliminarModel.fromJson(Map<String, dynamic> json) => PlanillaGastosEliminarModel(
    idPlanilla: json["idPlanilla"],
    idTipoDocGasto: json["idTipoDocGasto"],
  );

  Map<String, dynamic> toJson() => {
    "idPlanilla": idPlanilla,
    "idTipoDocGasto": idTipoDocGasto,
  };
}

//END ELIMINAR DETALLES PLANILLAS



//SAVE ALIMENTOS//

// To parse this JSON data, do
//
//     final planillaGastosAlimentosModel = planillaGastosAlimentosModelFromJson(jsonString);


class PlanillaGastosAlimentosModel {
  PlanillaGastosAlimentosModel({
    this.viajeFk,
    this.viajeDocumentoFk,
    this.tipoDocGasto,
    this.item,
    this.fecha,
    this.concepto,
    this.monto,
    this.fechaDoc,
    this.tipoComprobante,
    this.ruc,
    this.razonSocial,
    this.serie,
    this.numero,
    this.usuario,
    this.idAccion,
  });

  String viajeFk;
  String viajeDocumentoFk;
  String tipoDocGasto;
  String item;
  //DateTime fecha;
  String fecha;
  String concepto;
  String monto;
  String fechaDoc;
  String tipoComprobante;
  String ruc;
  String razonSocial;
  String serie;
  String numero;
  String usuario;
  int idAccion;

  factory PlanillaGastosAlimentosModel.fromJson(Map<String, dynamic> json) => PlanillaGastosAlimentosModel(
    viajeFk: json["ViajeFk"],
    viajeDocumentoFk: json["viajeDocumentoFk"],
    tipoDocGasto: json["TipoDocGasto"],
    item: json["Item"],
   // fecha: DateTime.parse(json["Fecha"]),
    fecha: json["Fecha"],
    concepto: json["Concepto"],
    monto: json["Monto"],
    fechaDoc: json["fechaDoc"],
    tipoComprobante: json["TipoComprobante"],
    ruc: json["RUC"],
    razonSocial: json["razonSocial"],
    serie: json["Serie"],
    numero: json["Numero"],
    usuario: json["Usuario"],
    idAccion: json["IdAccion"],
  );

  Map<String, dynamic> toJson() => {
    "ViajeFk": viajeFk,
    "viajeDocumentoFk": viajeDocumentoFk,
    "TipoDocGasto": tipoDocGasto,
    "Item": item,
   // "Fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
    "Fecha": fecha,
    "Concepto": concepto,
    "Monto": monto,
    "FechaDoc": fechaDoc,
    "TipoComprobante": tipoComprobante,
    "RUC": ruc,
    "RazonSocial": razonSocial,
    "Serie": serie,
    "Numero": numero,
    "Usuario": usuario,
    "IdAccion": idAccion,
  };
}
//END SAVE ALIMENTOS//




class PlanillaGastosEstacionamientoModel {
  PlanillaGastosEstacionamientoModel({
    this.viajeFk,
    this.tipoDocGasto,
    this.item,
    this.fecha,
    this.concepto,
    this.monto,
    this.fechaDoc,
    this.tipoComprobante,
    this.ruc,
    this.razonSocial,
    this.serie,
    this.numero,
    this.usuario,
    this.idAccion,
  });

  String viajeFk;
  String tipoDocGasto;
  String item;
  //DateTime fecha;
  String fecha;
  String concepto;
  String monto;
  String fechaDoc;
  String tipoComprobante;
  String ruc;
  String razonSocial;
  String serie;
  String numero;
  String usuario;
  int idAccion;

  factory PlanillaGastosEstacionamientoModel.fromJson(Map<String, dynamic> json) => PlanillaGastosEstacionamientoModel(
    viajeFk: json["ViajeFk"],
    tipoDocGasto: json["TipoDocGasto"],
    item: json["Item"],
    // fecha: DateTime.parse(json["Fecha"]),
    fecha: json["Fecha"],
    concepto: json["Concepto"],
    monto: json["Monto"],
    fechaDoc: json["fechaDoc"],
    tipoComprobante: json["TipoComprobante"],
    ruc: json["RUC"],
    razonSocial: json["razonSocial"],
    serie: json["Serie"],
    numero: json["Numero"],
    usuario: json["Usuario"],
    idAccion: json["IdAccion"],
  );

  Map<String, dynamic> toJson() => {
    "ViajeFk": viajeFk,
    "TipoDocGasto": tipoDocGasto,
    "Item": item,
    // "Fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
    "Fecha": fecha,
    "Concepto": concepto,
    "Monto": monto,
    "FechaDoc": fechaDoc,
    "TipoComprobante": tipoComprobante,
    "RUC": ruc,
    "RazonSocial": razonSocial,
    "Serie": serie,
    "Numero": numero,
    "Usuario": usuario,
    "IdAccion": idAccion,
  };
}
//END SAVE ESTACIONAMIENTO//




//MOVILIDAD//
class PlanillaGastosMovilidadModel {
  PlanillaGastosMovilidadModel({
    this.viajeFk,
    this.tipoDocGasto,
    this.fecha,
    this.concepto,
    this.monto,
    this.numeroPlanilla,
    this.fechaDoc,
    this.usuario,
    this.idAccion,
    this.idPlanilla,
    this.idDetalle,
  });

  String viajeFk;
  String tipoDocGasto;
  String fecha;
  String concepto;
  String monto;
  String numeroPlanilla;
  String fechaDoc;
  String usuario;
  int idAccion;
  int idPlanilla;
  String idDetalle;

  factory PlanillaGastosMovilidadModel.fromJson(Map<String, dynamic> json) => PlanillaGastosMovilidadModel(
    viajeFk: json["ViajeFk"],
    tipoDocGasto: json["TipoDocGasto"],
  //  fecha: DateTime.parse(json["Fecha"]),
    fecha: json["Fecha"],
    concepto: json["Concepto"],
    monto: json["Monto"],
    numeroPlanilla: json["NumeroPlanilla"],
    fechaDoc: json["FechaDoc"],
    usuario: json["Usuario"],
    idAccion: json["IdAccion"],
    idPlanilla: json["IdPlanilla"],
    idDetalle: json["IdDetalle"],
  );

  Map<String, dynamic> toJson() => {
    "ViajeFk": viajeFk,
    "TipoDocGasto": tipoDocGasto,
  //  "Fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
    "Fecha": fecha,
    "Concepto": concepto,
    "Monto": monto,
    "NumeroPlanilla": numeroPlanilla,
    "FechaDoc": fechaDoc,
    "Usuario": usuario,
    "IdAccion": idAccion,
    "IdPlanilla": idPlanilla,
    "IdDetalle": idDetalle,
  };
}
//END MOVILIDAD//

// HOSPEDAJE //

class PlanillaGastosHospedajeModel {
  PlanillaGastosHospedajeModel({
    this.viajeFk,
    this.tipoDocGasto,
    this.fecha,
    this.concepto,
    this.monto,
    this.fechaDoc,
    this.tipoComprobante,
    this.ruc,
    this.razonSocial,
    this.serie,
    this.numero,
    this.usuario,
    this.idAccion,
    this.idPlanilla,
    this.idDetalle,
  });

  String viajeFk;
  String tipoDocGasto;
  String fecha;
  String concepto;
  String monto;
  String fechaDoc;
  String tipoComprobante;
  String ruc;
  String razonSocial;
  String serie;
  String numero;
  String usuario;
  String idAccion;
  String idPlanilla;
  String idDetalle;

  factory PlanillaGastosHospedajeModel.fromJson(Map<String, dynamic> json) => PlanillaGastosHospedajeModel(
    viajeFk: json["ViajeFk"],
    tipoDocGasto: json["TipoDocGasto"],
    fecha: json["Fecha"],
    concepto: json["Concepto"],
    monto: json["Monto"],
    fechaDoc: json["FechaDoc"],
    tipoComprobante: json["TipoComprobante"],
    ruc: json["RUC"],
    razonSocial: json["RazonSocial"],
    serie: json["Serie"],
    numero: json["Numero"],
    usuario: json["Usuario"],
    idAccion: json["IdAccion"],
    idPlanilla: json["IdPlanilla"],
    idDetalle: json["IdDetalle"],
  );

  Map<String, dynamic> toJson() => {
    "ViajeFk": viajeFk,
    "TipoDocGasto": tipoDocGasto,
    "Fecha": fecha,
    "Concepto": concepto,
    "Monto": monto,
    "FechaDoc": fechaDoc,
    "TipoComprobante": tipoComprobante,
    "RUC": ruc,
    "RazonSocial": razonSocial,
    "Serie": serie,
    "Numero": numero,
    "Usuario": usuario,
    "IdAccion": idAccion,
    "IdPlanilla": idPlanilla,
    "IdDetalle": idDetalle,
  };
}

//END HOSPEDAJE //
//PASAJES

class PlanillaGastosPasajesModel {
  PlanillaGastosPasajesModel({
    this.viajeFk,
    this.tipoDocGasto,
    this.fecha,
    this.concepto,
    this.monto,
    this.fechaDoc,
    this.tipoComprobante,
    this.ruc,
    this.razonSocial,
    this.serie,
    this.numero,
    this.usuario,
    this.idAccion,
    this.idPlanilla,
    this.idDetalle,
  });

  String viajeFk;
  String tipoDocGasto;
  String fecha;
  String concepto;
  String monto;
  String fechaDoc;
  String tipoComprobante;
  String ruc;
  String razonSocial;
  String serie;
  String numero;
  String usuario;
  String idAccion;
  String idPlanilla;
  String idDetalle;

  factory PlanillaGastosPasajesModel.fromJson(Map<String, dynamic> json) => PlanillaGastosPasajesModel(
    viajeFk: json["ViajeFk"],
    tipoDocGasto: json["TipoDocGasto"],
    fecha: json["Fecha"],
    concepto: json["Concepto"],
    monto: json["Monto"],
    fechaDoc: json["FechaDoc"],
    tipoComprobante: json["TipoComprobante"],
    ruc: json["RUC"],
    razonSocial: json["RazonSocial"],
    serie: json["Serie"],
    numero: json["Numero"],
    usuario: json["Usuario"],
    idAccion: json["IdAccion"],
    idPlanilla: json["IdPlanilla"],
    idDetalle: json["IdDetalle"],
  );

  Map<String, dynamic> toJson() => {
    "ViajeFk": viajeFk,
    "TipoDocGasto": tipoDocGasto,
    "Fecha": fecha,
    "Concepto": concepto,
    "Monto": monto,
    "FechaDoc": fechaDoc,
    "TipoComprobante": tipoComprobante,
    "RUC": ruc,
    "RazonSocial": razonSocial,
    "Serie": serie,
    "Numero": numero,
    "Usuario": usuario,
    "IdAccion": idAccion,
    "IdPlanilla": idPlanilla,
    "IdDetalle": idDetalle,
  };
}


// COMPRAS //

class PlanillaGastosComprasModel {
  PlanillaGastosComprasModel({
    this.viajeFk,
    this.tipoDocGasto,
    this.fecha,
    this.concepto,
    this.monto,
    this.tipoCompra,
    this.fechaDoc,
    this.tipoComprobante,
    this.ruc,
    this.razonSocial,
    this.serie,
    this.numero,
    this.usuario,
    this.idAccion,
    this.idPlanilla,
    this.idDetalle,
  });

  String viajeFk;
  String tipoDocGasto;
  String fecha;
  String concepto;
  String monto;
  String tipoCompra;
  String fechaDoc;
  String tipoComprobante;
  String ruc;
  String razonSocial;
  String serie;
  String numero;
  String usuario;
  String idAccion;
  String idPlanilla;
  String idDetalle;

  factory PlanillaGastosComprasModel.fromJson(Map<String, dynamic> json) => PlanillaGastosComprasModel(
    viajeFk: json["ViajeFk"],
    tipoDocGasto: json["TipoDocGasto"],
    fecha: json["Fecha"],
    concepto: json["Concepto"],
    monto: json["Monto"],
    tipoCompra: json["TipoCompra"],
    fechaDoc: json["FechaDoc"],
    tipoComprobante: json["TipoComprobante"],
    ruc: json["RUC"],
    razonSocial: json["RazonSocial"],
    serie: json["Serie"],
    numero: json["Numero"],
    usuario: json["Usuario"],
    idAccion: json["IdAccion"],
    idPlanilla: json["IdPlanilla"],
    idDetalle: json["IdDetalle"],
  );

  Map<String, dynamic> toJson() => {
    "ViajeFk": viajeFk,
    "TipoDocGasto": tipoDocGasto,
    "Fecha": fecha,
    "Concepto": concepto,
    "Monto": monto,
    "TipoCompra": tipoCompra,
    "FechaDoc": fechaDoc,
    "TipoComprobante": tipoComprobante,
    "RUC": ruc,
    "RazonSocial": razonSocial,
    "Serie": serie,
    "Numero": numero,
    "Usuario": usuario,
    "IdAccion": idAccion,
    "IdPlanilla": idPlanilla,
    "IdDetalle": idDetalle,
  };
}



// SERVICIOS //

class PlanillaGastosServiciosModel {
  PlanillaGastosServiciosModel({
    this.viajeFk,
    this.tipoDocGasto,
    this.fecha,
    this.concepto,
    this.monto,
    this.tipoServicio,
    this.fechaDoc,
    this.tipoComprobante,
    this.ruc,
    this.razonSocial,
    this.serie,
    this.numero,
    this.usuario,
    this.idAccion,
    this.idPlanilla,
    this.idDetalle,
  });

  String viajeFk;
  String tipoDocGasto;
  String fecha;
  String concepto;
  String monto;
  String tipoServicio;
  String fechaDoc;
  String tipoComprobante;
  String ruc;
  String razonSocial;
  String serie;
  String numero;
  String usuario;
  String idAccion;
  String idPlanilla;
  String idDetalle;

  factory PlanillaGastosServiciosModel.fromJson(Map<String, dynamic> json) => PlanillaGastosServiciosModel(
    viajeFk: json["ViajeFk"],
    tipoDocGasto: json["TipoDocGasto"],
    fecha: json["Fecha"],
    concepto: json["Concepto"],
    monto: json["Monto"],
    tipoServicio: json["TipoServicio"],
    fechaDoc: json["FechaDoc"],
    tipoComprobante: json["TipoComprobante"],
    ruc: json["RUC"],
    razonSocial:  json["RazonSocial"],
    serie: json["Serie"],
    numero: json["Numero"],
    usuario: json["Usuario"],
    idAccion: json["IdAccion"],
    idPlanilla: json["IdPlanilla"],
    idDetalle: json["IdDetalle"],
  );

  Map<String, dynamic> toJson() => {
    "ViajeFk": viajeFk,
    "TipoDocGasto": tipoDocGasto,
    "Fecha": fecha,
    "Concepto": concepto,
    "Monto": monto,
    "TipoServicio": tipoServicio,
    "FechaDoc": fechaDoc,
    "TipoComprobante": tipoComprobante,
    "RUC": ruc,
    "RazonSocial":razonSocial,
    "Serie": serie,
    "Numero": numero,
    "Usuario": usuario,
    "IdAccion": idAccion,
    "IdPlanilla": idPlanilla,
    "IdDetalle": idDetalle,
  };
}




//LISTADOS MAXIMUS ELIUMS RAA // LISTADOR POR UNIDAD VISOR


class PlanillaGastosVisorModel {
  PlanillaGastosVisorModel({
    this.descripcion,
    this.fechaDoc,
    this.lugar,
    this.monto,
    this.numero,
    this.numeroPlanilla,
    this.ruc,
    this.razonSocial,
    this.serie,
    this.tipoComSer,
    this.tipoComprobante,
    this.mensaje,
    this.resultado,
  });

  String descripcion;
  String fechaDoc;
  String lugar;
  String monto;
  String numero;
  String numeroPlanilla;
  String ruc;
  String razonSocial;
  String serie;
  String tipoComSer;
  String tipoComprobante;
  String mensaje;
  String resultado;

  factory PlanillaGastosVisorModel.fromJson(Map<String, dynamic> json) => PlanillaGastosVisorModel(
    descripcion: json["Descripcion"],
    fechaDoc: json["FechaDoc"],
    lugar: json["Lugar"],
    monto: json["Monto"],
    numero: json["Numero"],
    numeroPlanilla: json["NumeroPlanilla"],
    ruc: json["RUC"],
    razonSocial: json["RazonSocial"],
    serie: json["Serie"],
    tipoComSer: json["TipoComSer"],
    tipoComprobante: json["TipoComprobante"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "Descripcion": descripcion,
    "FechaDoc": fechaDoc,
    "Lugar": lugar,
    "Monto": monto,
    "Numero": numero,
    "NumeroPlanilla": numeroPlanilla,
    "RUC": ruc,
    "RazonSocial": razonSocial,
    "Serie": serie,
    "TipoComSer": tipoComSer,
    "TipoComprobante": tipoComprobante,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}


//CONSULTADOR DE DOCUMENTOS //

class PlanillaGastosConsultaSunatModel {
  PlanillaGastosConsultaSunatModel({
    this.direccion,
    this.razonSocial,
    this.ruc,
  });

  String direccion;
  String razonSocial;
  String ruc;

  factory PlanillaGastosConsultaSunatModel.fromJson(Map<String, dynamic> json) => PlanillaGastosConsultaSunatModel(
    direccion: json["Direccion"],
    razonSocial: json["RazonSocial"],
    ruc: json["Ruc"],
  );

  Map<String, dynamic> toJson() => {
    "Direccion": direccion,
    "RazonSocial": razonSocial,
    "Ruc": ruc,
  };
}
