import 'package:event_uau/components/app_bar_eventual.dart';
import 'package:event_uau/components/card_employee.dart';
import 'package:event_uau/models/contratado_model.dart';
import 'package:event_uau/models/evento_model.dart';
import 'package:event_uau/models/funcionario_model.dart';
import 'package:event_uau/providers/auth.dart';
import 'package:event_uau/providers/employee_wallet_data.dart';
import 'package:event_uau/providers/event.dart';
import 'package:event_uau/service/contratado_service.dart' as ContratadoService;
import 'package:event_uau/utils/colors.dart';
import 'package:event_uau/utils/icons.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EmployeeChoiceScreen extends StatefulWidget {
  const EmployeeChoiceScreen({
    Key key,
  }) : super(key: key);

  static const routeName = 'event/employee-choice-screen';

  @override
  _EmployeeChoiceScreenState createState() => _EmployeeChoiceScreenState();
}

class _EmployeeChoiceScreenState extends State<EmployeeChoiceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //o numero de icones abaixo tem que ser sempre igual ao comprimento desse array, se não dara erro.
  Future _fetchPartnersFutureRef;
  List<bool> _isSelected = [true, false, false, false, false, false];

  List<int> idsEscolhidos = [];
  List<ContratadoModel> employees = [];
  List<ContratadoModel> filteredEmployees = [];
  double _avaliableBalance = 0.0;

  @override
  void initState() {
    _fetchPartnersFutureRef = fetchPartners();
    _avaliableBalance = Provider.of<EmployeeWalletData>(context, listen: false)
        .avaliableBalance;

    if (_avaliableBalance == 0)
      Future.delayed(Duration(milliseconds: 500)).then((value) =>
          ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
              backgroundColor: Colors.blue,
              contentTextStyle:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              leading: Icon(
                Icons.credit_card,
                color: Colors.white,
              ),
              content: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Você está sem saldo. \n',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          'Adicione saldo agora e faça sua primeira contratação!')
                ]),
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
                  child: Text(
                    'Fechar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                    Navigator.of(context)
                        .popUntil((route) => route.settings.name == '/');
                  },
                  child: Text(
                    'Ir para a minha carteira',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ])));
    super.initState();
  }

  _onSubmit() async {
    final finalPrice = getFinalPrice();

    if (_avaliableBalance < finalPrice) {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Fechar',
              ),
            ),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
                Navigator.of(context)
                    .popUntil((route) => route.settings.name == '/');
              },
              child: Text(
                'Ir para a minha carteira',
              ),
            )
          ],
          title: Text('Saldo Insuficientes'),
          content: Text(
              'Adicione R\$${(finalPrice - _avaliableBalance).toStringAsFixed(2)} para finalizar a contratação'),
        ),
      );
    }

    final eventId =
        (ModalRoute.of(context).settings.arguments as Map)['eventId'];

    final _employees = employees
        .where((element) => idsEscolhidos.contains(element.id))
        .toList();

    await Provider.of<Event>(context, listen: false)
        .addEmployeesToEvent(_employees, eventId);

    Navigator.pop(context);
  }

  double getFinalPrice() {
    final _selectedEmployees =
        employees.where((element) => idsEscolhidos.contains(element.id));

    final duration =
        (ModalRoute.of(context).settings.arguments as Map)['duration'];

    return _selectedEmployees.fold(
        0,
        (previousValue, element) =>
            previousValue += (element.valorHora * duration));
  }

  void setCurrentFilter(int index) {
    final filters = [
      'todos',
      'garçom',
      'animador',
      'churrasqueiro',
      'fotografo',
      'cozinheiro'
    ];

    List<bool> newList = [..._isSelected];

    final previousIndex = newList.indexOf(true);

    newList[previousIndex] = false;
    newList[index] = true;

    setState(() {
      _isSelected = newList;
      filteredEmployees = index == 0
          ? employees
          : employees
              .where((element) => element.especialidades.any((element) =>
                  filters[index] == element.descricao.toLowerCase()))
              .toList();
    });
  }

  void selectEmployee(int id) => setState(() {
        if (idsEscolhidos.indexOf(id) != -1)
          idsEscolhidos.remove(id);
        else
          idsEscolhidos.add(id);
      });

  Future<void> fetchPartners() async {
    final res = await ContratadoService.getAllPartners();

    if (res['total'] == 0) return;

    final results = res['resultados'] as List;
    List<ContratadoModel> _employees = [];

    results.forEach((element) {
      final userInfo = element['usuario'];
      final especialidades = element['especialidades'] as List;

      _employees.add(
        new ContratadoModel(
          id: userInfo['id'],
          nome: userInfo['nome'],
          cpf: userInfo['cpf'],
          phone: userInfo['telefone'],
          valorHora: double.parse(element['valorHora'].toString()),
          birthDate: DateTime.parse(userInfo['dataNascimento']),
          especialidades: especialidades
              .map((e) => JobItem(id: e['id'], descricao: e['descricao']))
              .toList(),
          status: userInfo['status'],
        ),
      );
    });

    setState(() {
      employees = _employees;
      filteredEmployees = _employees;
    });
  }

  @override
  Widget build(BuildContext context) {
    final duration =
        (ModalRoute.of(context).settings.arguments as Map)['duration'];
    PreferredSizeWidget appBar = EventUauAppBar(
      title: 'Eu preciso de um...',
    );

    return WillPopScope(
      onWillPop: () => Future(() {
        ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
        return true;
      }),
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButton: idsEscolhidos.length > 0
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: Container(
                      child: Text(
                        '${idsEscolhidos.length} parceiro${idsEscolhidos.length > 1 ? 's' : ''} escolhido${idsEscolhidos.length > 1 ? 's' : ''}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: Container(
                      child: Text(
                        'Total: R\$${getFinalPrice().toStringAsFixed(2)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  FloatingActionButton(
                    onPressed: _onSubmit,
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              )
            : null,
        appBar: appBar,
        // backgroundColor: colorBg,
        body: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ToggleButtons(
                children: [
                  JobTypeButton(icon: Icons.all_inclusive, title: "todos"),
                  JobTypeButton(
                      icon: EventuauIcons.garcom_logo, title: "garçom"),
                  JobTypeButton(icon: EventuauIcons.clown, title: "animador"),
                  JobTypeButton(
                      icon: EventuauIcons.grill, title: "churrasqueiro"),
                  JobTypeButton(
                      icon: Icons.camera_enhance_outlined, title: "fotógrafo"),
                  JobTypeButton(icon: EventuauIcons.grill, title: "cozinheiro"),
                ],
                isSelected: _isSelected,
                onPressed: setCurrentFilter,
                selectedColor: primaryColor,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                color: Color.fromRGBO(0, 0, 0, 0.3),
                renderBorder: false,
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.15,
                    minWidth:
                        MediaQuery.of(context).size.width / _isSelected.length),
                focusColor: primaryColor,
              ),
            ),
            Container(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).viewPadding.top) *
                  0.84,
              child: FutureBuilder(
                future: _fetchPartnersFutureRef,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    Center(
                      child: CircularProgressIndicator(),
                    );

                  if (snapshot.hasData == false)
                    Center(
                      child: Text('Houve um erro ao buscar parceiros...'),
                    );

                  return employees.length == 0
                      ? Center(
                          child: Text('Não foram encontrados parceiros...'),
                        )
                      : GridView.count(
                          padding: EdgeInsets.only(bottom: 70),
                          crossAxisCount: 2,
                          children: filteredEmployees
                              .map((e) => EmployeeCard(
                                    choose: selectEmployee,
                                    isSelected:
                                        idsEscolhidos.indexOf(e.id) != -1,
                                    contratado: e,
                                    horas: duration,
                                  ))
                              .toList(),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobTypeButton extends StatelessWidget {
  const JobTypeButton({Key key, this.icon, this.title, this.isSelected})
      : super(key: key);

  final IconData icon;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(children: <Widget>[
        Icon(icon),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(title ?? ""),
        )
      ]),
    );
  }
}
