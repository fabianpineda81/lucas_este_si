import 'package:flutter/material.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/models/LucasState.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';

class GridSettings extends StatefulWidget {
  final String strAppTitle;
  final String strInstructions;
  final String strColumns;
  final String strRows;

  GridSettings(this.strAppTitle, this.strInstructions, this.strColumns, this.strRows, {Key key}) : super(key: key);

  @override
  _GridSettingsState createState() => _GridSettingsState(this.strAppTitle, this.strInstructions, this.strColumns, this.strRows);
}

class _GridSettingsState extends State<GridSettings> {
  final String strAppTitle;
  final String strInstructions;
  final String strColumns;
  final String strRows;

  double _columns = 6.0;
  double _rows = 6.0;

  _GridSettingsState(this.strAppTitle, this.strInstructions, this.strColumns, this.strRows);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final lucasState = PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    _columns = lucasState.getGridColumns().toDouble();
    _rows = lucasState.getGridRows().toDouble();

    return Scaffold(
      appBar: AppBar(
        title: Text(strAppTitle),
        //title: L.getLocalizedText('grid'),
      ),
      body: getGridOptionsListView(context),
    );
  }

  Widget getGridOptionsListView(BuildContext context) {
    ListView settingListView = ListView(
      children: <Widget>[
        Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
            child: ListTile(
                subtitle: Text(strInstructions),
                ),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(strColumns + ' (${_columns.toInt()})'),
            subtitle: Slider(
              min: 1,
              max: 15,
              onChanged: (newColumns) async {
                await LocalPreferences.setInt("gridColumns", newColumns.toInt());

                final lucasState = PropertyChangeProvider.of<LucasState>(context, listen: false).value;
                lucasState.setGridColumns(newColumns.toInt());

                setState(() => _columns = newColumns);
              },
              value: _columns,
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(strRows + ' (${_rows.toInt()})'),
            subtitle: Slider(
              min: 1,
              max: 15,
              onChanged: (newRows) async {
                await LocalPreferences.setInt("gridRows", newRows.toInt());

                final lucasState = PropertyChangeProvider.of<LucasState>(context, listen: false).value;
                lucasState.setGridRows(newRows.toInt());

                setState(() => _rows = newRows);
              },
              value: _rows,
            ),
          ),
        ),
      ],
    );

    return settingListView;
  }
}
