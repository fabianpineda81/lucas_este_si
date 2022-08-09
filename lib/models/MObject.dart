import 'package:lucas/models/MCategory.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MRelation.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MVideo.dart';

import 'MEmpty.dart';

class MObject {
  int id = -1;
  int isVisible = 0; // if visible can be shown in learning grid
  int isUnderstood;
  int isAvailable;
  String textToShow = '';
  String textToSay = '';
  String fileName = '';
  int relationId = -1; // if created from a MRelation, this is the relation ID
  int visibleIndex = -1; // position of this object in the grid
  String backgroundColor; // background color all concepts should have
  int minColumn; // minimum grid column index where the concepts should be shown. Positive numbers start left to right, negative numbers start right to left
  int maxColumn; // maximum grid column index where the concepts should be shown. Positive numbers start left to right, negative numbers start right to left
  int categoryId = -1;
  MCategory category; // the object's category
  int minLevelToShow = 1; // min level for which the category will be shown
  int userCreated =
      1; // Indicates if this object was created by the user or if it was bundled by default in the app. If created by the user, allow the user to delete it.

  bool isShown = false; // true if object is shown on grid
  Map<int, bool> canShow = Map<int,
      bool>(); // (col,canshow) true if object can be shown on specified column on the grid
  int pageToShow =
      -1; // specifies in what page of the grid the item must be shown
  int columnToShow =
      -1; // indicates on what column will this item be shown in the grid
  bool highlighted = false; // if true will highligh in voicebox
  int useAsset =
      1; // Indicates if asset must be used (otherwise localfile will be used)
  String localFileName = ''; // Local filename if assets is not used
  String user =
      ''; // Indicates to what user the folder,image, video or sound belongs to
  int remoteId = -1; // the id of this objects in the remote user database

  Object tag;

  static toggleVisibility(MObject mObject) async {
    if (mObject.isVisible == 1)
      mObject.isVisible = 0;
    else
      mObject.isVisible = 1;

    if (mObject is MImage)
      await MImage.updateIsVisible(mObject.id, mObject.isVisible);

    if (mObject is MFolder)
      await MFolder.updateIsVisible(mObject.id, mObject.isVisible);

    if (mObject is MVideo)
      await MVideo.updateIsVisible(mObject.id, mObject.isVisible);

    if (mObject is MSound)
      await MSound.updateIsVisible(mObject.id, mObject.isVisible);

    // create the objects's new visible index (update only if no index had been assigned)
    if (mObject.isVisible == 1) {
      await MRelation.updateVisibleIndex(mObject);
    }
  }

  // static String getStrBase64(int useAsset, String localFileName) {
  //   // if (useAsset == 0) {
  //   //   File f = File('${Helper.appDirectory}/$localFileName');
  //   //   FileImage fileImage = FileImage(f);
  //   //   return Base64Encoder().convert(fileImage.file.readAsBytesSync());
  //   // }
  //   return '';
  // }
  static Future<List<MObject>> getAll(String textToSearch) async {
    List<MObject> result = <MObject>[];

    List<MImage> images = await MImage.getAll(textToSearch: textToSearch);
    List<MVideo> videos = await MVideo.getAll(textToSearch: textToSearch);
    List<MSound> sounds = await MSound.getAll(textToSearch: textToSearch);
    List<MEmpty> empties = await MEmpty.getAll(textToSearch: textToSearch);
    //List<MFolder> folders = await MFolder.getAll(textToSearch: textToSearch);

    for (int i = 0; i < images.length; i++) {
      MObject mObject = images[i];
      if (mObject != null) {
        result.add(mObject);
      }
    }

    for (int i = 0; i < videos.length; i++) {
      MObject mObject = videos[i];
      if (mObject != null) {
        result.add(mObject);
      }
    }

    for (int i = 0; i < sounds.length; i++) {
      MObject mObject = sounds[i];
      if (mObject != null) {
        result.add(mObject);
      }
    }

    for (int i = 0; i < empties.length; i++) {
      MObject mObject = empties[i];
      if (mObject != null) {
        result.add(mObject);
      }
    }

    // for (int i = 0; i < folders.length; i++) {
    //   MFolder mObject = folders[i];
    //   if (mObject != null) {
    //     result.add(mObject);
    //   }
    // }

    return result;
  }
}
