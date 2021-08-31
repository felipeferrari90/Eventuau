import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/card_employee.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:event_uau/utils/icons.dart';
import 'package:flutter/material.dart';

class EmployeeChoiceScreen extends StatefulWidget {
  const EmployeeChoiceScreen({Key key}) : super(key: key);

  static int option;

  @override
  _EmployeeChoiceScreenState createState() => _EmployeeChoiceScreenState();
}

class _EmployeeChoiceScreenState extends State<EmployeeChoiceScreen> {
  //o numero de icones abaixo tem que ser sempre igual ao comprimento desse array, se não dara erro.
  List<bool> _isSelected = [true, false, false, false];

  String _employeeSelected = "garcom";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EventUauAppBar(username: "Felipe Ferreira Marques"),
        backgroundColor: colorBg,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Eu Preciso de um...",
                  style: Theme.of(context).textTheme.headline1,
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: ToggleButtons(
                      children: [
                        setButtonJobTypeSelection(
                            icon: EventuauIcons.garcom_logo, title: "garçom"),
                        setButtonJobTypeSelection(
                            icon: EventuauIcons.clown, title: "animador"),
                        setButtonJobTypeSelection(
                            icon: EventuauIcons.buffet, title: "buffet"),
                        setButtonJobTypeSelection(
                            icon: EventuauIcons.grill, title: "churrasco"),
                      ],
                      isSelected: _isSelected,
                      onPressed: (int index) {
                        setState(() {
                          _isSelected = _isSelected.map((e) => false).toList();
                          _isSelected[index] = true;
                          switch (index) {
                            case 0:
                              _employeeSelected = "garcom";
                              break;
                            case 1:
                              _employeeSelected = "animador";
                              break;
                            case 2:
                              _employeeSelected = "buffet";
                              break;
                            case 3:
                              _employeeSelected = "churrasco";
                              break;
                          }
                        });
                        print(_employeeSelected);
                      },
                      selectedColor: primaryColor,
                      fillColor: colorBg,
                      borderWidth: 0,
                      borderColor: colorBg,
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                      renderBorder: false,
                      constraints: BoxConstraints(
                        minWidth: (MediaQuery.of(context).size.width - 48) /
                            _isSelected.length,
                      ),
                      focusColor: primaryColor,
                    )),
                Container(
                    child: Expanded(
                  child: SingleChildScrollView(
                      child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.55,
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      setCardEmployee(context),
                      setCardEmployee(context),
                      setCardEmployee(context),
                      setCardEmployee(context),
                      setCardEmployee(context),
                      setCardEmployee(context),
                      setCardEmployee(context),
                      setCardEmployee(context),
                      setCardEmployee(context),
                      setCardEmployee(context),
                      setCardEmployee(context),
                      setCardEmployee(context),
                      setCardEmployee(context),
                      setCardEmployee(context),
                      setCardEmployee(context),
                      setCardEmployee(context),
                    ],
                  )),
                )),
                Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: RaisedButton.icon(
                      color: primaryColor,
                      textColor: colorBg,
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        Navigator.pushNamed(context, "/employee/management");
                      },
                      icon:
                          Icon(Icons.assignment_ind, color: colorBg, size: 24),
                      label: Text("ver minhas contratações",
                          style: TextStyle(fontSize: 16)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ))
              ]),
        ));
  }
}

Widget expandido1() {
  return Text("Expandido Garçom");
}

Widget expandido2() {
  return Text("Expandido Animador");
}

Widget expandido3() {
  return Text("Expandido Buffet");
}

Widget expandido4() {
  return Text("Expandido Churrasco");
}

Widget setButtonJobTypeSelection(
        {IconData icon, String title, bool isSelected = false}) =>
    Column(children: <Widget>[
      Icon(icon),
      Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Text(title ?? ""),
      )
    ]);
