import 'package:flutter/material.dart';

class EmployeeEventModel {
  int id;
  String name;
  String description;
  DateTime startDate;
  DateTime endDate;
  int minDuration;
  int maxDuration;

  EmployeeEventModel(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.startDate,
      @required this.endDate,
      @required this.maxDuration,
      @required this.minDuration});
}
