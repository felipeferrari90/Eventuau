import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:event_uau/models/contratante_model.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/providers/auth.dart';
import 'package:event_uau/providers/evento_provider.dart';
import 'package:event_uau/service/evento_service.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class EventNewScreen extends StatefulWidget {
  const EventNewScreen({Key key}) : super(key: key);

  @override
  _EventNewScreenState createState() => _EventNewScreenState();
}

class _EventNewScreenState extends State<EventNewScreen> {
  StatusEvento _valueDropdownStatusEvent;

  final GlobalKey<FormState> _formKeyNewEvent = new GlobalKey<FormState>();

  EventoModel eventoModel = new EventoModel();
  ContratanteModel contratanteModel = new ContratanteModel();

  void _onSubmit() async {
    if (!_formKeyNewEvent.currentState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
              "erro ao criar evento, verifique se os dados estão validos")));
    }
    _formKeyNewEvent.currentState.save();
    EventoProvider eventoProvider = new EventoProvider();
    eventoProvider.createEvent(eventoModel).then((_) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EventUauAppBar(
          title: "Criar Evento",
          username: Provider.of<Auth>(context).user.name),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKeyNewEvent,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(labelText: 'Nome do evento'),
                  inputFormatters: [],
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Campo Obrigatório";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      eventoModel.nome = value ?? "Sem titulo";
                    });
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    decoration: InputDecoration(
                      fillColor: colorBg,
                      hintText: "descrição sobre o evento",
                      hintStyle: TextStyle(color: Colors.black54),
                      contentPadding: EdgeInsets.all(16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: (value) {
                      if (value.toString().length > 150) {
                        return "texto excedeu o limite de 150 caracteres";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        eventoModel.descricao =
                            value.toString() ?? "sem descricao";
                      });
                    }),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(labelText: 'Data do evento'),
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DataInputFormatter(),
                  ],
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Campo Obrigatório";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      print(value);
                      initializeDateFormatting('pt_BR', null);
                      eventoModel.dataEHorarioInicio =
                          DateFormat.yMd("pt_BR").parse(value);
                      debugPrint(eventoModel.dataEHorarioInicio.toString());
                    });
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(labelText: 'Hora do evento'),
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    HoraInputFormatter()
                  ],
                  validator: (value) {
                    if (value.isEmpty) {
                      return "digite uma hora valida";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      print(value);
                      var _ponteiros = (value).split(":");
                      eventoModel.dataEHorarioInicio =
                          eventoModel.dataEHorarioInicio.add(Duration(
                              hours: int.parse(_ponteiros[0]),
                              minutes: int.parse(_ponteiros[1])));
                    });
                    debugPrint(eventoModel.dataEHorarioInicio.toString());
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration:
                      InputDecoration(labelText: 'Duracao (em horas exatas)'),
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    int valor = int.parse(value);
                    if (valor > 22 || valor < 1) {
                      return "evento deve ter um tempo minimo entre 1 a 23 horas";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      int valueInteiro = int.parse(value);
                      eventoModel.duracaoMinima = valueInteiro;
                      Duration valueDurationType =
                          Duration(hours: valueInteiro);
                      eventoModel.dataEHorarioTermino =
                          eventoModel.dataEHorarioInicio.add(valueDurationType);
                      debugPrint(eventoModel.dataEHorarioTermino.toString());
                    });
                  },
                ),
                ListTile(
                  leading: Text(
                    "Status Contratacao: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  title: DropdownButton(
                      value: _valueDropdownStatusEvent,
                      dropdownColor: Color.fromRGBO(255, 255, 255, 1.0),
                      style: TextStyle(
                          fontSize: 12,
                          color: primaryColor,
                          fontWeight: FontWeight.w700),
                      focusColor: primaryColor,
                      itemHeight: 50,
                      elevation: 12,
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            "SEM CONTRATAR",
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.clip,
                          ),
                          value: StatusEvento.CONTRATANDO,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "CONTRATANDO",
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.clip,
                          ),
                          value: StatusEvento.FECHADO,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          eventoModel.status = value;
                          debugPrint(eventoModel.status.toString());
                        });
                      }),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 0, 2),
                  child: Text("Contrate funcionarios para seu evento",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 4, 0, 4),
                  child: Text(
                      "navegue pela tela de escolhas para enviar propostas a funcionarios para trabalhar pro seu evento...",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor)),
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, "/employees");
                    },
                    icon: Icon(Icons.search, size: 16, color: primaryColor),
                    label: Text("IR PRA TELA DE ESCOLHAS",
                        style: TextStyle(
                          color: primaryColor,
                        )),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      primary: secundaryColor,
                      onSurface: colorBg,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 0, 2),
                  child: Text("Gerencie funcionarios que ja foram contratados",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.black)),
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    validator: (value) {
                      if (value.length > 150) {
                        return "observação do evento deve ter menos de 250 caracteres";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        eventoModel.observacoes = value ?? "sem observacoes";
                        debugPrint(eventoModel.observacoes);
                      });
                    },
                    decoration: InputDecoration(
                      fillColor: colorBg,
                      contentPadding: EdgeInsets.all(16.0),
                      hintText:
                          "observacoes sobre o evento para os funcionarios contratados",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, "/employee/management");
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        primary: primaryColor,
                        padding: EdgeInsets.all(8)),
                    icon: Icon(Icons.assignment_ind, size: 16),
                    label: Text("GERENCIADOR DE FUNCIONARIOS"),
                  ),
                ),
                Divider(),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("VALOR TOTAL:  ",
                            style: TextStyle(
                                fontSize: 16,
                                color: primaryColor,
                                fontWeight: FontWeight.w700)),
                        Text("350,00",
                            style: TextStyle(
                                fontSize: 24,
                                color: primaryColor,
                                fontWeight: FontWeight.w700)),
                      ]),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("saldo disponivel: ",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700)),
                        Text(
                            "R\$ ${contratanteModel.valorEmCaixaDisponivel ?? "0,00"}",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.w700)),
                      ]),
                ),
                SizedBox(height: 24),
                setButton(
                  text: "Publicar evento",
                  uppercase: true,
                  function: _onSubmit,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _setFieldTypeEmployeeSettings({String text}) => ListTile(
      leading: Text(
        text ?? "",
        style: TextStyle(fontSize: 16, height: 1.5),
        textAlign: TextAlign.center,
      ),
      trailing: SizedBox(
        width: 50,
        child: TextFormField(
          validator: (value) {
            int numero = int.parse(value);
            if (numero >= 0) {
              return null;
            }
            return "escolha um numero maior que 0";
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "0",
            isCollapsed: true,
            alignLabelWithHint: true,
            contentPadding: EdgeInsets.symmetric(vertical: 4),
            border: OutlineInputBorder(),
          ),
        ),
      ));
}
