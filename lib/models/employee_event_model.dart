import 'package:flutter/material.dart';
import './address_model.dart';
import './event_employment_status_model.dart';

class EmployeeEventModel {
  int id;
  String name;
  String description;
  DateTime startDate;
  DateTime endDate;
  int minDuration;
  int maxDuration;
  EventEmploymentStatus employmentStatus;
  EventStatus eventStatus;

  AddressModel address;

  get isConsideringProposal =>
      employmentStatus.id == 'PEN' && employmentStatus.hasRefused == false;

  EmployeeEventModel(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.startDate,
      @required this.endDate,
      @required this.maxDuration,
      @required this.minDuration,
      @required this.employmentStatus,
      @required this.eventStatus,
      @required this.address});
}
