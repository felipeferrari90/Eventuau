import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/models/funcionario_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

import '../screens/profissional/employee_signup/employee_signup.dart';
import '../service/maps_service.dart' as MapsService;

import '../models/address_model.dart';
import '../providers/auth.dart';

var baseUrl = 'https://10.0.2.2:6031/api/usuarios/';
var signupUrl = 'https://10.0.2.2:6001/api/parceiros';

final headers = {
  HttpHeaders.authorizationHeader: 'Bearer ${userData.token}',
  HttpHeaders.contentTypeHeader: 'application/json'
};

final userData = Auth();

Future<void> createAddress(AddressModel addressData) async {
  final coords = await MapsService.fetchLatAndLongByAddress(
      '${addressData.cep} ${addressData.rua} ${addressData.numero}');

  addressData.latitude = coords['lat'];
  addressData.longitude = coords['long'];

  final res = await http.post('$baseUrl/${userData.user.id}/enderecos',
      headers: headers, body: addressData.apiPayload);

  if (res.statusCode != 200) throw HttpException(json.decode(res.body));
}

Future<void> signup(double hourlyRate, List<JobItem> selectedJobs) async {
  final body = json.encode({
    'valorHora': hourlyRate,
    'especialidades':
        selectedJobs.map((e) => {'id': e.id, 'descricao': e.descricao}).toList()
  });

  final res = await http.post('$signupUrl', headers: headers, body: body);

  if (res.statusCode != 200) throw HttpException(json.decode(res.body));
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
    final res = await http.get('$signupUrl', headers: headers);
    if (res.statusCode != 200) throw HttpException(json.decode(res.body));
    print(res.body);
    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
