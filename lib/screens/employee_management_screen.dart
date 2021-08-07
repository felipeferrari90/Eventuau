import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:event_uau/utils/icons.dart';
import 'package:flutter/material.dart';

class EmployeesManagement extends StatefulWidget {
  const EmployeesManagement({ Key key }) : super(key: key);

  @override
  _EmployeesManagementState createState() => _EmployeesManagementState();
}

class _EmployeesManagementState extends State<EmployeesManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: setAppBar(context, title: 'gerenciador de funcionarios', username: "Felipe Ferreira"),
       body: Container(
         padding: EdgeInsets.symmetric(vertical:16),
         color: colorBg,
         child: Container(  
             child: SingleChildScrollView(
               child: Column(
                 children: [
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                    setCardManagementEmployee(context),
                 ],
               ),
             ),
         )
       )
    );  
  }

      
}


setCardManagementEmployee(BuildContext context, {Function f, bool isChecked = false }) =>
  Card(
      child:ListTile(
            title: Text("Pedro Lemes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            subtitle: Text("RG 12345678910", style: TextStyle(fontSize: 12)),
            leading: Icon(EventuauIcons.garcom_logo, size: 32 , color: primaryColor,),
            trailing: RaisedButton(
              onPressed: () {},
              textColor: colorBg,
              color: primaryColor,
              padding: EdgeInsets.symmetric(vertical: 2 , horizontal: 12),
              child: Text("confirmar presença", style: TextStyle(fontSize: 12),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),  
            )
          ), 
  );

 


