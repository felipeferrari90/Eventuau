import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:event_uau/models/contratante_model.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/repository/evento_repository.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EventNewScreen extends StatefulWidget {
  const EventNewScreen({Key key}) : super(key: key);

  @override
  _EventNewScreenState createState() => _EventNewScreenState();

}

class _EventNewScreenState extends State<EventNewScreen> {
  StatusContratacaoEvento _valueDropdownStatusEvent = StatusContratacaoEvento.CONTRATANDO_FUNCIONARIOS;
  
  final GlobalKey<FormState> _formKeyNewEvent = new GlobalKey<FormState>();

  EventoModel eventoModel = new EventoModel();
  ContratanteModel contratanteModel = new ContratanteModel();

  void _onSubmit() {
    
    if (!_formKeyNewEvent.currentState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
              "erro ao criar evento, verifique se os dados estão validos"))); 
    }
    _formKeyNewEvent.currentState.save();
    EventoRepository eventoRepository = new EventoRepository();
    eventoRepository.insert(eventoModel);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EventUauAppBar(title: "Criar Evento", username: "Antonio conceicao"),
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
                          eventoModel.nome = value?? "Sem titulo";
                          debugPrint(eventoModel.nome);
                    });
                  },
                ),
                /*
                TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 7, 
                    decoration: InputDecoration(
                      fillColor: colorBg,
                      hintText: "descrição sobre o evento",
                      hintStyle: TextStyle(color: Colors.black54),
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
                        this._eventoModel.descricao = value.toString();
                        debugPrint(this._eventoModel.descricao);
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
                        this._eventoModel.dataEHorarioInicio =
                        DateFormat.yMd("pt_BR").parse(value);
                        debugPrint(this._eventoModel.dataEHorarioInicio.toString());
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
                    /*
                    if (!RegExp(r"/^[0-2]?[0-9]:[0-5][0-9]$/")
                        .hasMatch(value.toString())) {
                         debugPrint(value);
                      return "digite uma Hora valida";
                    }*/
                    if(value.isEmpty){
                      return "digite uma hora valida";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      var _ponteiros = (value).split(":");
                      this._eventoModel.dataEHorarioInicio.add(Duration(
                        hours: int.parse(_ponteiros[0]),
                        minutes: int.parse(_ponteiros[1])));
                    });
                    debugPrint(this._eventoModel.dataEHorarioInicio.toString());
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(labelText: 'Duracao Minima'),
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    HoraInputFormatter(),
                  ],
                  validator: (value) {
                    /*
                    if (!RegExp(r"/^(02[0-3]):([0-5][0-9])$/")
                        .hasMatch(value)) {
                      return "digite um tempo valido";
                    }*/
                    DateTime tempo =
                        DateFormat.Hm("pt_BR").parse(value);
                    if (tempo.hour > 20 || tempo.hour < 1) {
                      return "evento deve ter um tempo minimo entre 1 a 23 horas";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      var _ponteiros = (value).split(":");
                      this._eventoModel.tempoDuracaoMinimoPreDeterminado = Duration(
                        hours: int.parse(_ponteiros[0]),
                        minutes: int.parse(_ponteiros[1]));
                      if ( this._eventoModel.tempoDuracaoMaximoPreDeterminado == null) {
                        this._eventoModel.tempoDuracaoMaximoPreDeterminado =
                        this._eventoModel.tempoDuracaoMinimoPreDeterminado;
                      }
                      debugPrint(this._eventoModel.tempoDuracaoMaximoPreDeterminado.toString());
                    });
                  
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(labelText: 'Duracao Maxima'),
                  textInputAction: TextInputAction.next,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    HoraInputFormatter(),
                  ],
                  validator: (value) {
                    /*
                    if ( this._eventoModel.tempoDuracaoMinimoPreDeterminado == null) {
                      return "digite primeiro o tempo minimo";
                    }
                    if (!RegExp(r"/^(02[0-3]):([0-5][0-9])$/")
                        .hasMatch(value.toString())) {
                      return "digite um tempo valido";
                    }
                    DateTime tempo =
                        DateFormat.Hm("pt_BR").parse(value);
                    if (tempo.hour > 20 || tempo.hour < 1) {
                      return "evento deve ter um tempo maximo entre 1 a 22 horas";
                    }
                    if ( this._eventoModel.tempoDuracaoMinimoPreDeterminado == null) {
                      return "digite primeiro o tempo minimo";
                    }
                    if (tempo.microsecondsSinceEpoch <
                        this._eventoModel
                            .tempoDuracaoMinimoPreDeterminado.inMicroseconds) {
                      return "tempo maximo deve ser maior que o tempo minimo";
                    }*/
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                        var _ponteiros = value.toString().split(":");
                        this._eventoModel.tempoDuracaoMinimoPreDeterminado = Duration(
                        hours: int.parse(_ponteiros[0]),
                        minutes: int.parse(_ponteiros[1]));
                        debugPrint(this._eventoModel.tempoDuracaoMaximoPreDeterminado.toString());
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
                          value: StatusContratacaoEvento.SEM_CONTRATAR,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "CONTRATANDO",
                            style: TextStyle(fontSize: 12),
                            overflow: TextOverflow.clip,
                          ),
                          value: StatusContratacaoEvento.CONTRATANDO_FUNCIONARIOS,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "TODOS JA CONTRATADOS",
                            overflow: TextOverflow.clip,
                            style: TextStyle(fontSize: 12),
                          ),
                          value: StatusContratacaoEvento.FUNCIONARIOS_CONTRATADOS,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          this._eventoModel.statusContratacaoEvento = value;
                           debugPrint(this._eventoModel.statusContratacaoEvento.toString());
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
                      "maximo numero de funcionarios a serem contratados do tipo...",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: primaryColor)),
                ),
                SizedBox(height: 24),
                ListTile(
                    leading: Text(
                      "GARÇOM",
                      style: TextStyle(fontSize: 16, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                    trailing: SizedBox(
                      width: 50,
                      child: TextFormField(
                        validator:(value) {
                          int numero = int.parse(value);
                          if(numero >= 0){
                              return null;
                          }
                          return "escolha um numero maior que 0";
                        },
                        onSaved: (value){
                          setState(() {
                            this._eventoModel.numeroMaximoDeGarcons = value as int;
                             debugPrint(this._eventoModel.numeroMaximoDeGarcons.toString());
                          });
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
                  )
                ),
                ListTile(
                    leading: Text(
                      "ANIMADOR",
                      style: TextStyle(fontSize: 16, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                    trailing: SizedBox(
                      width: 50,
                      child: TextFormField(
                        validator:(value) {
                          int numero = int.parse(value);
                          if(numero >= 0){
                              return null;
                          }
                          return "escolha um numero maior que 0";
                        },
                        onSaved: (value){
                          setState(() {
                              this._eventoModel.numeroMaximoDeAnimadores = value as int;
                               debugPrint(this._eventoModel.numeroMaximoDeAnimadores.toString());
                          });
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
                  )
                ),
                ListTile(
                    leading: Text(
                      "BUFFET",
                      style: TextStyle(fontSize: 16, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                    trailing: SizedBox(
                      width: 50,
                      child: TextFormField(
                        validator:(value) {
                          int numero = int.parse(value);
                          if(numero >= 0){
                              return null;
                          }
                          return "escolha um numero maior que 0";
                        },
                        onSaved: (value){
                          setState(() {
                                this._eventoModel.numeroMaximoDeBuffets = value as int;
                                 debugPrint(this._eventoModel.numeroMaximoDeBuffets.toString());
                          });
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
                  )
                ),
                ListTile(
                    leading: Text(
                      "CHURRASQUEIRO",
                      style: TextStyle(fontSize: 16, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                    trailing: SizedBox(
                      width: 50,
                      child: TextFormField(
                        validator:(value) {
                          int numero = int.parse(value);
                          if(numero >= 0){
                              return null;
                          }
                          return "escolha um numero maior que 0";
                        },
                        onSaved: (value){
                          setState(() {
                            this._eventoModel.numeroMaximoDeChurrasqueiros = value as int;
                             debugPrint(this._eventoModel.numeroMaximoDeChurrasqueiros.toString());
                          });
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
                  )
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, "/employees");
                    },
                    icon: Icon(Icons.search, size: 16, color: primaryColor),
                    label: Text("IR PRA TELA DE ESCOLHAS", style: TextStyle(
                        color: primaryColor,
                      )
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        this._eventoModel.observacoes = value?? "sem observacoes";
                         debugPrint(this._eventoModel.observacoes);
                      });
                    },
                    decoration: InputDecoration(
                      fillColor: colorBg,
                      hintText: "observacoes sobre o evento para os funcionarios contratados",
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
                        padding: EdgeInsets.all(8)
                    ),
                    icon: Icon(Icons.assignment_ind, size: 16),
                    label: Text("GERENCIADOR DE FUNCIONARIOS"),
                  ),
                ),
<<<<<<< HEAD
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
                        Text("R\$ ${contratanteModel.valorEmCaixaDisponivel?? "0,00"}",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.w700)),
                      ]),
                ),
                */
                SizedBox(height: 24),
                setButton(
                    text: "Publicar evento",
                    uppercase: true,
                    function:  _onSubmit,
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
