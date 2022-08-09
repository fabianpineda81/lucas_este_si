import 'package:flutter/material.dart';
import 'package:lucas/helpers/Tuple.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ----------------------------------------------------------
/// Helper for saving and retrieving the user's setting in the device
/// ----------------------------------------------------------
class LocalPreferences {
  /// ----------------------------------------------------------
  /// Gets the string value of item from the SharedPreferences repository
  /// ----------------------------------------------------------
  static Future<String> getString(String item, String defaultValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(item) ?? defaultValue;
  }

  /// ----------------------------------------------------------
  /// Sets the string value of item in the SharedPreferences repository
  /// ----------------------------------------------------------
  static Future<void> setString(String item, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(item, value);
  }

  /// ----------------------------------------------------------
  /// Gets the double value of item from the SharedPreferences repository
  /// ----------------------------------------------------------
  static Future<double> getDouble(String item, double defaultValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(item) ?? defaultValue;
  }

  /// ----------------------------------------------------------
  /// Sets the double value of item in the SharedPreferences repository
  /// ----------------------------------------------------------
  static Future<void> setDouble(String item, double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(item, value);
  }

  /// ----------------------------------------------------------
  /// Gets the int value of item from the SharedPreferences repository
  /// ----------------------------------------------------------
  static Future<int> getInt(String item, int defaultValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(item) ?? defaultValue;
  }

  /// ----------------------------------------------------------
  /// Gets the bool value of item from the SharedPreferences repository
  /// ----------------------------------------------------------
  static Future<bool> getBool(String item, bool defaultValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(item) ?? defaultValue;
  }

  /// ----------------------------------------------------------
  /// Sets the int value of item in the SharedPreferences repository
  /// ----------------------------------------------------------
  static Future<void> setInt(String item, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(item, value);
  }

  /// ----------------------------------------------------------
  /// Sets the bool value of item in the SharedPreferences repository
  /// ----------------------------------------------------------
  static Future<void> setBool(String item, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(item, value);
  }

  static Future<Map> getInfo(List<Tuple> items) async {
    Map<String, dynamic> result = new Map();
    for (Tuple item in items) {
      String classOf = item.classOf;
      if (classOf == 'String') {
        String resultItem =
            await LocalPreferences.getString(item.strA, item.strB);
        result[item.strA] = resultItem;
      }
      if (classOf == 'double') {
        double resultItem = await LocalPreferences.getDouble(
            item.strA, double.parse(item.strB));
        result[item.strA] = resultItem.toString();
      }
    }

    return result;
  }

  // Design settings
  static Future<Color> mainColor() async {
    String currentColor =
        await LocalPreferences.getString("currentColor", 'blue');

    if (currentColor == 'amber') return Colors.amber;
    if (currentColor == 'blue') return Colors.blue;
    if (currentColor == 'cyan') return Colors.cyan;
    if (currentColor == 'deepOrange') return Colors.deepOrange;
    if (currentColor == 'deepPurple') return Colors.deepPurple;
    if (currentColor == 'green') return Colors.green;
    if (currentColor == 'indigo') return Colors.indigo;
    if (currentColor == 'lightBlue') return Colors.lightBlue;
    if (currentColor == 'lightGreen') return Colors.lightGreen;
    if (currentColor == 'lime') return Colors.lime;
    if (currentColor == 'orange') return Colors.orange;
    if (currentColor == 'pink') return Colors.pink;
    if (currentColor == 'purple') return Colors.purple;
    if (currentColor == 'red') return Colors.red;
    if (currentColor == 'teal') return Colors.teal;
    if (currentColor == 'yellow') return Colors.yellow;

    return Colors.blue;
  }

  // static const Color AppBarBackgroundColor = Colors.blue;
  // static const Color ButtonBackgroundColor = Colors.blue;
  static const Color ButtonTextColor = Colors.white;

  static const FontWeight TextFontWeight = FontWeight.w400;
  static const double TextFontSize = 15.0;
  static const FontWeight TitleTextFontWeight = FontWeight.w400;
  static const double TitleTextFontSize = 20.0;
  static const FontWeight SubTitleTextFontWeight = FontWeight.w500;
  static const double SubTitleTextFontSize = 17.0;

  static const NormalTextStyle = TextStyle(
    fontWeight: TextFontWeight,
    fontSize: TextFontSize,
  );

  static const ListTileSubtitleTextStyle = TextStyle(
      fontWeight: TextFontWeight,
      fontSize: TextFontSize,
      color: Colors.black45);

  static const TitleTextStyle = TextStyle(
    fontWeight: TitleTextFontWeight,
    fontSize: TitleTextFontSize,
  );

  static const SubTitleTextStyle = TextStyle(
    fontWeight: SubTitleTextFontWeight,
    fontSize: SubTitleTextFontSize,
  );

  static const double FormFieldHorizontalPadding = 16.0;
  static const double FormFieldTopVerticalPadding = 4.0;
  static const double FormFieldBottomVerticalPadding = 3.0;

  static const FontWeight FormLabelFontWeight = FontWeight.w300;
  static const double FormLabelFontSize = 15.0;

  static const LabelOfFormFieldTextStyle = TextStyle(
    fontWeight: FormLabelFontWeight,
    fontSize: FormLabelFontSize,
    fontStyle: FontStyle.italic,
  );

  static BoxDecoration myInnerBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 2,
        color: Colors.white,
      ),
    );
  }

  static BoxDecoration myOuterBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.grey,
      ),
    );
  }

  static const double ThumbnailHeigth = 80.0;
}

// languageCountry
// userName
// currentLevel
// languageCode
