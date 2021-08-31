import 'package:flutter/material.dart';

import '../../../components/employee_signup/paragraph_text.dart';
import '../../../components/employee_signup/editable_row.dart';
import './employee_add_documents.dart';

class EmployeeSignupScreen extends StatefulWidget {
  static const routeName = '/employee/signup/personaldata';
  const EmployeeSignupScreen({Key key}) : super(key: key);

  @override
  _EmployeeSignupScreenState createState() => _EmployeeSignupScreenState();
}

class _EmployeeSignupScreenState extends State<EmployeeSignupScreen> {
  TextEditingController _jobFilter = new TextEditingController();
  List<String> initialValues = [
    'Garçom',
    'Animador',
    'Churrasqueiro',
    'Fotógrafo',
    'Cozinheiro'
  ];

  List<String> jobList = [];
  List<String> selectedJobs = [];

  @override
  void initState() {
    jobList = initialValues;
    super.initState();
  }

  void rebuildChipList() {
    setState(() {
      jobList = initialValues
          .where((element) =>
              selectedJobs.contains(element) ||
              element.toUpperCase().contains(_jobFilter.text.toUpperCase()))
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

  void _handleSubmit() {
    //@TODO
    // 1. VALDATE IF USER HAS IMAGE AND HAS SELECTED AT LEAST 1 JOB
    // 2. UPLOAD IMAGE
    // 3. NAVIGATE TO NEXT PAGE
    Navigator.of(context).pushNamed(EmployeeAddDocuments.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seja um Parceiro',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: [
          IconButton(icon: Icon(Icons.arrow_forward), onPressed: _handleSubmit)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: deviceSize.width,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ParagraphText(
                  'Olá! Ficamos felizes em saber que você quer fazer parte do nosso time.'),
              ParagraphText(
                  'Vimos que você ainda não tem foto, toque no avatar abaixo e escolha uma que mostre bem o seu rosto:'),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: Theme.of(context).accentColor,
                      child: Text(
                        'FF',
                        style: Theme.of(context).textTheme.headline3.copyWith(
                            fontSize: 48,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
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
                              onTap: () {}),
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      EditableRow('Felipe Ferreira'),
                      EditableRow('24 Anos'),
                      EditableRow('Liberdade - SP')
                    ],
                  ),
                ),
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
                    controller: _jobFilter,
                    onChanged: (value) => rebuildChipList(),
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                        isDense: true,
                        labelText: 'Filtrar especialidades...',
                        contentPadding: EdgeInsets.zero,
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                  ),
                  Wrap(
                    spacing: 10,
                    children: [
                      ...jobList.map((e) => FilterChip(
                            selectedColor: Colors.white,
                            checkmarkColor: Theme.of(context).primaryColor,
                            selected:
                                selectedJobs.any((element) => element == e),
                            showCheckmark: true,
                            elevation: 1,
                            backgroundColor: Colors.white,
                            label: Text(e),
                            onSelected: (isSelected) {
                              handleChipSelection(isSelected, e);
                            },
                            labelStyle: Theme.of(context).textTheme.headline2,
                          ))
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}