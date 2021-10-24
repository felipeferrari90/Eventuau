import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OperationType {
  String id;
  String description;
  int multiplier;
  bool isAvaliable;

  OperationType(
      {@required this.id,
      @required this.description,
      @required this.multiplier,
      @required this.isAvaliable});
}

class Operation {
  String id;
  DateTime date;
  int eventId;
  double value;
  OperationType operationType;

  Operation(
      {@required this.id,
      @required this.date,
      @required this.eventId,
      @required this.value,
      @required this.operationType});
}

class BankData {
  String bankNumber;
  String agencia;
  String conta;
  String name;
  String cpf;
  bool isSelected = false;

  BankData(
      {@required this.bankNumber,
      @required this.agencia,
      @required this.conta,
      @required this.name,
      @required this.cpf,
      this.isSelected});

  @override
  String toString() {
    super.toString();
    return '$bankNumber - AG: $agencia CONTA: $conta';
  }
}

final baseUrl = 'https://10.0.2.2:6041';

class EmployeeWalletData with ChangeNotifier {
  String _token;
  EmployeeWalletData(this._token);

  double avaliableBalance = 0.0;
  double futureBalance = 0.0;
  // List<Operation> futureOperations = [];
  List<Operation> operations = [];
  // does not exist on backend, just a mock on front
  List<BankData> bankData = [];

  BankData get selectedBankAccount {
    final index = bankData.indexWhere((element) => element.isSelected == true);
    return index != -1 ? bankData[index] : null;
  }

  set bankDataFromForm(Map<String, String> formData) {
    bankData.add(new BankData(
        cpf: formData['cpf'],
        agencia: formData['agencia'],
        bankNumber: formData['bankNumber'],
        conta: formData['conta'],
        name: formData['name'],
        isSelected: bankData.length < 1 ? true : false));

    notifyListeners();
  }

  void setMainBankAccount(int index) {
    final previousBankData = selectedBankAccount;

    if (previousBankData != null) previousBankData.isSelected = false;

    bankData[index].isSelected = true;

    notifyListeners();
  }

  Future<void> getWalletData() async {
    print('getWalletData');
    final url = '$baseUrl/api/carteiras/extrato';
    final headers = {
      HttpHeaders.authorizationHeader: 'Bearer $_token',
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    final res = await http.get(url, headers: headers);
    if (res.statusCode != 200) throw res;

    final responseBody = json.decode(res.body);

    avaliableBalance = double.parse(responseBody['valorDisponivel'].toString());
    futureBalance = double.parse(responseBody['valorFuturo'].toString());

    List<Operation> _operations = [];
    (responseBody['operacoes'] as List).forEach((element) {
      final operationType = element['tipoOperacao'];
      _operations.add(
        new Operation(
          id: element['id'].toString(),
          date: DateTime.parse(element['dataHora']),
          eventId: element['idEvento'],
          value: double.parse(element['valor'].toString()),
          operationType: new OperationType(
            id: operationType['id'],
            description: operationType['descricao'],
            multiplier: operationType['multplicador'],
            isAvaliable: operationType['ehDisponivel'],
          ),
        ),
      );
    });
    operations = _operations;

    notifyListeners();
  }

  Future<void> withdraw(double value) async {
    final res = await http.post('https://10.0.2.2:6041/api/operacoes/saque',
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $_token'
        },
        body: json.encode({"valor": value}));

    if (res.statusCode != 200) throw res;

    avaliableBalance -= value;

    notifyListeners();
  }
}
