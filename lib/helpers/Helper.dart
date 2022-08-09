import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MEmpty.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MRelation.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MVideo.dart';
import 'package:lucas/models/Translation.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:http/http.dart' as http;

class Helper {
  static String serverToken =
      'AAAAv8WTRxw:APA91bE4BNbBQwws2_eHGBLD4YnkoXeMBIQTrhxZ_p1nH3FSw_UxS3ayBpRN-rR2O-bcwcyfsJr2v2j1bs7j3tiY7r2_ZawglEUX-MQQzBzbEhU-dMObC9rNSt5vBatbPmgxkHqyMooo';

  static double voiceBoxHeight = 140; //70.0;
  static double smallVoiceBoxSizeForQuiz = 70;
  static int settingsRestrictions = 0;
  static int showHideStoriesAndSchedule = 1;

  static int port = 64646; // IP port for syncing

  static int imageFlexSize = 6;
  static double level10TextSize = 24.0;
  static const String lucasFolder = 'lucas';
  static bool debugMode = false;
  static bool allowLongPressInLearningScreen = true;
  static bool outputVoiceboxToAnotherDevice = false;
  static int deviceToOutputVoicebox = 0;
  static String appDirectory = '';
  static bool folderShouldTalk = false;
  static const int defaultVisibility = 0;

  static const String SeparatorString = "!~]";
  static const String imageNotFound = 'assets/images/ui_not_found.png';
  static const double LinearProgressIndicatorHeight = 3.0;
  static const double minGridColumns = 4.0;
  static const double minGridRows = 4.0;
  static const double maxGridColumns = 15.0;
  static const double maxGridRows = 15.0;

  //static Map<int, Image> imageMap = Map<int, Image>();

  static const int fadeInDuration = 150;

  // Base64 helper funtions
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static double getFontSize(String currentLevel) {
    int iCurrentLevel = int.parse(currentLevel);
    if (iCurrentLevel == 10)
      return Helper.level10TextSize;
    else
      return 9.0;
  }

  static Future<ui.Image> base64ToUiImage(String value) async {
    Uint8List lst =
        new Uint8List.view(Helper.dataFromBase64String(value).buffer);
    var codec = await ui.instantiateImageCodec(lst.buffer.asUint8List());
    // add additional checking for number of frames etc here
    var frame = await codec.getNextFrame();
    return frame.image;
  }

  static Future<ByteData> base64ToUiByteData(String value) async {
    Uint8List lst =
        new Uint8List.view(Helper.dataFromBase64String(value).buffer);
    var codec = await ui.instantiateImageCodec(lst.buffer.asUint8List());
    // add additional checking for number of frames etc here
    var frame = await codec.getNextFrame();
    return frame.image.toByteData(format: ui.ImageByteFormat.png);
  }

  static String encondeToJson(List<String> list) {
    String result = '[';
    for (int i = 0; i < list.length; i++) {
      if (i == list.length - 1) {
        result += '"${list[i]}"';
      } else {
        result += '"${list[i]}",';
      }
    }
    result += ']';
    return result;
  }

  static Future<Image> buildImageFromAsset(String path) async {
    return rootBundle.load(path).then((value) {
      return Image.memory(value.buffer.asUint8List());
    }).catchError((_) {
      return Image.asset(Helper.imageNotFound);
    });
  }

  static Future<Image> buildImageFromAssetWithSize(
      String path, double height, double width) async {
    return rootBundle.load(path).then((value) {
      return Image.memory(
        value.buffer.asUint8List(),
        height: height,
        width: width,
      );
    }).catchError((_) {
      return Image.asset(
        Helper.imageNotFound,
        height: height,
        width: width,
      );
    });
  }

  static Color colorFromHex(String hexString) {
    if (hexString.isEmpty) return Colors.white;

    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  //Assets
  static Future<String> loadStringAsset(String assetName) async {
    rootBundle.evict(assetName);
    String result = await rootBundle.loadString(assetName);

    return result;
  }

  static tileHeight(BuildContext context) {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    int gridColumns = lucasState.getGridColumns();

    double width = MediaQuery.of(context).size.width;
    return width / gridColumns;
  }

/*   static Future<void> startPlayer(FlutterSound flutterSound, MObject mObject) async {
    try {
      if (flutterSound.isRecording) return;
      if (flutterSound.isPlaying) return;

      String soundFileName = '';
      if (mObject is MSound) {
        MSound mSound = mObject;
        soundFileName = mSound.localSoundFileName;
      }

      if (soundFileName == '') return;
      
      await flutterSound.startPlayer(soundFileName);
      await flutterSound.setVolume(1.0);

      
    } catch (err) {
      stopPlayer(flutterSound);
    }
  }

  static Future<void> stopPlayer(FlutterSound flutterSound) async {
    try {
      if (!flutterSound.isPlaying) return;

      await flutterSound.stopPlayer();
      
    } catch (err) {
      print('error: $err');
    }
  } */

  static Future<WebResponse> invokeWebService(String jsonString) async {
    try {
      // set up POST request arguments
      String url = 'https://lucas.openBusiness.co/ws.php';
      Map<String, String> headers = {"Content-type": "application/json"};

      // make POST request
      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: jsonString);

      // check the status code for the result
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        if (response.body.length == 0) {
          return WebResponse(
              operation: false, message: 'response.body.length==0');
        }
        //return WebResponse(operation: 'NO OK', message: (response.body.length>1000 ? response.body.substring(0,1000) : response.body));
        return WebResponse.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to execute operation. Error $statusCode');
      }

      // Map<String, String> jsonMap = {
      //   'operation': operation,
      //   'json': json,
      // };

      // final http.Response response = await http.post(
      //   'https://lucas.openBusiness.co/ws.php',
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      //   body: jsonEncode(<String, String>{
      //     'operation': 'upload MImage list',
      //   }),
      //   //body: jsonEncode(<String, String>{'operation': operation,'json': json,}),
      //   //body: {'operation': operation,'json': json,},
      // );
      // if (response.statusCode == 200) {
      //   // If the server did return a 201 CREATED response,
      //   // then parse the JSON.
      //   return WebResponse.fromJson(jsonDecode(response.body));
      // } else {
      //   // If the server did not return a 201 CREATED response,
      //   // then throw an exception.
      //   throw Exception('Failed to execute operation');
      // }
    } catch (err) {
      WebResponse webResponse =
          WebResponse(operation: false, message: err.toString());
      return webResponse;
    }
  }

  static Future<void> deleteLocalFile(String localFileName) async {
    File file = File('${Helper.appDirectory}/$localFileName');
    if (file != null) {
      file.delete();
    }
  }

  static Future<String> deleteAnObject(MObject mObjectToDelete) async {
    String typeOfConcept = '';
    if (mObjectToDelete is MFolder) {
      typeOfConcept = 'folder';
      MFolder mFolder = mObjectToDelete;

      // Delete all objects (including subfolders)
      List<MObject> objectsToDelete =
          await MRelation.getObjectsInFolder(6, mFolder.id);

      for (var mObject in objectsToDelete) {
        String typeOfConcept = await deleteAnObject(mObject);

        List<MRelation> relations =
            await MRelation.getAllRelationsOfItemId(typeOfConcept, mObject.id);
        for (int i = 0; i < relations.length; i++) {
          await MRelation.delete(relations[i]);
        }
      }

      await MFolder.delete(mFolder);

      await Translation.deleteForObject("folders", mObjectToDelete.id);
    }

    if (mObjectToDelete is MEmpty) {
      typeOfConcept = 'empty';
      MEmpty mEmpty = mObjectToDelete;
      await MEmpty.delete(mEmpty);
    }

    if (mObjectToDelete is MImage) {
      typeOfConcept = 'image';
      MImage mImage = mObjectToDelete;
      await MImage.delete(mImage);

      if (mImage.useAsset == 0) {
        await Helper.deleteLocalFile(mImage.localFileName);
      }

      // List<MRelation> relations = await MRelation.getAllRelationsOfItemId(
      //     typeOfConcept, mObjectToDelete.id);
      // for (int i = 0; i < relations.length; i++) {
      //   await MRelation.delete(relations[i]);
      // }

      await Translation.deleteForObject("images", mObjectToDelete.id);
    }

    if (mObjectToDelete is MVideo) {
      typeOfConcept = 'video';
      MVideo mVideo = mObjectToDelete;
      await MVideo.delete(mVideo);

      if (mVideo.useAsset == 0) {
        await Helper.deleteLocalFile(mVideo.localFileName);
      }

      await Translation.deleteForObject("videos", mObjectToDelete.id);
    }

    if (mObjectToDelete is MSound) {
      typeOfConcept = 'sound';
      MSound mSound = mObjectToDelete;
      await MSound.delete(mSound);

      if (mSound.useAsset == 0) {
        await Helper.deleteLocalFile(mSound.localFileName);
      }

      await Translation.deleteForObject("sounds", mObjectToDelete.id);
    }

    return typeOfConcept;
  }

  static Future<WebResponseDynamic> getWebResponseDynamic(
      String jsonString) async {
    try {
      // set up POST request arguments
      String url = 'https://lucas.openBusiness.co/ws.php';
      Map<String, String> headers = {"Content-type": "application/json"};

      // make POST request
      http.Response response =
          await http.post(Uri.parse(url), headers: headers, body: jsonString);

      // check the status code for the result
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        if (response.body.length == 0) {
          return WebResponseDynamic(
              operation: false, content: 'response.body.length==0');
        }
        //return WebResponse(operation: 'NO OK', message: (response.body.length>1000 ? response.body.substring(0,1000) : response.body));
        return WebResponseDynamic(
          operation: jsonDecode(response.body)["operation"],
          content: jsonDecode(response.body)["message"],
        );
        //return jsonDecode(response.body);
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        throw Exception('Failed to execute operation. Error $statusCode');
      }
    } catch (err) {
      WebResponseDynamic webResponse =
          WebResponseDynamic(operation: false, content: err.toString());
      return webResponse;
    }
  }
}

class WebResponse {
  final bool operation;
  final String message;

  WebResponse({this.operation, this.message});

  factory WebResponse.fromJson(Map<String, dynamic> json) {
    return WebResponse(
      operation: json['operation'],
      message: json['message'],
    );
  }
}

class WebResponseDynamic {
  final bool operation;
  final dynamic content;

  WebResponseDynamic({this.operation, this.content});

  factory WebResponseDynamic.fromJson(Map<String, dynamic> json) {
    return WebResponseDynamic(
      operation: json['operation'],
      content: json['message'],
    );
  }
}
