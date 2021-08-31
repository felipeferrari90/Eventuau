import 'package:flutter/material.dart';

import 'employee_application_pending.dart';
import '../../../components/employee_signup/add_document_card.dart';
import '../../../components/employee_signup/paragraph_text.dart';
import '../../contratante/home_screen.dart';

import 'dart:io';
import 'dart:async';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeAddDocuments extends StatefulWidget {
  static const routeName = '/employee/signup/personalfiles';
  const EmployeeAddDocuments({Key key}) : super(key: key);

  @override
  _EmployeeAddDocumentsState createState() => _EmployeeAddDocumentsState();
}

class _EmployeeAddDocumentsState extends State<EmployeeAddDocuments> {
  Map<String, File> documents = {
    'rgFrente': null,
    'rgVerso': null,
    'rgSelfie': null
  };

  void _handleSubmit() {
    //@TODO
    // 1. VALDATE IF USER HAS ADDED EVERY DOCUMENTO
    // 2. UPLOAD IMAGE DOCUMENTS WHILE SHOWING SPINNER ON APPBAR CHECKMARK
    // 3. NAVIGATE TO NEXT PAGE
    Navigator.of(context).pushNamedAndRemoveUntil(
        (EmployeeApplicationPending.routeName),
        (route) => route.settings.name == HomeScreen.routeName);
  }

  Future<Null> _pickImage(document) async {
    // ESCOLHER ENTRE CAMERA OU GALERIA

    // BUSCAR OU TIRAR FOTO
    final image = await ImagePicker().getImage(source: ImageSource.camera);

    if (image != null) {
      File croppedImage = await _cropImage(image);

      setState(() {
        document = croppedImage;
      });
    } else {
      print('No image picked');
    }
  }

  Future<File> _cropImage(image) {
    return ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.original,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
      androidUiSettings: AndroidUiSettings(
          hideBottomControls: true,
          toolbarTitle: 'Cortar imagem',
          showCropGrid: false,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seja um Parceiro',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              _handleSubmit();
            },
            color: Colors.green,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ParagraphText(
                  'Vamos precisar também de uma foto frente e verso do seu RG.'),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AddDocumentCard(
                    isOnRow: true,
                    text: 'Foto da Frente',
                    onTap: () => _pickImage(documents['rgFrente']),
                  ),
                  AddDocumentCard(
                    isOnRow: true,
                    text: 'Foto do Verso',
                    onTap: () => _pickImage(documents['rgVerso']),
                  )
                ],
              )
            ],
          ),
          Column(
            children: [
              ParagraphText(
                  'Por último, precisaremos de uma selfie segurando seu RG com a foto visível: '),
              SizedBox(
                height: 18,
              ),
              AddDocumentCard(
                text: 'Foto com RG na mão.',
                onTap: () => _pickImage(documents['rgSelfie']),
              )
            ],
          )
        ]),
      ),
    );
  }
}
