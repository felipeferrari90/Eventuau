import 'package:flutter/material.dart';

class ShiftSelection extends StatefulWidget {
  const ShiftSelection({Key key}) : super(key: key);

  @override
  _ShiftSelectionState createState() => _ShiftSelectionState();
}

class _ShiftSelectionState extends State<ShiftSelection> {
  Map<String, Map<String, dynamic>> _shiftSettings = {
    'Seg': {'label': 'Seg', 'enabled': true, 'values': RangeValues(0, 23)},
    'Ter': {'label': 'Ter', 'enabled': false, 'values': RangeValues(0, 23)},
    'Qua': {'label': 'Qua', 'enabled': false, 'values': RangeValues(0, 23)},
    'Qui': {'label': 'Qui', 'enabled': false, 'values': RangeValues(0, 23)},
    'Sex': {'label': 'Sex', 'enabled': false, 'values': RangeValues(0, 23)},
    'Sab': {'label': 'Sab', 'enabled': false, 'values': RangeValues(0, 23)},
    'Dom': {'label': 'Dom', 'enabled': false, 'values': RangeValues(0, 23)},
  };

  List<Widget> buildShiftItem() {
    return _shiftSettings.keys
        .map((key) => ShiftItem(
              label: _shiftSettings[key]['label'],
              enabled: _shiftSettings[key]['enabled'],
              sliderValues: _shiftSettings[key]['values'],
              onChangedCheckbox: (value) =>
                  setState(() => {_shiftSettings[key]['enabled'] = value}),
              onChanged: (RangeValues values) =>
                  setState(() => {_shiftSettings[key]['values'] = values}),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        titlePadding: EdgeInsets.all(14),
        contentPadding: EdgeInsets.zero,
        title: Text(
          'Escala de Trabalho',
          style: Theme.of(context).textTheme.headline1.copyWith(fontSize: 18),
        ),
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildShiftItem()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'CANCELAR',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).pop(), // SEND SHIFTSETTINGS DOWN
            child: Text(
              'CONCLUIDO',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

class ShiftItem extends StatelessWidget {
  const ShiftItem({
    Key key,
    this.label,
    this.onChanged,
    this.onChangedCheckbox,
    this.sliderValues,
    this.enabled,
  }) : super(key: key);

  final String label;
  final Function onChanged;
  final Function onChangedCheckbox;
  final RangeValues sliderValues;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(
            activeColor: Theme.of(context).primaryColor,
            value: enabled,
            onChanged: onChangedCheckbox,
          ),
          Container(
              constraints: BoxConstraints(minWidth: 35), child: Text(label)),
          Expanded(
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                valueIndicatorTextStyle: TextStyle(fontSize: 16),
              ),
              child: RangeSlider(
                  activeColor: Theme.of(context).primaryColor,
                  divisions: 23,
                  min: 0,
                  max: 23,
                  labels: RangeLabels(
                    '${sliderValues.start.round()}h',
                    '${sliderValues.end.round()}h',
                  ),
                  values: sliderValues,
                  onChanged: enabled ? onChanged : null),
            ),
          )
        ],
      ),
    );
  }
}
