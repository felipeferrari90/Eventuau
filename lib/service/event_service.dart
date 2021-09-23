import 'dart:convert';
import 'dart:io';
import '../providers/event.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://10.0.2.2:6011/api';

const Map<String, String> headers = {
  "Content-Type": "application/json",
};

class EventService {
  static Future<Map> getEvents() async {
    final res = await http.get('$baseUrl/eventos');

    if (res.statusCode != 200) throw res;

    return json.decode(res.body);
  }

  static Future<void> postEvent(EventItem event) async {
    var body = json.encode({      
      'nome': event.name,
      'descricao': event.description,
      'dataInicio': event.startDate.toIso8601String(),
      'dataTermino': event.endDate.toIso8601String(),
      'duracaoMinima': event.minDuration,
      'duracaoMaxima': event.maxDuration
    });

    final res =
        await http.post('$baseUrl/eventos', body: body, headers: headers);

    if (res.statusCode != 200) throw res;

    return json.decode(res.body);
  }
}
