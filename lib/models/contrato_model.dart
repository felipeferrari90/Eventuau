import 'package:event_uau/models/funcionario_model.dart';

import 'evento_model.dart';

class ContratoModel{
  EventoModel evento;
  FuncionarioModel funcionario;
  int notaFuncionario;
  int notaEvento;
  StatusContrato statusContrato;
  DateTime horaMatch = DateTime.now();
  DateTime horaSaidaEvento;
  double valorAmaisASerPago = 0.00;
}

enum StatusContrato {
  PARCIAL_MATCH, MATCH, FECHADO, TERMINADO, CANCELADO
}