
class Producto {
  String? productoId;
  String? producto;
  String? cantidad;
  String? precioUnitario;
  String? total;
  String? subProductoFk;

  Producto({
    this.productoId,
    this.producto,
    this.cantidad,
    this.precioUnitario,
    this.total,
    this.subProductoFk,
  });


  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
    productoId: json["ProductoId"],
    producto: json["Producto"],
    cantidad: json["Cantidad"],
    precioUnitario: json["PrecioUnitario"],
    total: json["Total"],
    subProductoFk: json["SubProductoFk"],
  );

  Map<String, dynamic> toJson() => {
    "ProductoId": productoId,
    "Producto": producto,
    "Cantidad": cantidad,
    "PrecioUnitario": precioUnitario,
    "Total": total,
    "SubProductoFk": subProductoFk,
  };
}


class ProductoInformes {
  String? productoId;
  String? producto;
  String? Tipo;

  ProductoInformes({
    this.productoId,
    this.producto,
    this.Tipo,
  });


  factory ProductoInformes.fromJson(Map<String, dynamic> json) => ProductoInformes(
    productoId: json["productoId"],
    producto: json["producto"],
    Tipo: json["Tipo"],
  );

  Map<String, dynamic> toJson() => {
    "productoId": productoId,
    "producto": producto,
    "Tipo": Tipo,
  };


}