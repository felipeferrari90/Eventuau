import 'package:event_uau/components/card_event.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/repository/evento_repository.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';


class DashBoardScreenEvents extends StatefulWidget {
  const DashBoardScreenEvents({ Key key }) : super(key: key);

  @override
  _DashBoardScreenEventsState createState() => _DashBoardScreenEventsState();
}

class _DashBoardScreenEventsState extends State<DashBoardScreenEvents> {

  
 EventoRepository eventosRepository = new EventoRepository();
 


  

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.all(16),
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only( bottom: 10),
              child: Text("MEUS EVENTOS",
                style: TextStyle(
                  fontSize: 24,
                  color: primaryColor,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16,),
                    child: Icon(Icons.history, 
                      size: 32,
                      color: pink,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/event/new");
                    },
                    color: primaryColor,
                    textColor: colorBg,                  
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),            
                    child: Padding(
                      padding:  EdgeInsets.symmetric( horizontal: 12 , vertical: 10),
                      child: Text("Criar Evento"),
                    ) 
                  ) ,
                  )
                ],
              ),
              Container(
                child: Expanded(
                  child:SingleChildScrollView(
                    child:  FutureBuilder<List<EventoModel>>(
                      future: eventosRepository.getAllEventosByIdContratante(), 
                      builder: (context, snapshot){
                        
                          if(snapshot.hasData){
                            snapshot.data.map((element) => {
                            setCardEvent(context, eventoModel:element)}); 
                          } else{
                            return Center(
                               child: CircularProgressIndicator()
                          );
                          }
                          if(snapshot.data.length == 0){
                              return Container(
                                child: Text("você não possui eventos criados\ncrie um evento para contratar funcionarios",textAlign: TextAlign.center , style: TextStyle(fontSize: 16, color: Colors.black54,))
                              );
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              
                            )
                          );
            
                      },
                    ),
                  )
                 
                  /*child: listaEventos.length == 0 ?  Container(
                      child: Text("você não possui eventos criados\ncrie um evento para contratar funcionarios",textAlign: TextAlign.center , style: TextStyle(fontSize: 16, color: Colors.black54,))
                    ): SingleChildScrollView(
                    child: Column( 
                      mainAxisAlignment: listaEventos.length == 0? MainAxisAlignment.center : MainAxisAlignment.center ,
                      children:[
                         listaEventos.length == 0 ? Center(
                           child: Container(
                             child: Text("você não possui eventos criados\ncrie um evento para contratar funcionarios",textAlign: TextAlign.center , style: TextStyle(fontSize: 16, color: Colors.black54,))
                           )
                         ) : listaEventos.map((element) => setCardEvent(context, eventoModel: element))
                      ]
                    ),
                  )*/,
                )
              ),
            ],
          ),
        );
  }
}