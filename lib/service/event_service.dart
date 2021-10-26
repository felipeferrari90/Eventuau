import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../providers/event.dart';
import '../providers/auth.dart';

const baseUrl = 'https://10.0.2.2:6011/api';

const Map<String, String> headers = {
  "Content-Type": "application/json",
};

final userData = Auth();

Future<Map> getEvents() async {
  final res = await http.get('$baseUrl/eventos',
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${userData.token}'});

  if (res.statusCode != 200) throw res;

  return json.decode(res.body);
}

Future<Map> fetchEventById(int id) async {
  final url = '$baseUrl/eventos/$id';
  final headers = {HttpHeaders.authorizationHeader: 'Bearer ${userData.token}'};

  final res = await http.get(url, headers: headers);

  if (res.statusCode != 200) throw res;

  return json.decode(res.body);
}

Future<int> postEvent(EventItem event) async {
  var _headers = {HttpHeaders.authorizationHeader: 'Bearer ${userData.token}'};
  var body = json.encode({
    'nome': event.name,
    'descricao': event.description,
    'dataInicio': event.startDate.toIso8601String(),
    'dataTermino': event.endDate.toIso8601String(),
  });

  final res = await http
      .post('$baseUrl/eventos', body: body, headers: {...headers, ..._headers});

  if (res.statusCode > 201) throw res;

  final responseBody = json.decode(res.body);

  return responseBody['id'];
}

Future<dynamic> getEventAddress(int eventId) async {
  final url = 'https://10.0.2.2:6031/api/eventos/$eventId/enderecos';
  final headers = {HttpHeaders.authorizationHeader: 'Bearer ${userData.token}'};

  final res = await http.get(url, headers: headers);

  if (res.statusCode != 200) throw res;

  return json.decode(res.body)[0];
}

Future<bool> acceptProposal(int eventId) async {
  final url = '$baseUrl/eventos/$eventId/propostas';
  final _headers = {
    ...headers,
    HttpHeaders.authorizationHeader: 'Bearer ${userData.token}',
  };

  final res = await http.put(url, headers: _headers, body: json.encode({}));

  if (res.statusCode != 200) return false;

  return true;
}
