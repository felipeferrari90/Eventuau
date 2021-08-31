import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/buttons.dart';
import 'package:event_uau/components/input_form_eventual.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:event_uau/models/contratante_model.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EventNewScreen extends StatefulWidget {
  const EventNewScreen({ Key?
   key }) : super(key: key);

  @override
  _EventNewScreenState createState() => _EventNewScreenState();
}

class _EventNewScreenState extends State<EventNewScreen> {

  int _valueDropdownStatusEvent = 1;
  bool _visivelPraFuncionarios = true;
 
  final GlobalKey<FormState> _formKeyNewEvent = new GlobalKey<FormState>();


  EventoModel eventoModel = new EventoModel();

  void _onSubmit() {
    if (!_formKeyNewEvent.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("erro ao criar evento, verifique se os dados estão validos"))
      );
    }
    _formKeyNewEvent.currentState!.save();
    print(eventoModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(context, title: "Criar Evento", username: "Antonio conceicao"),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[ 
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(labelText: 'Nome do evento'),
                textInputAction: TextInputAction.next,
                inputFormatters: [
                        
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Campo Obrigatório";
                  }
                  return null;
                },
                onSaved: (value) {
                  eventoModel.nome = value;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 7,
                decoration: InputDecoration(
                  fillColor: colorBg,
                  hintText: "descrição sobre o evento",
                  hintStyle: TextStyle(color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                validator:(value) {
                   if(value.toString().length > 150){
                      return "texto excedeu o limite de 150 caracteres";
                   }
                   return null;
                },
                onSaved: (value){
                    eventoModel.descricao = value.toString();
                }
              ), 
              TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(labelText: 'Data do evento'),
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Campo Obrigatório";
                  }
                  return null;
                },
                onSaved: (value) {
                  eventoModel.dataEHorarioInicio = DateFormat.yMd("pt_BR").parse(value as String);
                },
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(labelText: 'Hora do evento'),
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  HoraInputFormatter()
                ],
                validator: (value) { 
                  if(!RegExp(r"/^(02[0-3]):([0-5][0-9])$/").hasMatch(value.toString())){
                    return "digite uma Hora valida";
                  }
                },
                onSaved: (value) {
                  var _ponteiros = (value as String).split(":");
                  eventoModel.dataEHorarioInicio!.add(Duration(hours:int.parse(_ponteiros[0]),minutes: int.parse(_ponteiros[1])));
                },
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(labelText: 'Duracao Minima'),
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  HoraInputFormatter(),
                ],
                validator: (value) { 
                    if(!RegExp(r"/^(02[0-3]):([0-5][0-9])$/").hasMatch(value.toString())){
                      return "digite um tempo valido";
                    }
                    DateTime tempo = DateFormat.Hm("pt_BR").parse(value as String);
                    if(tempo.hour > 20 || tempo.hour < 1 ){
                      return "evento deve ter um tempo minimo entre 1 a 23 horas";
                    }
                  
                },
                onSaved: (value) {
                  var _ponteiros = (value as String).split(":");
                  eventoModel.tempoDuracaoMinimoPreDeterminado = Duration(hours:int.parse(_ponteiros[0]),minutes: int.parse(_ponteiros[1]));
                  if(eventoModel.tempoDuracaoMaximoPreDeterminado == null){
                    eventoModel.tempoDuracaoMaximoPreDeterminado = eventoModel.tempoDuracaoMinimoPreDeterminado;
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(labelText: 'Duracao Maxima'),
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  HoraInputFormatter(),
                ],
                validator: (value) { 
                    if(eventoModel.tempoDuracaoMinimoPreDeterminado == null){
                      return "digite primeiro o tempo minimo";
                    }
                    if(!RegExp(r"/^(02[0-3]):([0-5][0-9])$/").hasMatch(value.toString())){
                      return "digite um tempo valido";
                    }
                    DateTime tempo = DateFormat.Hm("pt_BR").parse(value as String);
                    if(tempo.hour > 20 || tempo.hour < 1 ){
                      return "evento deve ter um tempo maximo entre 1 a 22 horas";
                    }
                    if(eventoModel.tempoDuracaoMinimoPreDeterminado == null){
                      return "digite primeiro o tempo minimo";
                    }
                    if(tempo.microsecondsSinceEpoch < eventoModel.tempoDuracaoMinimoPreDeterminado!.inMicroseconds ){
                      return "tempo maximo deve ser maior que o tempo minimo";
                    }
                    return null;
                },
                onSaved: (value) {
                  var _ponteiros = (value as String).split(":");
                  eventoModel.tempoDuracaoMinimoPreDeterminado = Duration(hours:int.parse(_ponteiros[0]),minutes: int.parse(_ponteiros[1]));
                },
              ),
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
                      value: StatusContratacaoEvento.SEM_CONTRATAR,  
                    ),
                    DropdownMenuItem(
                      child: Text("CONTRATANDO", style: TextStyle(fontSize: 12),),
                      value: StatusContratacaoEvento.CONTRATANDO_FUNCIONARIOS,
                    ),
                    DropdownMenuItem(
                      child: Text("TODOS JA CONTRATADOS", style: TextStyle(fontSize: 12),),
                      value: StatusContratacaoEvento.FUNCIONARIOS_CONTRATADOS,
                    ),
                  ],
                  onChanged: (value){
                    setState(() {
                      eventoModel.statusContratacaoEvento = value as StatusContratacaoEvento;
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
                child: ElevatedButton.icon(
                  onPressed: (){
                    Navigator.pushNamed(context, "/employees");
                  },  
                  icon: Icon(Icons.search, size: 16), 
                  label: Text("IR PRA TELA DE ESCOLHAS"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
                    onPrimary: primaryColor,
                    onSurface: colorBg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24,),
              Padding(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 7,
                  validator: (value){
                    if(value.toString().length > 150){
                       return "observação do event0 deve ter menos de 250 caracteres";
                    }
                  },
                  onSaved: (value){
                    eventoModel.observacoes = value as String;
                  },
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
                    Text("VALOR TOTAL:  ", style: TextStyle(fontSize: 16, color: primaryColor, fontWeight: FontWeight.w700)),
                    Text("350,00", style: TextStyle(fontSize: 24, color: primaryColor, fontWeight: FontWeight.w700)),
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
                onPressed: (){
                  Navigator.pop(context);
              }),
            ]   
          )
        ),
      ),
    );
  }

  Widget _setFieldTypeEmployeeSettings({String? text}) =>
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

