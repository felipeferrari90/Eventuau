import 'package:event_uau/components/employee/employee_event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({Key key}) : super(key: key);

  static const routeName = '/event/details';
  final bool _showPrices = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resumo do evento'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Field(
              label: 'Nome do Evento',
              value: 'Churrasco na Brasilândia',
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Field(
                    label: 'Data de Inicio',
                    value: '31/12/2021',
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Field(
                    label: 'Data de Término',
                    value: '31/12/2021',
                  ),
                )
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Field(
                    label: 'Horário de Inicio',
                    value: '11:30',
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Field(
                    label: 'Horário de Término',
                    value: '16:30',
                  ),
                )
              ],
            ),
            Field(
              label: 'Endereço',
              value: 'Rua das Abóboras 4600, Brasilândia - São Paulo - SP',
            ),
            Center(
              child: Text(
                'falta add o google maps',
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Title('Assistentes selecionados'),
            SizedBox(
              height: 12,
            ),
            EventCardEmployee(trailing: null),
            SizedBox(
              height: 12,
            ),
            if (_showPrices)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Title('Total:'), Title('R\$160,00')],
              )
          ],
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title(
    @required this.text, {
    Key key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline2
          .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class Field extends StatelessWidget {
  const Field({Key key, @required this.label, @required this.value})
      : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 3,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 18,
      ),
      readOnly: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        label: Text(label),
        labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).primaryColor),
      ),
      initialValue: value,
    );
  }
}
