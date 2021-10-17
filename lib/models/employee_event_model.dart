import 'package:event_uau/models/address_model.dart';
import 'package:flutter/material.dart';

class EmployeeEventModel {
  int id;
  String name;
  String description;
  DateTime startDate;
  DateTime endDate;
  int minDuration;
  int maxDuration;
  String status;
  AddressModel address;

  EmployeeEventModel(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.startDate,
      @required this.endDate,
      @required this.maxDuration,
      @required this.minDuration,
      @required this.status,
      @required this.address});
}
