import 'package:brasil_fields/brasil_fields.dart';
import 'package:collection/collection.dart';
import 'package:event_uau/components/employee/wallet_screen/deposit_dialog.dart';
import 'package:event_uau/components/employee/wallet_screen/withdraw_dialog.dart';
import 'package:event_uau/screens/profissional/wallet/add_credit.card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './add_bank_screen.dart';
import 'package:event_uau/providers/employee_wallet_data.dart';

class EmployeeWallet extends StatefulWidget {
  const EmployeeWallet({Key key}) : super(key: key);

  static const routeName = '/employee/wallet';

  @override
  State<EmployeeWallet> createState() => _EmployeeWalletState();
}

class _EmployeeWalletState extends State<EmployeeWallet> {
  List<bool> _expansionItems = [false, false, false];
  Future<void> _fetchDataRef;
  EmployeeWalletData walletData;

  @override
  void initState() {
    _fetchDataRef = getData();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    walletData = Provider.of<EmployeeWalletData>(context);
    super.didChangeDependencies();
  }

  void _onWithdraw() async {
    // CHECK IF HAS BANKDATA
    if (walletData.bankData.length < 1) return showAddBankDialog();
    // CHECK IF HAS ANY BANK SELECTED AS PRIMARY OPEN MEUS DADOS BANCARIOS IF ITS CLOSED

    if (walletData.selectedBankAccount == null) {
      setState(() {
        _expansionItems[1] = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selecione uma conta bancária')));
      return;
    }

    // SHOW DIALOG FOR AMOUNT
    await showDialog(context: context, builder: (context) => WithdrawDialog());
  }

  _onDeposit() async {
    if (walletData.cardData.length < 1) return showAddCardDialog();

    if (walletData.selectedCreditCard == null) {
      setState(() {
        _expansionItems[0] = true;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Selecione um cartão')));
      return;
    }

    // SHOW DIALOG FOR AMOUNT
    await showDialog(context: context, builder: (context) => DepositDialog());
  }

  getData() =>
      Provider.of<EmployeeWalletData>(context, listen: false).getWalletData();


      showAddCardDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Você ainda não tem nenhum cartão adicionado.'),
            content: Text('Quer adicionar um agora?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Não')),
              TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AddCreditCard.routeName),
                  child: Text('Sim'))
            ],
          ));

  showAddBankDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Você ainda não tem nenhum banco adicionado.'),
            content: Text('Quer adicionar um agora?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Não')),
              TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AddBankScreen.routeName),
                  child: Text('Sim'))
            ],
          ));

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context).settings.name;
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Carteira'),
        actions: [
          IconButton(
              onPressed: getData,
              icon: Icon(Icons.refresh, color: Theme.of(context).primaryColor))
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: FutureBuilder(
            future: _fetchDataRef,
            builder: (context, snapshot) => Column(
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
                      text: walletData.avaliableBalance.toStringAsFixed(2),
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
                          text: walletData.futureBalance.toStringAsFixed(2),
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
                      color: Theme.of(context).accentColor,
                      onPressed: _onWithdraw,
                      child: Text('Sacar'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    if (route == '/')
                    RaisedButton(
                        onPressed: _onDeposit,
                        child: Text('Depositar'),
                        color: Theme.of(context).primaryColor),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ExpansionPanelList(
                  expansionCallback: (panelIndex, isExpanded) =>
                      setState(() => _expansionItems[panelIndex] = !isExpanded),
                  dividerColor: Colors.grey[400],
                  elevation: 1,
                  children: [
                    if (route == '/')
                      ExpansionPanel(
                          canTapOnHeader: true,
                          headerBuilder: (context, isExpanded) => ListTile(
                                visualDensity: VisualDensity.compact,
                                horizontalTitleGap: 2,
                                leading: Icon(
                                  Icons.credit_card,
                                  size: 28,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: Text('Meus Cartões de Crédito'),
                              ),
                          body: Column(
                            children: [
                              ...walletData.cardData
                                  .mapIndexed(
                                    (index, e) => ListTile(
                                      visualDensity: VisualDensity.compact,
                                      onTap: () =>
                                          walletData.setMainCreditCard(index),
                                      title: Text(e.toString()),
                                      trailing: Icon(
                                        e.isSelected
                                            ? Icons.radio_button_checked
                                            : Icons.radio_button_off,
                                        color: Theme.of(context).primaryColor,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                  .toList(),
                              ListTile(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(AddCreditCard.routeName),
                                visualDensity: VisualDensity.compact,
                                title: Text('Adicionar Cartão de Crédito'),
                                trailing: Icon(
                                  Icons.add,
                                  color: Colors.green[400],
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                          isExpanded: _expansionItems[0]),
                    ExpansionPanel(
                        canTapOnHeader: true,
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
                        body: Column(
                          children: [
                            ...walletData.bankData
                                .mapIndexed(
                                  (index, e) => ListTile(
                                    visualDensity: VisualDensity.compact,
                                    onTap: () =>
                                        walletData.setMainBankAccount(index),
                                    title: Text(e.toString()),
                                    trailing: Icon(
                                      e.isSelected
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_off,
                                      color: Theme.of(context).primaryColor,
                                      size: 20,
                                    ),
                                  ),
                                )
                                .toList(),
                            ListTile(
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
                          ],
                        ),
                        isExpanded: _expansionItems[1]),
                    ExpansionPanel(
                        canTapOnHeader: true,
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
                        body: Column(
                          children: walletData.operations.length > 0
                              ? walletData.operations
                                  .map(
                                    (e) => ListTile(
                                      visualDensity: VisualDensity.compact,
                                      title: Text(e.operationType.description),
                                      trailing: Text(
                                        'R\$ ${(e.value * e.operationType.multiplier).toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                e.operationType.multiplier > 0
                                                    ? Colors.green
                                                    : Colors.redAccent),
                                      ),
                                    ),
                                  )
                                  .toList()
                              : [
                                  ListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: Text(
                                      'Nenhuma transação ainda...',
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  )
                                ],
                        ),
                        isExpanded: _expansionItems[2])
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
