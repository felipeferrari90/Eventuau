import 'dart:io';
import 'package:event_uau/components/employee/profile_screen/profile_picture.dart';
import 'package:event_uau/models/event_employment_status_model.dart';
import 'package:event_uau/models/funcionario_model.dart';
import 'package:event_uau/providers/auth.dart';
import 'package:event_uau/service/contratado_service.dart';
import 'dart:math';

import 'package:flutter/material.dart';

var rng = new Random();

class ContratadoModel with ChangeNotifier {
  int id;
  String nome;
  String cpf;
  String phone;
  double valorHora;
  DateTime birthDate;
  EventEmploymentStatus status;
  List<JobItem> especialidades = [];
  File profilePicture;

  ContratadoModel({
    @required this.id,
    @required this.nome,
    @required this.cpf,
    @required this.phone,
    @required this.valorHora,
    @required this.birthDate,
    @required this.especialidades,
    @required this.status,
  });

  File get userProfilePicture {
    return profilePicture != null ? new File(profilePicture.path) : null;
  }

  get grade {
    return (rng.nextDouble() * 5).toStringAsFixed(2);
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
}
