import 'package:event_uau/models/funcionario_model.dart';

import '../providers/auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

import '../models/contratado_model.dart';

var signupUrl = 'https://10.0.2.2:6001/api/parceiros';
final userData = Auth();

Future<void> signup(double hourlyRate, List<JobItem> selectedJobs) async {
  final body = json.encode({
    'valorHora': hourlyRate,
    'especialidades':
        selectedJobs.map((e) => {'id': e.id, 'descricao': e.descricao}).toList()
  });

  final res = await http.post('$signupUrl',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ${userData.token}'
      },
      body: body);

  if (res.statusCode != 200) throw json.decode(res.body);
}

Future<Map<String, dynamic>> getParceiroInfoById(int userId) async {
  final res = await http.get('$signupUrl/$userId',
      headers: {HttpHeaders.authorizationHeader: 'Bearer ${userData.token}'});

  if (res.statusCode != 200) throw json.decode(res.body);

  return json.decode(res.body);
}

class ContratadoService {
  static Future getEspecialidadesById(int id) async {
    final res = await http.get('$signupUrl/$id', headers: headers);
    if (res.statusCode != 200) throw HttpException(json.decode(res.body));
    return json.decode(res.body)['especialidades'];
  }

  static Future<List<String>> getEspecialidadesDescriptionById(int id) async {
    final res = await http.get('$signupUrl/$id', headers: headers);
    if (res.statusCode != 200) throw HttpException(json.decode(res.body));
    List especialidades = json.decode(res.body)['especialidades'] as List;
    List especialidadesDescricao =
        especialidades.map((e) => e["descricao"] as String).toList();
    return especialidadesDescricao;
  }

  Future<Map<String, dynamic>> getAllPartners() async {
    final res = await http.get('$signupUrl', headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${userData.token}'
    });
    if (res.statusCode != 200) throw HttpException(json.decode(res.body));
    print("CHEGOU AQUI" + res.body);
    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
