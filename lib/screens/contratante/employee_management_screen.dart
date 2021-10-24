import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/models/contratado_model.dart';
import 'package:event_uau/models/funcionario_model.dart';
import 'package:event_uau/providers/auth.dart';
import 'package:event_uau/service/event_service.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeesManagement extends StatefulWidget {
  const EmployeesManagement({Key key}) : super(key: key);

  @override
  _EmployeesManagementState createState() => _EmployeesManagementState();
}

class _EmployeesManagementState extends State<EmployeesManagement> {
  List<ContratadoModel> cacheEmployees = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EventUauAppBar(
            title: 'gerenciador de funcionarios',
            ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            color: colorBg,
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                  ],
                ),
              ),
            )));
  }

  setCardManagementEmployee(BuildContext context,
          {Function f, bool estaPresente}) =>
      Card(
          child: SwitchListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text("presente:",
                  style: TextStyle(color: Colors.black54),
                  textAlign: TextAlign.right),
              value: estaPresente ?? false,
              activeColor: primaryColor,
              inactiveTrackColor: colorBg,
              autofocus: true,
              onChanged: (bool value) {
                setState(() {
                  estaPresente = value;
                });
              },
              secondary: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/contract/id");
                },
                child: Text("Pedro Lemes\nRG\: 12345678-9\t",
                    style: Theme.of(context).textTheme.headline5),
              ),
              controlAffinity: ListTileControlAffinity.trailing));
}
