import 'dart:io';

import 'package:event_uau/models/address_model.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/providers/auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'auth_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../service/maps_service.dart' as MapsService;

AddressModel setEventAddressModel(Map<String, dynamic> jsonResponse) {
  return AddressModel(
      id: jsonResponse['id'],
      latitude: jsonResponse['latitude'] ?? "12.0",
      longitude: jsonResponse['longitude'] ?? "12.0",
      cep: jsonResponse['cep'],
      numero: jsonResponse['numero'] ?? "",
      complemento: jsonResponse['complemento'] ?? "",
      rua: jsonResponse['logradouro'],
      cidade: jsonResponse['cidade'],
      estado: jsonResponse['estado'],
      bairro: jsonResponse['bairro'],
      tipoEnd: AddressType.Event);
}

Future<Map> createEventAddress(
    AddressModel addressDataEvent, int idEvent) async {
  final baseUrl = 'https://10.0.2.2:6031/api/eventos/$idEvent/enderecos';

  final coords = await MapsService.fetchLatAndLongByAddress(
      '${addressDataEvent.cep} ${addressDataEvent.rua} ${addressDataEvent.numero}');

  addressDataEvent.latitude = coords['lat'];
  addressDataEvent.longitude = coords['long'];

  final res = await http.post(baseUrl,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${userData.token}',
        HttpHeaders.contentTypeHeader: 'application/json'
      },
      body: addressDataEvent.apiPayload);

  if (res.statusCode != 200) throw HttpException(json.decode(res.body));

  return json.decode(res.body);
}
