import 'package:flutter/material.dart';

class EventStatus {
  String id;
  String descricao;

  EventStatus({@required this.id, @required this.descricao});
}

class EventEmploymentStatus {
  bool hasRefused;
  String id;
  String descricao;

  EventEmploymentStatus(
      {@required this.hasRefused, @required this.id, @required this.descricao});
}

enum EmployementId { PEN, AC, REC }
