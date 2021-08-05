import 'package:event_uau/models/funcionario_model.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:event_uau/utils/icons.dart';
import 'package:flutter/material.dart';

Widget setCardEmployee(context,{FuncionarioModel funcionario}) => 
  Container(
     padding: EdgeInsets.all(8.0),
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(15.0),
       color: Colors.white,
     ),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         /*Image.network(
          "https://www.bing.com/images/search?view=detailV2&ccid=DF2CgRNd&id=70DA739CA995882860F788653AC52907DDE0A7D6&thid=OIP.DF2CgRNdVeHMVo1uxpjZMwAAAA&mediaurl=https%3a%2f%2fgbaservicos.com%2fcontent%2fuploads%2f2018%2f08%2fgarcom.jpg&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.0c5d8281135d55e1cc568d6ec698d933%3frik%3d1qfg3QcpxTpliA%26pid%3dImgRaw&exph=240&expw=300&q=gar%c3%a7om&simid=608043403599306508&FORM=IRPRST&ck=174407051DFA7FFE27A9B70AB08A0DBC&selectedIndex=5&ajaxhist=0&ajaxserp=0",
           scale: 0.5,
         ),*/
         Container(
           height: 104,

         ),
         Padding(
           padding: EdgeInsets.fromLTRB(1, 0, 0, 8),
           child: Text("Pedro Lemes, 24", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black)),
         ),
         Padding(
           padding: EdgeInsets.fromLTRB(4, 0, 0, 4),
           child: Text("300+ horas trabalhadas", style: TextStyle( fontSize: 12, fontWeight: FontWeight.w500, color: primaryColor)),
         ), 
         Row(////
           children: [
             Padding(
               padding: EdgeInsets.fromLTRB(4, 0, 0, 4),
               child: Icon(EventuauIcons2.star,  size: 16, color: yellow,),
             ),
             Padding(
               padding: EdgeInsets.fromLTRB(2, 0, 0, 4),
               child: Text("4.86/5", style: TextStyle( fontSize: 12, fontWeight: FontWeight.w500, color: primaryColor)),
             ),
             Padding(
               padding: EdgeInsets.fromLTRB(8, 0, 0, 4),
               child: Icon(EventuauIcons2.dollar,  size: 16, color: yellow,),
             ),
             Padding(
               padding: EdgeInsets.fromLTRB(2, 0, 0, 4),
               child: Text("RS 10,00/h", style: TextStyle( fontSize: 12, fontWeight: FontWeight.w500, color: primaryColor)),
             )
           ],
         ),  
         Padding(
           padding: EdgeInsets.only(top: 8),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(right: 8) ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                    color: primaryColor,
                  ),
                child: InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12 , vertical: 4),
                      child: Icon(EventuauIcons2.handshake , color: colorBg ,semanticLabel: "contratar", size: 40),  
                    ),
                )
              ),
              Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                  color: accentColor,
                ),
                child: InkWell(
                  onTap: (){
                     Navigator.pushNamed(context, "/employees/id");
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12 , vertical: 4),
                      child: Icon(EventuauIcons2.cancel, color: primaryColor ,semanticLabel: "recusar" , size: 40),  
                    ),
                )
              ),
            ],
          )
        ),
        
      ]
    ),
  );


