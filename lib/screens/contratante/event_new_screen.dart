import 'package:event_uau/components/address_search.dart';
import 'package:event_uau/models/address_model.dart';

import 'package:event_uau/providers/auth.dart';
import 'package:event_uau/providers/event.dart';

import 'package:event_uau/service/event_service.dart' as EventService;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventNewScreen extends StatefulWidget {
  const EventNewScreen({Key key}) : super(key: key);

  @override
  _EventNewScreenState createState() => _EventNewScreenState();
}

class _EventNewScreenState extends State<EventNewScreen> {
  final TextEditingController _startDateText = new TextEditingController();
  final TextEditingController _endDateText = new TextEditingController();
  final GlobalKey<FormState> _formKeyNewEvent = new GlobalKey<FormState>();
  bool loading = false;
  final Map<String, dynamic> _formValues = {
    'eventName': null,
    'description': null,
    'startDate': null,
    'endDate': null,
  };
  AddressModel address;

  void _onSubmit() async {
    if (!_formKeyNewEvent.currentState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
              "Erro ao criar evento, verifique se os dados estão válidos")));
    }
    _formKeyNewEvent.currentState.save();

    final _event = new EventItem(
      address: address,
      name: _formValues['eventName'],
      description: _formValues['description'],
      startDate: _formValues['startDate'],
      endDate: _formValues['endDate'],
    );

    try {
      setState(() {
        loading = true;
      });
      await Provider.of<Event>(context, listen: false).createEvent(_event);

      Navigator.pop(context);
    } catch (e) {
      setState(() {
        loading = false;
      });
    }    
  }

  @override
  Widget build(BuildContext context) {
    final fetchedAddress = Provider.of<Auth>(context).user.address;
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar evento'),
        actions: [
          !loading
              ? IconButton(
                  icon: Icon(Icons.check, color: Colors.green),
                  onPressed: _onSubmit)
              : Container(
                  padding: EdgeInsets.only(right: 12, top: 16, bottom: 18),
                  width: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKeyNewEvent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(labelText: 'Nome do evento'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Campo Obrigatório";
                    }
                    return null;
                  },
                  onSaved: (value) => _formValues['eventName'] = value,
                ),
                TextFormField(
                    decoration: InputDecoration(
                      labelText: "Breve descrição do evento",
                    ),
                    validator: (value) {
                      if (value.toString().length > 150) {
                        return "texto excedeu o limite de 150 caracteres";
                      }
                      return null;
                    },
                    onSaved: (value) =>
                        _formValues['descricao'] = value ?? null),
                TextFormField(
                  focusNode: new AlwaysDisabledFocusNode(),
                  controller: _startDateText,
                  decoration: InputDecoration(
                      labelText: 'Data e Hora Inicial do Evento'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo Obrigatório'
                      : null,
                  keyboardType: TextInputType.none,
                  onTap: () async {
                    // FocusScope.of(context).requestFocus(new FocusNode());
                    final startDay = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        Duration(days: 90),
                      ),
                    );
                    if (startDay == null) return;

                    final startTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (startTime == null) return;

                    _formValues['startDate'] = new DateTime(
                      startDay.year,
                      startDay.month,
                      startDay.day,
                      startTime.hour,
                      startTime.minute,
                    );
                    _startDateText.text =
                        '${DateFormat.yMMMMd('pt_BR').format(_formValues['startDate'])} - ${DateFormat.Hm('pt_BR').format(_formValues['startDate'])}';
                  },
                ),
                TextFormField(
                  focusNode: new AlwaysDisabledFocusNode(),
                  controller: _endDateText,
                  decoration:
                      InputDecoration(labelText: 'Data e Hora Final do Evento'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Campo Obrigatório'
                      : null,
                  onTap: () async {
                    // FocusScope.of(context).requestFocus(new FocusNode());
                    final startDay = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(
                        Duration(days: 90),
                      ),
                    );
                    if (startDay == null) return;

                    final startTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (startTime == null) return;

                    _formValues['endDate'] = new DateTime(
                      startDay.year,
                      startDay.month,
                      startDay.day,
                      startTime.hour,
                      startTime.minute,
                    );

                    _endDateText.text =
                        '${DateFormat.yMMMMd('pt_BR').format(_formValues['endDate'])} - ${DateFormat.Hm('pt_BR').format(_formValues['endDate'])}';
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Endereço',
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8),
                      child: Text(
                        address?.toString() ??
                            fetchedAddress?.toString() ??
                            'Adicione um endereço',
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      child: Icon(
                        Icons.edit,
                        size: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () async {
                        final newAddress = await showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => AddressSearch(
                            initialValue: address,
                          ),
                        );
                        if (newAddress != null)
                          setState(() {
                            address = newAddress;
                          });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
