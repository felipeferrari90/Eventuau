import 'package:event_uau/models/funcionario_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:event_uau/service/auth_service.dart' as AuthService;
import '../service/contratado_service.dart';
import '../service/maps_service.dart' as MapsService;
import '../service/upload_service.dart' as UploadService;
import '../models/contratado_model.dart';
import '../models/address_model.dart';

import '../models/signup_model.dart';

const Map<String, String> headers = {
  "Content-Type": "application/json",
};

class User {
  int id;
  String name;
  String cpf;
  AddressModel address;
  String phone;
  String aboutMe;
  DateTime birthDate;
  String status;
  File profilePicture;
  ContratadoModel partnerData;

  User({
    @required this.id,
    @required this.name,
    @required this.cpf,
    @required this.address,
    @required this.phone,
    @required this.aboutMe,
    @required this.birthDate,
    @required this.status,
    this.profilePicture,
  });

  File get userProfilePicture {
    return profilePicture != null ? new File(profilePicture.path) : null;
  }

  bool get isPartner {
    return partnerData != null;
  }

   String get initials => name.split(' ').reduce(
      (value, element) => value.characters.first + element.characters.first);
  

  Map<String, dynamic> get userInfoPayload => {
        'id': this.id,
        'nome': this.name,
        'sobreMim': this.aboutMe,
        'endereco': this.address,
        'dataNascimento': this.birthDate.toIso8601String(),
        'cpf': this.cpf,
        'telefone': this.phone,
        'status': this.status,
      };
}

class Auth with ChangeNotifier {
  static final Auth _auth = Auth._internal();
  String _token;
  User user;

  // SINGLETON TO ACCESS USER DATA ON API`S
  // https://stackoverflow.com/questions/12649573/how-do-you-build-a-singleton-in-dart
  factory Auth() {
    return _auth;
  }
  Auth._internal();

  String get token {
    return _token;
  }

  bool get isAuth {
    _token != null ? print(_token) : print("nao tem token");
    return _token != null;
  } 

  Future<void> login(String email, String senha) async {
    final response = await AuthService.login(email, senha);

    _token = response['token'];
    Map<String, dynamic> _userData = response['usuario'];

    user = new User(
      id: _userData['id'],
      name: _userData['nome'],
      aboutMe: _userData['sobreMim'],
      address: _userData['endereco'],
      birthDate: DateTime.parse((_userData['dataNascimento'])),
      cpf: _userData['cpf'],
      phone: _userData['telefone'],
      status: _userData['status'],
    );

    getProfilePicture();
    await getPartnerInfo();
    await getAddress();
  }

  void signout() {
    _token = null;
    notifyListeners();
  }

  Future<void> getPartnerInfo() async {
    try {
      final res = await getParceiroInfoById(user.id);

      user.partnerData = new ContratadoModel(
          grade: null, //TODO CHANGE TO VALUE FROM ENDPOINT
          valorHora: res['valorHora'],
          especialidades: (res['especialidades'] as List)
              .map((e) => new JobItem(id: e['id'], descricao: e['descricao']))
              .toList());

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void updateUserInfo(Map<String, dynamic> newData) async {
    try {
      final _userData =
          await AuthService.updateUser({...user.userInfoPayload, ...newData});

      print(_userData);
      user = new User(
        id: _userData['id'],
        name: _userData['nome'],
        aboutMe: _userData['sobreMim'],
        address: _userData['endereco'],
        birthDate: DateTime.parse((_userData['dataNascimento'])),
        cpf: _userData['cpf'],
        phone: _userData['telefone'],
        status: _userData['status'],
      );
      notifyListeners();
    } catch (e) {
      print(json.decode(e.body));
      if (e?.statusCode == 401) signout();
      throw e;
    }
  }

  Future<void> getAddress() async {
    final url = 'https://10.0.2.2:6031/api/usuarios/${user.id}/enderecos/1';
    final _headers = {
      ...headers,
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
    try {
      final res = await http.get(url, headers: _headers);

      if (res.statusCode != 200) throw json.decode(res.body);

      final responseBody = json.decode(res.body);

      user.address = new AddressModel(
        numero: responseBody['numero'],
        complemento: responseBody['complemento'],
        id: responseBody['id'],
        longitude: responseBody['longitude'],
        latitude: responseBody['latitude'],
        cep: responseBody['cep'],
        rua: responseBody['logradouro'],
        bairro: responseBody['bairro'],
        cidade: responseBody['cidade'],
        estado: responseBody['estado'],
      );
    } catch (e) {
      print(e);
      user.address = null;
    }

    notifyListeners();
  }

  Future<void> createAddress(AddressModel addressData) async {
    final baseUrl = 'https://10.0.2.2:6031/api/usuarios';
    final _headers = {
      ...headers,
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };

    final coords = await MapsService.fetchLatAndLongByAddress(
        '${addressData.cep} ${addressData.rua} ${addressData.numero}');

    addressData.latitude = coords['lat'];
    addressData.longitude = coords['long'];

    final res = await http.post('$baseUrl/${user.id}/enderecos',
        headers: _headers, body: addressData.apiPayload);

    if (res.statusCode != 200) throw HttpException(json.decode(res.body));
  }

  void setContratanteInfo(double valorHora, List<JobItem> especialidades) {
    user.partnerData = new ContratadoModel(
        valorHora: valorHora, especialidades: especialidades, grade: null);

    notifyListeners();
  }

  set userProfilePicture(File profilePicture) {
    user.profilePicture = profilePicture;
    notifyListeners();
  }

  void getProfilePicture() async {
    try {
      final profilePicture = await UploadService.fetchProfilePicture(user.id);

      userProfilePicture = File.fromRawPath(profilePicture);
    } catch (e) {
      userProfilePicture = null;
    }
  }
}
