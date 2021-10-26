import 'package:event_uau/models/contratado_model.dart';
import 'package:event_uau/models/funcionario_model.dart';
import 'package:event_uau/screens/contratante/employee_screen_description.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:event_uau/utils/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    Key key,
    this.isSelected = false,
    this.contratado,
    this.horas,
    this.choose,
  }) : super(key: key);

  final bool isSelected;
  final ContratadoModel contratado;
  final double horas;
  final Function choose;

  @override
  Widget build(BuildContext context) {
    final valorFinal = horas * contratado.valorHora;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => choose(contratado.id),
        child: Stack(
          children: [
            Image(
              image: AssetImage('assets/images/waiter.png'),
              width: double.infinity,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                height: 137,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        '${contratado.nome}, ${DateTime.now().year - contratado.birthDate.year}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_outlined,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        Text('Novo!'),
                        SizedBox(
                          width: 12,
                        ),
                        Icon(
                          Icons.attach_money,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        Text('${contratado.valorHora}/h'),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        'Jornada de trabalho: 1h+',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        'Valor Total: R\$${valorFinal.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton.icon(
                        onPressed: () => choose(contratado.id),
                        icon: Icon(
                          !isSelected
                              ? Icons.check_box_outline_blank
                              : Icons.check_box,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                        label: Text(
                          isSelected ? 'Remover' : 'Selecionar',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
