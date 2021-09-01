import 'package:flutter/material.dart';
import '../../../components/buttons.dart';
import '../../../components/employee/signup/paragraph_text.dart';
import '../../../components/app_bar_eventual.dart';
import '../../../screens/contratante/home_screen.dart';

class EmployeeApplicationPending extends StatelessWidget {
  const EmployeeApplicationPending({Key key}) : super(key: key);

  static const routeName = '/employee/signup/applicationpending';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/file_upload.png'),
              Text(
                'Seus dados estão em análise...',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 12,
              ),
              ParagraphText(
                  'Nossa equipe está avaliando os dados enviados. Você receberá um e-mail quando estiver tudo certo.'),
              ParagraphText('Esse processo leva até 2 dias.'),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: BaseButton(
              text: 'Ir para Home',
              onPressed: () {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName(HomeScreen.routeName));
              },
            ),
          )
        ],
      ),
    ));
  }
}
