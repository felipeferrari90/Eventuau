import 'package:event_uau/utils/colors.dart';
import 'package:event_uau/utils/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget setCardEvent(context) => Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  color: secundaryColor,
  child: InkWell(
    onTap: (){
      Navigator.pushNamed(context, "/event/id");
    },
    child: Column(
      children:[
        Container( 
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            color: secundaryColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Churrasco na brasilandia" , maxLines: 3, style: TextStyle(color: primaryColor, fontSize:  16, fontWeight: FontWeight.w700,),),
              SizedBox(height: 5),
              Row(
                children: [
                  Padding(padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.calendar_today, color: primaryColor, size: 16,),
                  ),
                  Text("12 Agosto 2020 - 8:00", style: Theme.of(context).textTheme.headline5 )
                ]
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: colorBg,
                    borderRadius: BorderRadius.circular(15),
                  ), 
                ),
                //inicio da coluna de flexiveis
                    Container(   
                     height:  MediaQuery.of(context).size.width / 2.5,
                     padding: EdgeInsets.only(left: 12),     
                     child: Column(
                        children:[         
                                Spacer(flex: 3),
                                Row(
                                  children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width / 4.5,
                                          child: Align (
                                            alignment: Alignment.center,
                                            child:  Row(
                                              children: [
                                                Icon(EventuauIcons2.handshake, size: 16, color: primaryColor,),
                                                SizedBox(width: 4,),
                                                Text("120/150", style: TextStyle(fontSize: 14, color:  Colors.black54 ),)
                                              ],
                                            ),
                                          )
                                        ) ,
                                       Container(
                                         width:  MediaQuery.of(context).size.width / 4.6,
                                          child: Align (
                                            alignment: Alignment.center,
                                            child:  Row(
                                              children: [
                                                Icon(Icons.thumb_up, size: 16, color: primaryColor ,),
                                                SizedBox(width: 4,),
                                                Text("1357", style: TextStyle(fontSize: 14, color:  Colors.black54 ),)
                                              ],
                                            ),
                                          )
                                        ) ,
                                    ],
                                ),
                               Spacer(flex: 2),
                                       Container(
                                          width: MediaQuery.of(context).size.width / 2.3,
                                          child: Align (
                                            alignment: Alignment.centerLeft,
                                            child:  Row(
                                              children: [
                                                Icon(Icons.hourglass_empty, size: 16, color: primaryColor,),
                                                SizedBox(width: 4,),
                                                Text("12 até 16 horas", style: TextStyle(fontSize: 14, color:  Colors.black54),)
                                              ],
                                            ),
                                          )
                                        ) ,
                                 
                                
                                Spacer(flex: 2),
                                       Container(
                                          width: MediaQuery.of(context).size.width / 2.3,
                                          child: Align (
                                            alignment: Alignment.centerLeft,
                                            child:  Row(
                                              children: [
                                                Icon(Icons.assignment_ind, size: 16, color: primaryColor,),
                                                SizedBox(width: 4,),
                                                Text(": em contratação", style: TextStyle(fontSize: 14, color:  Colors.black54),)
                                              ],
                                            ),
                                          )
                                        ) ,
                                Spacer(flex: 2),
                                        Container(
                                          width: MediaQuery.of(context).size.width / 2.4,
                                          child: Align (
                                            alignment: Alignment.centerLeft,
                                            child:  Row(
                                              children: [
                                                Text("status: ", style: TextStyle(fontSize: 14, color: Colors.black54),),
                                                SizedBox(width: 4,),
                                                Text("AGENDADO".toString(), style: TextStyle(fontSize: 14, color: primaryColor, fontWeight: FontWeight.w700),)
                                              ],
                                            ),
                                          )
                                        ) ,
                                Spacer(flex: 2),
                                    Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      spacing: 24,
                                      clipBehavior: Clip.hardEdge,
                                      children: [
                                       RaisedButton(
                                          child: Icon(Icons.person_add, color: primaryColor, size: 24), 
                                          onPressed: (){
                                            Navigator.pushNamed(context, "/employees");
                                          },
                                          color: colorBg,
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6)
                                          )
                                        ),
                                        RaisedButton(
                                          child: Icon(Icons.assignment_ind, color: primaryColor, size: 24), 
                                          onPressed: (){
                                            Navigator.pushNamed(context, "/employee/management");
                                          },
                                          color: colorBg,
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6)
                                          )
                                        ),
                                      ],
                                    ),        
                                Spacer(),
                      ]
                    ),  
                  ),
               
                //fim da coluna de flexiveis
              ],
            ),
          ),
          //colocar aqui as coisas do conteudo abaixo do container com foto e icones acima
      ],
    ),
  ),
);

