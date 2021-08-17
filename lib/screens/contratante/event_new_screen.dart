import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/components/input_form_eventual.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EventNewScreen extends StatefulWidget {
  
  const EventNewScreen({ Key
   key }) : super(key: key);

  @override
  _EventNewScreenState createState() => _EventNewScreenState();
}

class _EventNewScreenState extends State<EventNewScreen> {

  int _valueDropdownStatusEvent = 1;
  bool _contratacaoEmergencia = false;
  bool _visivelPraFuncionarios = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(context, title: "Criar Evento", username: "Antonio conceicao"),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              setInputForm(context, labeltext: "Nome do evento:"),
              setInputForm(context, labeltext: "Descricão:" ),
              setInputForm(context, labeltext: "Data do evento:", keyboardType: TextInputType.datetime),
              setInputForm(context, labeltext: "Hora do evento:", keyboardType: TextInputType.number),
              setInputForm(context, labeltext: "Duração Minima",  keyboardType: TextInputType.number ),
              setInputForm(context, labeltext: "Duração Maxima",  keyboardType: TextInputType.number ),
              ListTile( 
                leading: Text("Status Contratacao: ", style: TextStyle(fontSize: 16),),
                title: DropdownButton(   
                  value:  _valueDropdownStatusEvent,
                  dropdownColor: Color.fromRGBO(255, 255, 255, 1.0),
                  style: TextStyle(fontSize: 12 , color: primaryColor, fontWeight: FontWeight.w700),
                  focusColor: primaryColor,
                  itemHeight: 50,
                  items: [
                    DropdownMenuItem(
                      child: Text("SEM CONTRATAR" , style: TextStyle(fontSize: 12),),
                      value: 0,  
                    ),
                    DropdownMenuItem(
                      child: Text("CONTRATANDO", style: TextStyle(fontSize: 12),),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("TODOS CONTRATADOS", style: TextStyle(fontSize: 12),),
                      value: 2,
                    ),
                  ],
                  onChanged: (int value){
                    setState(() {
                      _valueDropdownStatusEvent = value;
                    });
                  }
                ), 
              ),
              SwitchListTile(
                title: Text("Visivel para funcionarios"),
                value: _visivelPraFuncionarios,
                activeColor: primaryColor,
                inactiveTrackColor: colorBg,
                onChanged: (bool value){
                  setState(() {
                     _visivelPraFuncionarios = value;
                  });
                },
              ),
              SwitchListTile(
                title: Text("Contratacao de emergencia"),
                value: _contratacaoEmergencia,
                activeColor: primaryColor,
                inactiveTrackColor: colorBg,
                onChanged: (bool value){
                  setState(() {
                     _contratacaoEmergencia = value;
                  });
                },
              ),
              Divider(),
               Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 0, 2),
                child: Text("Contrate funcionarios para seu evento", style: TextStyle( fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black)),
               ), 
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 4, 0, 4),
                child: Text("maximo numero de funcionarios a serem contratados do tipo...", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w500, color: primaryColor)),
              ), 
              SizedBox(height: 24),
              _setFieldTypeEmployeeSettings(text: "GARÇOM"),
              _setFieldTypeEmployeeSettings(text: "ANIMADORES"),
              _setFieldTypeEmployeeSettings(text: "BUFFETS"),
              _setFieldTypeEmployeeSettings(text: "CHURRASQUEIROS"),
              SizedBox(height:24),
              Align(
                alignment: Alignment.center,
                child: RaisedButton.icon(
                  onPressed: (){
                    Navigator.pushNamed(context, "/employees");
                  },
                  padding: EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
                  icon: Icon(Icons.search, size: 16), 
                  label: Text("IR PRA TELA DE ESCOLHAS"),
                  color: primaryColor,
                  textColor: colorBg,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
              SizedBox(height: 24,),
              Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 7,
                  decoration: InputDecoration(
                    fillColor: colorBg,
                    hintText: "observacoes sobre o evento",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              Divider(),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                  child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("VALOR TOTAL: ", style: TextStyle(fontSize: 16, color: primaryColor, fontWeight: FontWeight.w700)),
                    Text("R\$ 350,00", style: TextStyle(fontSize: 24, color: primaryColor, fontWeight: FontWeight.w700)),
                  ] 
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text("saldo disponivel: ", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700)),
                    Text("R\$ 420,00", style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.w700)),
                  ] 
                ),
              ),
              SizedBox(height: 24),
              setButton(text: "Publicar evento", uppercase: true, 
                function: (){
                  Navigator.pop(context);
              }),
            ]   
          )
        ),
      ),
    );
  }

  Widget _setFieldTypeEmployeeSettings({String text}) =>
    ListTile(
      leading:  Text(text?? "", style: TextStyle( fontSize: 16 , height: 1.5), textAlign: TextAlign.center,),
      trailing: SizedBox(
         width: 50,
        child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "0",
              isCollapsed: true,
              alignLabelWithHint: true,
              contentPadding: EdgeInsets.symmetric(vertical:4),
              border: OutlineInputBorder(),
            ),     
          ),
        )
    );
  

  
}

