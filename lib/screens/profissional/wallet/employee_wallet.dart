import 'package:flutter/material.dart';

import './add_bank_screen.dart';

class EmployeeWallet extends StatelessWidget {
  const EmployeeWallet({Key key}) : super(key: key);

  static const routeName = '/employee/wallet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Carteira'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Saldo Disponível:',
              style: Theme.of(context).textTheme.headline5,
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'R\$ ',
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        fontSize: 26,
                      ),
                ),
                TextSpan(
                  text: '50.00',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 56),
                )
              ]),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'Saldo à Receber:',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(
              height: 2,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'R\$ ',
                      style: Theme.of(context).textTheme.headline2),
                  TextSpan(
                      text: '47.82',
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontWeight: FontWeight.normal)),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {},
                  child: Text('Sacar'),
                ),
                SizedBox(
                  width: 20,
                ),
                RaisedButton(
                    onPressed: () {},
                    child: Text('Depositar'),
                    color: Theme.of(context).accentColor),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ExpansionPanelList(
              dividerColor: Colors.grey[400],
              elevation: 1,
              children: [
                ExpansionPanel(
                    headerBuilder: (context, isExpanded) => ListTile(
                          visualDensity: VisualDensity.compact,
                          horizontalTitleGap: 2,
                          leading: Icon(
                            Icons.account_balance,
                            size: 28,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text('Meus Dados Bancários'),
                        ),
                    body: ListTile(
                      onTap: () => Navigator.of(context)
                          .pushNamed(AddBankScreen.routeName),
                      visualDensity: VisualDensity.compact,
                      title: Text('Adicionar Dados Bancários'),
                      trailing: Icon(
                        Icons.add,
                        color: Colors.green[400],
                        size: 22,
                      ),
                    ),
                    isExpanded: true),
                ExpansionPanel(
                    headerBuilder: (context, isExpanded) => ListTile(
                          visualDensity: VisualDensity.compact,
                          horizontalTitleGap: 2,
                          leading: Icon(
                            Icons.receipt,
                            size: 28,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text('Minhas Transações'),
                        ),
                    body: ListTile(
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        'Nenhuma transação ainda...',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    isExpanded: true)
              ],
            )
          ],
        ),
      ),
    );
  }
}
