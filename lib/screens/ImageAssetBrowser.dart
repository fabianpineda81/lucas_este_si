import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageAssetBrowser extends StatefulWidget {
  ImageAssetBrowser({Key key}) : super(key: key);

  @override
  _ImageAssetBrowserState createState() {
    SharedPreferences.getInstance().then((prefs) {
      return _ImageAssetBrowserState();
    });
    return _ImageAssetBrowserState();
  }
}

class _ImageAssetBrowserState extends State<ImageAssetBrowser> {
  //final TextEditingController _textController = new TextEditingController();

  //_ImageAssetBrowserState() {};

  List<String> assetImages = <String>[];

  @override
  void initState() {
    super.initState();

    // // Unlock
    // L.item('unlock').then((str) {
    //   setState(() {
    //     _strUnlock = str;
    //   });
    // });

    DefaultAssetBundle.of(context)
        .loadString('AssetManifest.json')
        .then((manifestContent) {
      final Map<String, dynamic> manifestMap = json.decode(manifestContent);

      final imagePaths = manifestMap.keys
          .where((String key) => key.contains('images/'))
          .toList();

      setState(() {
        assetImages = imagePaths;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Library browser"),
      ),
      body: GridView.builder(
          itemCount: assetImages.length,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
              child: new Card(
                  elevation: 5.0,
                  child: Image.asset(assetImages[index]) == null
                      ? Container()
                      : Image.asset(assetImages[index])
                  // new Container(
                  //   alignment: Alignment.center,
                  //   child: new Text(assetImages[index]),
                  // ),
                  ),
              onTap: () {
                Navigator.of(context).pop(assetImages[index]);
                // showDialog(
                //   barrierDismissible: false,
                //   context: context,
                //   child: new CupertinoAlertDialog(
                //     title: new Column(
                //       children: <Widget>[
                //         new Text("GridView"),
                //         new Icon(
                //           Icons.favorite,
                //           color: Colors.green,
                //         ),
                //       ],
                //     ),
                //     content: new Text("Selected Item $index"),
                //     actions: <Widget>[
                //       new TextButton(
                //           onPressed: () {
                //             Navigator.of(context).pop();
                //           },
                //           child: new Text("OK"))
                //     ],
                //   ),
                // );
              },
            );
          }),
      //Container(child: getFutureLevelListView(context)),
    );
  }
}
