import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:event_uau/utils/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventScreenDescription extends StatefulWidget {
  const EventScreenDescription({ Key key }) : super(key: key);

  @override
  _EventScreenDescriptionState createState() => _EventScreenDescriptionState();
}

class _EventScreenDescriptionState extends State<EventScreenDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: setAppBar(context),
       body: Container(
         padding: EdgeInsets.all(16),
         color: colorBg,
         child: Container(  
            padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: SingleChildScrollView(
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height:200),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 2),
                      child: Text("Churrasco na Brasilandia", style: TextStyle( fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black)),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      child: Text("12 agosto 20:00 ", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500, color: primaryColor)),
                    ), 
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 2, 4),
                          child:  Text("Duração: ", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500, color: primaryColor)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                          child: Text("5 Horas", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w300, color: Color.fromRGBO(0, 0,0,0.7))),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 2, 4),
                          child:  Text("Distancia: ", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500, color: primaryColor)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                          child: Text("12 km", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w300, color: Color.fromRGBO(0, 0,0,0.7))),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 2, 4),
                          child:  Text("Endereco: ", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500, color: primaryColor)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                          child: Text("rua dos afogados n 137 ap 235", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w300, color: Color.fromRGBO(0, 0,0,0.7))),
                        ),
                      ],
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 2, 4),
                          child:  Text("status evento: ", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500, color: primaryColor)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                          child: Text("agendado".toUpperCase(), style: TextStyle( fontSize: 16, fontWeight: FontWeight.w700 , color: primaryColor)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 2, 4),
                          child:  Text("status contratacoes: ", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500, color: primaryColor)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                          child: Text("Contratando", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w700, color: Color.fromRGBO(0, 0,0,0.7))),
                        ),
                      ],
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Text("sobre o evento", style: TextStyle( fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black)),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      child: Text("aqui é uma das maiores casas de eventos da zona norte, estamos sempre contratando por aqui", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w300, color: Color.fromRGBO(0, 0, 0, 0.7))),
                    ), 
                    Divider(), 
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 4),
                        child: Text("105 de 350 funcionarios contratados: ", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w300, color: Color.fromRGBO(0, 0,0,0.7)),
                      ),  
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        Row(   
                          mainAxisSize: MainAxisSize.min,
                          children: [
                             Icon(EventuauIcons.garcom_logo,  size: 32, color: primaryColor,),
                             SizedBox(width: 4),
                             Text("40/80", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54)),
                          ],  
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(EventuauIcons.clown,  size: 32, color: primaryColor),
                            SizedBox(width: 4),
                            Text("20/20", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54)),
                          ],
                        ),      
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                             Icon(EventuauIcons.buffet,  size: 32, color: primaryColor),
                             SizedBox(width: 4),
                             Text("110/150", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54)),
                          ],   
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(EventuauIcons.grill,  size: 32, color: primaryColor),
                            Text("110/150", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54)),
                          ],
                        ),
                      ]
                    ),
                    SizedBox(height: 24),
                    Align(
                      alignment: Alignment.center,
                      child: RaisedButton.icon(
                      onPressed: (){
                        Navigator.pushNamed(context, "/employee/management");
                      },
                      padding: EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
                       icon: Icon(Icons.assignment_ind, size: 16), 
                       label: Text("Gerenciador de Funcionarios"),
                       color: primaryColor,
                       textColor: colorBg,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(15)
                       ),
                      ),
                    ),  
                    Divider(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Text("observacoes", style: TextStyle( fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black)),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      child: Text("os garçons que participarao desse evento terão de usar uma roupa especial designada pela empresa aqui contratante", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w300, color: Color.fromRGBO(0, 0, 0, 0.7))),
                    ), 
                    Divider(),
                    setButton(
                       text: "salvar alteracoes",
                       uppercase: true,
                       icon: Icons.save,
                    ),
                    setButtonText(
                       text: "deletar evento",
                       icon: Icons.delete_outline,
                       uppercase: true,
                       color: Colors.red.shade400
                    )
                  ],
                ),
            )
         ) ,
       ),
    );
  }
}