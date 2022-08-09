import 'package:flutter/material.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/localizations/L.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpVideos extends StatefulWidget {
  HelpVideos({Key key}) : super(key: key);

  @override
  _HelpVideosState createState() => _HelpVideosState();
}

class _HelpVideosState extends State<HelpVideos> {

  bool canShowVideos = false;
  Map<String, String> videoTranslations = Map<String, String>();

  @override
  void initState() {

    loadHelpScreensTranslationTexts().then((result) {
      setState(() {
        canShowVideos = true;
      });
    });

    super.initState();
  }

  Future<void> loadHelpScreensTranslationTexts() async {
    List<String> videoTranslationsItems = [
      'video_title1',
      'video_title2',
      'video_title3',
      'video_title4',
      'video_title5',
      'video_title6',
      'video_title7',
      'video_title8',
      'video_title9',
      'video_title10',
      'video_title11',
      'video_title12',
      'video_title13',
      'video_text1',
      'video_text2',
      'video_text3',
      'video_text4',
      'video_text5',
      'video_text6',
      'video_text7',
      'video_text8',
      'video_text9',
      'video_text10',
      'video_text11',
      'video_text12',
      'video_text13',
    ];

    for (int i = 0; i < videoTranslationsItems.length; i++) {
      videoTranslations[videoTranslationsItems[i]] = '';
    }

    Map<String, String> result = await L.getItems(videoTranslationsItems);

    if (mounted) {
      setState(() {
        videoTranslations = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!canShowVideos) return Container();

    return WillPopScope(
      onWillPop: handleBackButton,
      child: Scaffold(
        appBar: AppBar(
          title: getLocalizedText("help videos"),
        ),
        body: showListOfVideos(),
      ),
    );
  }

  Widget showListOfVideos() {
    return SingleChildScrollView(
          child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile( 
              onTap: () => launch('https://youtu.be/CHcj3ZXz20s'),
              title: Text(videoTranslations['video_title1']),
              subtitle: Text(videoTranslations['video_text1'])
            ),
            ListTile(
              onTap: () => launch('https://youtu.be/LK0rw5WUvlI'),
              title: Text(videoTranslations['video_title2']),
              subtitle: Text(videoTranslations['video_text2'])
            ),
            ListTile(
              //onTap: () => launch(''),
              title: Text(videoTranslations['video_title3']),
              subtitle: Text(videoTranslations['video_text3'])
            ),
            ListTile(
              //onTap: () => launch(''),
              title: Text(videoTranslations['video_title4']),
              subtitle: Text(videoTranslations['video_text4'])
            ),
            ListTile(
              //onTap: () => launch(''),
              title: Text(videoTranslations['video_title5']),
              subtitle: Text(videoTranslations['video_text5'])
            ),
            ListTile(
              //onTap: () => launch(''),
              title: Text(videoTranslations['video_title6']),
              subtitle: Text(videoTranslations['video_text6'])
            ),
            ListTile(
              //onTap: () => launch(''),
              title: Text(videoTranslations['video_title7']),
              subtitle: Text(videoTranslations['video_text7'])
            ),
            ListTile(
              //onTap: () => launch(''),
              title: Text(videoTranslations['video_title8']),
              subtitle: Text(videoTranslations['video_text8'])
            ),
            ListTile(
              //onTap: () => launch(''),
              title: Text(videoTranslations['video_title9']),
              subtitle: Text(videoTranslations['video_text9'])
            ),
            ListTile(
              //onTap: () => launch(''),
              title: Text(videoTranslations['video_title10']),
              subtitle: Text(videoTranslations['video_text10'])
            ),
            ListTile(
              //onTap: () => launch(''),
              title: Text(videoTranslations['video_title11']),
              subtitle: Text(videoTranslations['video_text11'])
            ),
            ListTile(
              //onTap: () => launch(''),
              title: Text(videoTranslations['video_title12']),
              subtitle: Text(videoTranslations['video_text12'])
            ),
            ListTile(
              onTap: () => launch('https://youtu.be/qNu198Ui-Ro'),
              title: Text(videoTranslations['video_title13']),
              subtitle: Text(videoTranslations['video_text13'])
            ),
            
          ],
        ),
      ),
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

  Future<bool> handleBackButton() async {
    // save the new current activity
    await LocalPreferences.setString(
        StateProperties.currentActivity, 'SettingScreen');

    return true;
  }
}
