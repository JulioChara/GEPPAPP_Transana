

import 'dart:ui';

class ChipModel{
  final String id, name, tipo;
  final Color colorcito;
  final bool esPrincipal;

  ChipModel({required this.id, required this.name, required this.tipo, required this.colorcito , required this.esPrincipal});
}



class ChipModelConductores{
  final String id, name;
  final Color colorcito;
  final bool esPrincipal;

  ChipModelConductores({required this.id, required this.name, required this.colorcito , required this.esPrincipal});
}
