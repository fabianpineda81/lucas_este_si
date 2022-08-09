import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/MCategory.dart';
import 'package:lucas/screens/BottomNavigationOptions.dart';

class Categories extends StatefulWidget {
  Categories({Key key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: L.getText("categories"),
        actions: <Widget>[
          Helper.debugMode
              ? TextButton(
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await MCategory.loadFromAssets();
                    setState(() {
                      isLoading = false;
                    });
                  },
                )
              : Container(),
          Helper.debugMode
              ? TextButton(
                  child: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await showCategoriesInfo();
                  },
                )
              : Container(),
        ],
      ),
      body: isLoading
          ? Container(
              height: Helper.LinearProgressIndicatorHeight,
              child: LinearProgressIndicator(
                value: null,
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
                backgroundColor: Colors.white,
              ),
            )
          : getFutureCategoryListView(context),
      bottomNavigationBar: BottomNavigationOptions(),
    );
  }

  Widget getFutureCategoryListView(BuildContext context) {
    return FutureBuilder(
      future: getCategories(),
      builder: (BuildContext context, AsyncSnapshot<List<MCategory>> snapshot) {
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
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    MCategory category = snapshot.data[index];
                    return buildCategory(category);
                  });
            }
        }
        return Text("");
      },
    );
  }

  Future<List<MCategory>> getCategories() async {
    List<MCategory> categories = await MCategory.getAll();
    return categories;
  }

  Widget buildCategory(MCategory category) {
    return ListTile(
      leading: Icon(
        Icons.category,
      ),
      //selected: selectedLanguageCode == languageCode,
      title: Text(category.textToShow),
      subtitle: Helper.debugMode
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('id: ${category.id}'),
                Text('cols: [${category.minColumn}, ${category.maxColumn}]'),
                Text('minLevelToShow: ${category.minLevelToShow}'),
              ],
            )
          : Container(),
      onTap: () {
        // LocalPreferences.setString("languageCode", languageCode);
        // lucasState.reloadWords();
        // lucasState.reloadFolderNames();

        // Navigator.of(context).pop();

        // if (selectedLanguageCode != languageCode) {
        //   LocalPreferences.setString("languageCountry", '');
        //   L.selectFirstAvailableVoice();
        // }
      },
    );
  }

  showCategoriesInfo() async {
    List<MCategory> categories = await MCategory.getAll();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text('Folders information'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Total categories: ${categories.length}'),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: L.getUpperText('accept'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
