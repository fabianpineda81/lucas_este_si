import 'package:flutter/material.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/localizations/L.dart';

class VoiceSelector extends StatefulWidget {
  VoiceSelector(
      {Key key, String languageCountry})
      : super(key: key);

  final String languageCountry='';

  @override
  _VoiceSelectorState createState() => _VoiceSelectorState(languageCountry:languageCountry);
}

class _VoiceSelectorState extends State<VoiceSelector> {

  _VoiceSelectorState(
      {String languageCountry});

  String languageCountry='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getLocalizedText("select voice"),
      ),
      body: getFutureVoicesListView(
          context),
    );
  }

  Widget getLocalizedText(String item) {
    return FutureBuilder(
      future: L.item(item),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('');
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          case ConnectionState.active:
            return new Text('');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return new Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else {
              return Text(snapshot.data);
            }
        }
        return Text("");
      },
    );
  }

  Widget getFutureVoicesListView(BuildContext context) {
    return FutureBuilder(
      future: L.getPossibleLanguageCountryCodes(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new Text('');
          case ConnectionState.waiting:
            return new Center(child: new CircularProgressIndicator());
          case ConnectionState.active:
            return new Text('');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return new Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else {
              Map<String, String> possibleLanguageCountryCodes = snapshot.data;
              return getVoicesListView(context, possibleLanguageCountryCodes);
            }
        }
        return Text("");
      },
    );
  }

  Widget getVoicesListView (
      BuildContext context,
      Map<String, String> possibleLanguageCountryCodes) {

    final items = <Widget>[];    

    possibleLanguageCountryCodes.forEach((k, v) {
      ListTile listTile = ListTile(
          leading: Icon(
                  Icons.keyboard_voice,
                ),
        title: Text(v),
        subtitle: Text(k),
        onTap: () async {
          await LocalPreferences.setString("languageCountry", k);
          Navigator.of(context).pop();
        },
        selected: (k == languageCountry),
      );
      items.add(listTile);
    });

    if (possibleLanguageCountryCodes.isEmpty) {
      ListTile listTile = ListTile(
        title: L.getLocalizedText('no valid voice found'),
      );
      items.add(listTile);
    }

    ListView voicesListView = ListView(
      children: items,
    );

    return voicesListView;
  }
}
