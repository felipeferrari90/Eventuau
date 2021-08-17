import 'package:event_uau/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({ Key key }) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child:  Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color:colorBg,
                  elevation: 2,
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        SizedBox(height: 16,),
                        Text("Saldo Disponivel:", style: TextStyle(fontSize: 16, color: Colors.black54),),
                        Text("R\$ 50000,00", style: TextStyle(fontSize: 36, color: primaryColor, fontWeight: FontWeight.w700),),
                        SizedBox(height: 24),
                        Text("Valor Bloqueado:", style: TextStyle(fontSize: 16, color: Colors.black54),),
                        Text("R\$ 12000,00", style: TextStyle(fontSize: 24, color: Colors.black54, fontWeight: FontWeight.w700),),
                        SizedBox(height: 32),              
                      ]
                    )
                  ) 
                ),
                SizedBox(height: 24,),
                Wrap(
                 alignment: WrapAlignment.spaceBetween,
                  children: [
                     RaisedButton(
                       elevation: 2,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(15),
                       ),
                       onPressed: (){},
                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                       color: secundaryColor,
                       textColor: primaryColor,
                       child: Text("saque", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                     ),
                     SizedBox(width: 48),
                     RaisedButton(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(15),
                       ),
                       onPressed: (){},
                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                       color: colorBg,
                       textColor: primaryColor,
                       child: Text("Depósito", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                     ),
                  ],
                ),
                SizedBox(height: 12,),
                Divider(),
                SizedBox(height: 12,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text("meus pagamentos", style: Theme.of(context).textTheme.headline1, textAlign: TextAlign.left,),
                ),
                SizedBox(height: 12,),
              
                    setCardPayments(eDebito: true, texto: "saque de valor para sua conta bancaria", valor: 75),
                    setCardPayments(eDebito: true, texto: "pagamento de evento N-12234554", valor: 1080),
                    setCardPayments(eDebito: false, texto: "deposito de valor para sua conta", valor: 75),
                    setCardPayments(eDebito: true, texto: "pagamento de evento N-24343234", valor: 200)
               
              ],
            )
      ),
    );
  }

  Widget setCardPayments({bool eDebito, String texto, double valor}) => 
      ListTile(
        contentPadding: EdgeInsets.all(8),
        enabled: false,
        leading: Icon(eDebito == true ? Icons.remove : Icons.add , size: 32, color: eDebito == true ? Colors.red[400] : Colors.green[400] ,),
        title: Text(texto , style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w700)),
        subtitle: Text("Data: 15/01/2021 as 16:37", style: TextStyle(fontSize: 12, color: Colors.black54)),
        trailing: Text("R\$: "+valor.toStringAsFixed(2), style: TextStyle(fontSize: 16, color: primaryColor, fontWeight: FontWeight.w700)),
      ); 
}