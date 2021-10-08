// THIS IS NOT FREE, SO CAREFUL WITH THE REQUESTS! IF YOU WANT TO USE THIS ASK MATHEUS FOR API KEY
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String _authKey = "AIzaSyBp7SSgZBtrUe0OMNAkvZEZr9TJ_z8sCIg";

Future<Map<String, String>> fetchLatAndLongByAddress(String address) async {
  final res = await http.get(
      'https://maps.googleapis.com/maps/api/geocode/json?address=$address&region=br&key=$_authKey');

  final responseData = jsonDecode(res.body);

  if (res.statusCode != 200 && responseData['status'] != 'OK') {
    throw HttpException(responseData);
  }
  return {
    'lat': responseData[0]['geometry']['location']['lat'].toString(),
    'long': responseData[0]['geometry']['location']['long'].toString(),
  };
}
