import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/card_employee.dart';
import 'package:event_uau/models/contratado_model.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/models/funcionario_model.dart';
import 'package:event_uau/providers/auth.dart';
import 'package:event_uau/service/contratado_service.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:event_uau/utils/icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeChoiceScreen extends StatefulWidget {
  const EmployeeChoiceScreen({Key key, this.eventoModel}) : super(key: key);

  final EventoModel eventoModel;

  @override
  _EmployeeChoiceScreenState createState() => _EmployeeChoiceScreenState();
}

class _EmployeeChoiceScreenState extends State<EmployeeChoiceScreen> {
  //o numero de icones abaixo tem que ser sempre igual ao comprimento desse array, se não dara erro.
  List<bool> _isSelected = [true, false, false, false, false];

  String _employeeSelected = "garçom";
  List<int> idsEscolhidos = [];
  ContratadoService contratadoService = ContratadoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EventUauAppBar(
          title: "Eu Preciso de um...",
        ),
        // backgroundColor: colorBg,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[                
                Container(                    
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ToggleButtons(
                        children: [
                          setButtonJobTypeSelection(
                              icon: EventuauIcons.garcom_logo, title: "garçom"),
                          setButtonJobTypeSelection(
                              icon: EventuauIcons.clown, title: "animador"),
                          setButtonJobTypeSelection(
                              icon: EventuauIcons.grill,
                              title: "churrasqueiro"),
                          setButtonJobTypeSelection(
                              icon: Icons.camera_enhance_outlined,
                              title: "fotógrafo"),
                          setButtonJobTypeSelection(
                              icon: EventuauIcons.grill, title: "cozinheiro"),
                        ],
                        isSelected: _isSelected,
                        onPressed: (int index) {
                          setState(() {
                            _isSelected =
                                _isSelected.map((e) => false).toList();
                            _isSelected[index] = true;
                            switch (index) {
                              case 0:
                                _employeeSelected = "garcom";
                                break;
                              case 1:
                                _employeeSelected = "animador";
                                break;
                              case 2:
                                _employeeSelected = "churrasqueiro";
                                break;
                              case 3:
                                _employeeSelected = "fotógrafo";
                                break;
                              case 4:
                                _employeeSelected = "cozinheiro";
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
                      ),
                    )),
                FutureBuilder(
                    future: contratadoService.getAllPartners(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        // Uncompleted State
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Expanded(
                              child: Center(
                            child: CircularProgressIndicator(),
                          ));
                          break;
                        default:
                          // Completed with error
                          if (snapshot.hasError) return throw snapshot.error;
                          // Completed with data
                          return (snapshot.data['total'] == 0)
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                    ),
                                    Text(
                                      "no momento não há funcionarios de prontidão",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ],
                                )
                              : Container(
                                  child: Expanded(
                                      child: SingleChildScrollView(
                                          child: GridView.count(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.7,
                                  shrinkWrap: true,
                                  primary: false,
                                  children: (snapshot.data['resultados'] as List)
                                      .where((_) => true)
                                      .where((_) => true)
                                      .map((e) => setCardEmployee(context,
                                          horas:
                                              widget.eventoModel.duracaoMinima,
                                          contratado: new ContratadoModel(
                                              nome: (e as Map<String, dynamic>)[
                                                  "usuario"]["nome"],
                                              id: (e as Map<String, dynamic>)["usuario"]
                                                  ["id"],
                                              valorHora: (e["valorHora"] as int)
                                                  .toDouble(),
                                              especialidades:
                                                  (e["especialidades"] as List)
                                                      .map((e) => JobItem(id: e["id"], descricao: e["descricao"]))
                                                      .toList(),
                                              grade: null)))
                                      .toList(),
                                ))));
                      }
                    }),
                // Container(
                //     width: double.infinity,
                //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                //     child: RaisedButton.icon(
                //       color: primaryColor,
                //       textColor: colorBg,
                //       padding: EdgeInsets.all(10),
                //       onPressed: () {
                //         Navigator.pushNamed(context, "/employee/management");
                //       },
                //       icon:
                //           Icon(Icons.assignment_ind, color: colorBg, size: 24),
                //       label: Text("ver minhas contratações",
                //           style: TextStyle(fontSize: 16)),
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(25)),
                //     ))
              ]),
        ));
  }
}

Widget setButtonJobTypeSelection(
        {IconData icon, String title, bool isSelected = false}) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(children: <Widget>[
        Icon(icon),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(title ?? ""),
        )
      ]),
    );
