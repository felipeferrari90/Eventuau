import 'package:flutter/material.dart';

class ContratadoModel {
  double valorHora;
  List<JobItem> especialidades;
  double grade;

  ContratadoModel(
      {@required this.valorHora,
      @required this.especialidades,
      @required this.grade});
}

class JobItem {
  int id;
  String descricao;

  JobItem({this.id, this.descricao});
}
