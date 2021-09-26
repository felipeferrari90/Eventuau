// THIS IS NOT FREE, SO CAREFUL WITH THE REQUESTS! IF YOU WANT TO USE THIS ASK MATHEUS FOR API KEY
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String _authKey = "";

// class PredictionItem {
//   String description;
//   String id;

//   PredictionItem({@required this.id, @required this.description});
// }

// Future<List<PredictionItem>> fetchAddressSuggestions(query) async {
//   final res = await http.get(
//       'https://maps.googleapis.com/maps/api/place/autocomplete/json?types=address&language=pt-BR&input=$query&key=$_authKey&components=country:br&size=3');

//   final responseData = jsonDecode(res.body);

//   if (res.statusCode != 200 && responseData['status'] != 'OK') {
//     throw HttpException(responseData);
//   }

//   final predictions = (responseData['predictions'] as List)
//       .map((prediction) => new PredictionItem(
//           description: prediction['description'], id: prediction['place_id']))
//       .toList();

//   return predictions;
// }
