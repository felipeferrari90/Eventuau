// THIS IS NOT FREE, SO CAREFUL WITH THE REQUESTS! IF YOU WANT TO USE THIS ASK MATHEUS FOR API KEY
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String _authKey = "AIzaSyD449LyAT00XQdFdmRkWZoTSfTIMaqvBFg";

Future<Map<String, String>> fetchLatAndLongByAddress(String address) async {
  final res = await http.get(
      'https://maps.googleapis.com/maps/api/geocode/json?address=$address&region=br&key=$_authKey');

  final responseData = jsonDecode(res.body);

  if (res.statusCode != 200 && responseData['status'] != 'OK') {
    throw HttpException(responseData);
  }

  print(responseData);

  return {
    'lat':
        responseData['results'][0]['geometry']['location']['lat'].toString() ??
            "12.00000",
    'long':
        responseData['results'][0]['geometry']['location']['lng'].toString() ??
            "12.00000",
  };
}
