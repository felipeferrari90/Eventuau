import 'package:event_uau/components/employee_signup/add_document_card.dart';
import 'package:flutter/material.dart';

import '../../../components/employee_signup/paragraph_text.dart';

class EmployeeAddDocuments extends StatefulWidget {
  static const routeName = '/employee/signup/personalfiles';
  const EmployeeAddDocuments({Key key}) : super(key: key);

  @override
  _EmployeeAddDocumentsState createState() => _EmployeeAddDocumentsState();
}

class _EmployeeAddDocumentsState extends State<EmployeeAddDocuments> {
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
            onPressed: () {},
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
                    onTap: () {},
                  ),
                  AddDocumentCard(
                    isOnRow: true,
                    text: 'Foto do Verso',
                    onTap: () {},
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
                onTap: () {},
              )
            ],
          )
        ]),
      ),
    );
  }
}
