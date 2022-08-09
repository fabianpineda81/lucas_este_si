import 'package:flutter/material.dart';
import 'package:lucas/localizations/L.dart';

class LDrawer extends StatefulWidget {

  LDrawer();

  @override
  _LDrawerState createState() => _LDrawerState();
}

class _LDrawerState extends State<LDrawer> {
  Map<String, String> translations = Map<String, String>();

  List<String> translationItems = [
    'unlock',
    'lock',
    'understood',
    'not understood',
  ];

  _LDrawerState() {
    for (int i = 0; i < translationItems.length; i++) {
      translations[translationItems[i]] = '';
    }
  }

  @override
  void initState() {
    super.initState();

    initialize().then((result) {
      setState(() {});
    });
  }

  Future<void> initialize() async {

    Map<String, String> result = await L.getItems(translationItems);
    setState(() {
      translations = result;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container();
  }
}
