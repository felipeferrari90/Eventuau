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
       appBar: setAppBar(context),
       body: Container(
         padding: EdgeInsets.all(16),
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


setCardManagementEmployee(BuildContext context) => 
  Card(
    child: ListTile(
      title: Text("Pedro Lemes"),
      subtitle: Text("RG 12345678910"),
      leading: Icon(EventuauIcons.garcom_logo, size: 24 , color: primaryColor),
      trailing: Text("FE")
    )
  );