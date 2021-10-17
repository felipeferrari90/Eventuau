import 'package:event_uau/components/employee/employee_event_card.dart';
import 'package:event_uau/providers/employee_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({Key key}) : super(key: key);

  static const routeName = '/event/details';
  final bool _showPrices = false;

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as int;
    final eventData = Provider.of<EmployeeEvents>(context).getById(id);
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
              value: eventData.name,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Field(
                    label: 'Data de Inicio',
                    value: DateFormat('dd/M/yyyy').format(eventData.startDate),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Field(
                    label: 'Data de Término',
                    value: DateFormat('dd/M/yyyy').format(eventData.endDate),
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
                    value: DateFormat.Hm('pt_BR').format(eventData.startDate),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Field(
                    label: 'Horário de Término',
                    value: DateFormat.Hm('pt_BR').format(eventData.endDate),
                  ),
                )
              ],
            ),
            Field(
                label: 'Endereço',
                value:
                    '${eventData.address.cep} - ${eventData.address.bairro}, ${eventData.address.cidade}'),
            Center(
              child: Text(
                'falta add o google maps',
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text('PROPOSTA',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Preço por hora:'), Text('R\$70,00')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tempo de Evento:'),
                Text(
                    '${eventData.startDate.hour - eventData.endDate.hour} Horas')
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal:',
                ),
                Text(
                  'R\$${((eventData.startDate.hour - eventData.endDate.hour) * 70.00).toStringAsFixed(2)}',
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Taxa EventUau (15%):',
                ),
                Text(
                  'R\$${(((eventData.startDate.hour - eventData.endDate.hour) * 70.00) * 0.15).toStringAsFixed(2)}',
                )
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal:',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  'R\$${((eventData.startDate.hour - eventData.endDate.hour) * 70.00).toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headline5,
                )
              ],
            ),
            // Title('Assistentes Selecionados'),
            // SizedBox(
            //   height: 12,
            // ),
            // EventCardEmployee(trailing: null),
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
