<<<<<<< HEAD
import 'dart:io';

import 'package:event_uau/components/employee/profile_screen/profile_picture.dart';
import 'package:event_uau/models/funcionario_model.dart';
import 'package:event_uau/providers/auth.dart';
import 'package:event_uau/service/contratado_service.dart';

import 'package:flutter/material.dart';

class ContratadoModel with ChangeNotifier {
  int id;
  double valorHora;
  String nome;
  List<JobItem> especialidades = [];
  double grade;
  double rating;
  File profilePicture;
  User userData;

  ContratadoModel(
      {this.id, this.valorHora, this.especialidades, this.grade, this.rating});

  File get userProfilePicture {
    return profilePicture != null ? new File(profilePicture.path) : null;
  }

  void setEspecialidades(int id) async {
    Map<String, dynamic> response =
        await ContratadoService.getEspecialidadesById(id);
    (response['especialidades'] ?? []).forEach((element) {
      this
          .especialidades
          .add(new JobItem(id: element["id"], descricao: element["descricao"]));
    });
  }
=======
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
>>>>>>> ccf5aee9f6c355d449406b51ff835a5b2ec328dc
}
