import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../providers/auth.dart';
import 'package:http/http.dart' as http;

enum FileTypes { profilePicture, rgFrente, rgVerso, selfie }

const baseUrl = 'https://10.0.2.2:6021/api/arquivos';

final userData = Auth();

Future<void> uploadImage({FileTypes fileType, File image}) async {
  var filename = describeEnum(fileType);

  var request = http.MultipartRequest(
      "POST", Uri.parse('$baseUrl/${userData.user.id}/$filename'))
    ..headers
        .addAll({HttpHeaders.authorizationHeader: 'Bearer ${userData.token}'})
    ..files.add(await http.MultipartFile.fromPath('arquivo', image.path));

  var response = await request.send();

  if (response.statusCode != 200) throw response;
}
