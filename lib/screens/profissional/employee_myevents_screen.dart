import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/card_event_to_employee.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';

class EmployeeEventScreen extends StatefulWidget {
  const EmployeeEventScreen({Key key}) : super(key: key);

  @override
  _EmployeeEventScreenState createState() => _EmployeeEventScreenState();
}

class _EmployeeEventScreenState extends State<EmployeeEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EventUauAppBar(),
        body: Container(
          color: colorBg,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Meus eventos contratados",
                      style: TextStyle(
                          fontSize: 24,
                          color: primaryColor,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Icon(
                      Icons.history,
                      size: 32,
                      color: pink,
                    ),
                  ),
                  RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/employee/events/choice");
                      },
                      color: primaryColor,
                      textColor: colorBg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Text("escolha seus eventos"),
                      ))
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                  child: Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    setCardEventToEmployee(context),
                    setCardEventToEmployee(context),
                    setCardEventToEmployee(context),
                    setCardEventToEmployee(context),
                    setCardEventToEmployee(context),
                    setCardEventToEmployee(context),
                    setCardEventToEmployee(context),
                    setCardEventToEmployee(context),
                    setCardEventToEmployee(context),
                    setCardEventToEmployee(context),
                    setCardEventToEmployee(context),
                  ]),
                ),
              )),
            ],
          ),
        ));
  }
}
