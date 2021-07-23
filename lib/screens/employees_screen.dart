
import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/button-jobtype_selection.dart';
import 'package:event_uau/components/card_employee.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:event_uau/utils/icons.dart';
import 'package:flutter/material.dart';



class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({ Key key }) : super(key: key);

  static int option;

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {

  //GlobalKey<_NavBarJobTypeState> navGlobalKey = new GlobalKey<_NavBarJobTypeState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: setAppBar(context, username: "Felipe Ferreira Marques"),
      backgroundColor: colorBg,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Eu Preciso de um...", 
              style: Theme.of(context).textTheme.headline1,             
            ),         
            Container(
              padding: EdgeInsets.symmetric( vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  setButtonJobTypeSelection(context, icon: EventuauIcons.garcom_logo, title: "garcom", link: null,isSelected: true),
                  setButtonJobTypeSelection(context, icon: EventuauIcons.clown, title: "animador", link: null,),
                  setButtonJobTypeSelection(context, icon: EventuauIcons.buffet, title: "buffet", link: null,),
                  setButtonJobTypeSelection(context, icon: EventuauIcons.grill, title: "churrasco", link: null,),
                ]             
              ),
            ),
            IndexedStack(
              children: [              
                expandido2(),
                expandido3(),
              ],
            )          
          ]
        ),
      )
    );
  }
}



Widget expandido2(){
  return Text("data");
}

Widget expandido3(){
  return Text("seccao3");
}

Widget expandido4(){
  return Text("seccao4");
}


