// @dart=2.9
import 'package:flutter/material.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MEmpty.dart';
import 'package:lucas/models/MObject.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';

class WEmpty extends StatefulWidget {
  bool ignoreVisibility;
  MEmpty mEmpty;
  String currentLevel = "1";
  //bool isEditMode = false;
  ValueChanged<MObject> onItemTap; // callback for tapping a folder
  ValueChanged<MObject> onItemDoubleTap; // callback for double tapping a folder
  ValueChanged<MObject> onItemLongPress; // callback for updating folder

  WEmpty(ignoreVisibility, mEmpty, currentLevel, onItemTap, onItemDoubleTap,
      onItemLongPress,
      {Key key})
      : super(key: key) {
    this.ignoreVisibility = ignoreVisibility;
    this.mEmpty = mEmpty;
    this.currentLevel = currentLevel;
    //this.isEditMode = isEditMode;
    this.onItemTap = onItemTap;
    this.onItemDoubleTap = onItemDoubleTap;
    this.onItemLongPress = onItemLongPress;
  }

  @override
  _WEmptyState createState() {
    // SharedPreferences.getInstance().then((prefs) {
    //   //bool darkMode = prefs.getBool('darkMode') ?? true;
    //   String languageCode = prefs.getString('languageCode') ?? "en";
    //   return _WEmptyState(
    //     //darkMode,
    //     languageCode,
    //   );
    // });
    return _WEmptyState(
      this.ignoreVisibility,
      this.mEmpty,
      this.currentLevel,
      //this.isEditMode,
      this.onItemTap,
      this.onItemDoubleTap,
      this.onItemLongPress,
    );
  }
}

class _WEmptyState extends State<WEmpty> {
  //bool dummyVar = false;
  bool ignoreVisibility;
  //bool mEmptyLoaded = false;
  MEmpty mEmpty;
  //WEmpty wImage = WEmpty.emptyConstructor();
  String currentLevel = "1";
  //bool isEditMode;
  Image localImage;

  ValueChanged<MObject> onItemTap; // callback for tapping a folder
  ValueChanged<MObject> onItemDoubleTap; // callback for double tapping a folder
  ValueChanged<MObject> onItemLongPress; // callback for updating folder

  _WEmptyState(
    this.ignoreVisibility,
    this.mEmpty,
    this.currentLevel,
    //this.isEditMode,
    this.onItemTap,
    this.onItemDoubleTap,
    this.onItemLongPress,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // return PropertyChangeConsumer<LucasState>(
    //   properties: [
    //     StateProperties.isEditMode,
    //   ],
    //   builder: (context, model, property) {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    bool isEditMode = lucasState.getObject(StateProperties.isEditMode);

    return GestureDetector(
      onTap: () => onTap(mEmpty, currentLevel),
      onDoubleTap: () => onTap(mEmpty, currentLevel),
      onLongPress: () => onLongPress(mEmpty, currentLevel),
      child: Container(
        height: Helper.tileHeight(context)-2,
        width: Helper.tileHeight(context)-2,
        //constraints: BoxConstraints.expand(),
        margin: const EdgeInsets.all(1.0),
        decoration: myOuterBoxDecoration(isEditMode), //
        // child: Container(
        //   decoration: myInnerBoxDecoration(isEditMode), //
        //   child: Container(
        //     //height: Helper.voiceBoxHeight,
        //     decoration: BoxDecoration(
        //       color: getImageBackgroundColor(isEditMode),
        //     ),
        //     child: cardImage,
        //   ),
        // ),
      ),
    );
    //   },
    // );
  }

  onTap(
      //BuildContext context,
      MEmpty mEmpty,
      String currentLevel) async {
    if (onItemTap != null) {
      onItemTap(mEmpty);
    }
  }

  onDoubleTap(MEmpty mEmpty, String currentLevel) async {
    if (onItemLongPress != null) {
      onItemDoubleTap(mEmpty);
    }
  }

  onLongPress(MEmpty mEmpty, String currentLevel) async {
    //if (isEditMode) {
    if (onItemLongPress != null) {
      onItemLongPress(mEmpty);
    }
    //}
  }

  BoxDecoration myInnerBoxDecoration(bool isEditMode) {
    return BoxDecoration(
      border: Border.all(
        width: 2,
        color: Colors.transparent,
        // (mSound.isVisible == 0 && !isEditMode && ignoreVisibility)
        //     ? Colors.transparent
        //     : mSound.isUnderstood == 1 ? Colors.greenAccent : Colors.white,
      ),
    );
  }

  BoxDecoration myOuterBoxDecoration(bool isEditMode) {
    return BoxDecoration(
      border: Border.all(
        width: isEditMode ? 1 : 0,
        //1,
        color: isEditMode ? Colors.black : Colors.transparent,
        //Colors.grey,
      ),
    );
  }
}
