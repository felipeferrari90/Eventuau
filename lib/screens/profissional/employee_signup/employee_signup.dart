import 'dart:async';
import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:event_uau/components/address_search.dart';
import 'package:event_uau/screens/profissional/employee_signup/employee_application_success.dart';
import '../../../service/contratado_service.dart' as ContratadoService;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../components/employee/signup/paragraph_text.dart';
import '../../../components/employee/signup/editable_row.dart';
import '../../../providers/auth.dart';

import '../../../service/upload_service.dart' as UploadService;

class JobItem {
  int id;
  String descricao;

  JobItem({this.id, this.descricao});
}

class EmployeeSignupScreen extends StatefulWidget {
  static const routeName = '/employee/signup/personaldata';
  const EmployeeSignupScreen({Key key}) : super(key: key);

  @override
  _EmployeeSignupScreenState createState() => _EmployeeSignupScreenState();
}

class _EmployeeSignupScreenState extends State<EmployeeSignupScreen> {
  GlobalKey<FormState> _formKey = new GlobalKey();
  TextEditingController _jobFilter = new TextEditingController();
  List<JobItem> jobList = [];
  List<JobItem> selectedJobs = [];
  Map<String, dynamic> address;
  File profilePicture;
  String enderecoText;
  double hourlyRate;
  bool isLoading = false;

  //TODO PULL FROM ENDPOINT
  List<JobItem> initialValues = [
    JobItem(
      id: 1,
      descricao: 'Garçom',
    ),
    JobItem(
      id: 2,
      descricao: 'Animador',
    ),
    JobItem(
      id: 3,
      descricao: 'Churrasqueiro',
    ),
    JobItem(
      id: 4,
      descricao: 'Fotógrafo',
    ),
    JobItem(
      id: 5,
      descricao: 'Cozinheiro',
    ),
  ];

  @override
  void initState() {
    jobList = initialValues;
    final userData = Provider.of<Auth>(context, listen: false).user;

    profilePicture = userData.userProfilePicture;
    enderecoText = userData.address?.toString();

    super.initState();
  }

  void rebuildChipList() {
    setState(() {
      jobList = initialValues
          .where((element) =>
              selectedJobs.contains(element) ||
              element.descricao
                  .toUpperCase()
                  .contains(_jobFilter.text.toUpperCase()))
          .toList();
    });
  }

  void handleChipSelection(isSelected, e) {
    if (isSelected) {
      if (selectedJobs.length > 2) {
        return;
      } else
        selectedJobs.add(e);
    } else
      selectedJobs.removeWhere((element) => element == e);

    rebuildChipList();
  }

  void _showWarning(String text) {
    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
        backgroundColor: Colors.redAccent,
        contentTextStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        leading: Icon(
          Icons.warning,
          size: 22,
          color: Colors.white,
        ),
        content: Text(
          text,
        ),
        actions: [
          TextButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          )
        ]));

    Timer(Duration(seconds: 5),
        () => ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
  }

  void _handleSubmit() async {
    var _hasError = false;
    final userAddress = Provider.of<Auth>(context, listen: false).user.address;
    //@TODO
    // 1. VALDATE IF USER HAS IMAGE AND HAS SELECTED AT LEAST 1 JOB + HOURLYRATE

    if (profilePicture == null) {
      _showWarning('Por favor, adicione uma foto de perfil');
      _hasError = true;
    } else if (userAddress == null && enderecoText == null) {
      _showWarning('Por favor, adicione um endereço');
      _hasError = true;
    }

    if (!_formKey.currentState.validate() || _hasError) return;
    _formKey.currentState.save();

    setState(() {
      isLoading = true;
    });
    try {
      // 2. UPLOAD IMAGE
      await UploadService.uploadImage(
          fileType: UploadService.FileTypes.profilePicture,
          image: profilePicture);

      Provider.of<Auth>(context, listen: false).userProfilePicture =
          profilePicture;
      //3. SUBMIT PARTNER DATA
      await ContratadoService.signup(hourlyRate, selectedJobs);

      // 4. NAVIGATE TO NEXT PAGE
      Navigator.of(context).pushReplacementNamed(EmployeeApplicationSuccess.routeName);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao submeter informações.')));
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<Null> _pickImage() async {
    // ESCOLHER ENTRE CAMERA OU GALERIA
    final ImageSource imageSource = await chooseImageSource();

    if (imageSource == null) return;

    // BUSCAR OU TIRAR FOTO
    final image = await ImagePicker().getImage(source: imageSource);

    if (image != null) {
      File croppedImage = await _cropImage(image);

      setState(() {
        profilePicture = croppedImage;
      });
    } else {
      print('No image picked');
    }
  }

  Future<File> _cropImage(image) {
    return ImageCropper.cropImage(
      compressQuality: 70,
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

  Future<ImageSource> chooseImageSource() => showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            children: [
              ListTile(
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
                leading: Icon(
                  Icons.camera_alt,
                  color: Theme.of(context).primaryColor,
                  size: 22,
                ),
                title: Text('Tirar Foto'),
              ),
              ListTile(
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                leading: Icon(
                  Icons.photo,
                  color: Theme.of(context).primaryColor,
                  size: 22,
                ),
                title: Text('Escolher da Galeria'),
              ),
            ],
          ));

  Future<void> updateInfo(Map<String, dynamic> payload) async {
    setState(() {
      isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).updateUserInfo(payload);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Informação alterada com sucesso')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao submeter informações.')));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final userData = Provider.of<Auth>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seja um Parceiro',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: [
          !isLoading
              ? IconButton(
                  icon: Icon(Icons.check, color: Colors.green),
                  onPressed: _handleSubmit)
              : Container(
                  padding: EdgeInsets.only(right: 12, top: 16, bottom: 18),
                  width: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: deviceSize.width,
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ParagraphText(
                    'Olá! Ficamos felizes em saber que você quer fazer parte do nosso time.'),
                // IF HASNOPHOTO
                ParagraphText(
                    'Vimos que você ainda não tem foto, toque no avatar abaixo e escolha uma que mostre bem o seu rosto:'),
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      CircleAvatar(
                          radius: 75,
                          backgroundImage: profilePicture != null
                              ? FileImage(profilePicture)
                              : null,
                          backgroundColor: Theme.of(context).accentColor,
                          child: profilePicture == null
                              ? Text(
                                  userData.name.split(' ').reduce(
                                      (value, element) =>
                                          value.characters.first +
                                          element.characters.first),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3
                                      .copyWith(
                                          fontSize: 48,
                                          color:
                                              Theme.of(context).primaryColor),
                                )
                              : null),
                      Positioned(
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                            child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                // color: Theme.of(context).primaryColor,
                                child: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                  size: 30,
                                ),
                                onTap: _pickImage),
                          ),
                        ),
                        right: 0,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        EditableRow(
                            onSubmit: (value) =>
                                updateInfo({'nome': value.toString()}),
                            editableText: userData.name),
                        EditableRow(
                            onSubmit: (value) {
                              var date =
                                  value.toString().split('/').reversed.toList();
                              var datePayload = new DateTime(int.parse(date[0]),
                                      int.parse(date[1]), int.parse(date[2]))
                                  .toIso8601String();

                              updateInfo({'dataNascimento': datePayload});
                            },
                            // updateInfo({'dataNascimento': value}),
                            editableText: DateFormat('dd/M/yyyy')
                                .format(userData.birthDate)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.8),
                              child: Text(
                                userData.address ??
                                    enderecoText ??
                                    'Adicione um endereço',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    .copyWith(
                                      fontSize: 18,
                                    ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              child: Icon(
                                Icons.edit,
                                size: 24,
                                color: Theme.of(context).primaryColor,
                              ),
                              onTap: () async {
                                final newAddress = await showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => AddressSearch(
                                    initialValue: address,
                                  ),
                                );
                                if (newAddress != null)
                                  setState(() {
                                    address = newAddress;
                                    enderecoText =
                                        '${newAddress['logradouro']} ${newAddress['numero']} ${newAddress['complemento']}, ${newAddress['cep']} - ${newAddress['bairro']} ${newAddress['localidade']} - ${newAddress['uf']}';
                                  });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Valor da Hora Trabalhada:',
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontSize: 16),
                    ),
                    TextFormField(
                      onSaved: (value) =>
                          hourlyRate = double.parse(value.replaceAll(',', '.')),
                      validator: (value) =>
                          value.isEmpty ? 'Campo Obrigatório' : null,
                      keyboardType: TextInputType.number,
                      maxLength: 5,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        RealInputFormatter(centavos: true)
                      ],
                      decoration: InputDecoration(
                          counterText: '',
                          prefixStyle: TextStyle(color: Colors.black),
                          prefixText: 'R\$ ',
                          isDense: true,
                          hintText:
                              'Quanto você quer cobrar por hora? Ex: R\$20,00',
                          floatingLabelBehavior: FloatingLabelBehavior.never),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Escolha até 3 especialidades:',
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontSize: 16),
                    ),
                    TextFormField(
                      validator: (_) => selectedJobs.length <= 0
                          ? 'Escolha pelo menos uma especialidade abaixo'
                          : null,
                      controller: _jobFilter,
                      onChanged: (_) => rebuildChipList(),
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Filtrar especialidades...',
                          floatingLabelBehavior: FloatingLabelBehavior.never),
                    ),
                    Wrap(
                      spacing: 10,
                      children: jobList
                          .map(
                            (e) => FilterChip(
                              selectedColor: Colors.white,
                              checkmarkColor: Theme.of(context).primaryColor,
                              selected: selectedJobs
                                  .any((element) => element.id == e.id),
                              showCheckmark: true,
                              elevation: 1,
                              backgroundColor: Colors.white,
                              label: Text(e.descricao),
                              onSelected: (isSelected) {
                                handleChipSelection(isSelected, e);
                              },
                              labelStyle: Theme.of(context).textTheme.headline2,
                            ),
                          )
                          .toList(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
