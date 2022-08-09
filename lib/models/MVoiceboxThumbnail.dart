import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MVideo.dart';
import 'package:transparent_image/transparent_image.dart';


class MVoiceboxThumbnail extends StatefulWidget {
  final MObject mObject;

  MVoiceboxThumbnail(this.mObject, {Key key}) : super(key: key);

  @override
  _MVoiceboxThumbnailState createState() {
    return _MVoiceboxThumbnailState(this.mObject);
  }
}

class _MVoiceboxThumbnailState extends State<MVoiceboxThumbnail> {
  final MObject mObject;

  _MVoiceboxThumbnailState(this.mObject);

  @override
  Widget build(BuildContext context) {
    Widget objectWidget;
    if (mObject.fileName.isEmpty) {
      return Container(
        width: 0.0,
        height: 0.0,
      );
    }

    // if (mObject is MEmpty) {
    //   objectWidget = Container(
    //     height: Helper.tileHeight(context),
    //     width: Helper.tileHeight(context),
    //     padding: EdgeInsets.fromLTRB(3.0, 3.0, 0.0, 3.0),
    //   );
    // }

    if (mObject is MImage) {
      MImage mImage = mObject;
      if (mImage.useAsset == 1) {
        objectWidget = Image.asset(
                  mObject.fileName,
                  width: Helper.voiceBoxHeight - 10,
                  height: Helper.voiceBoxHeight - 10,
                ) !=
                null
            ? Image.asset(
                mObject.fileName,
                width: Helper.voiceBoxHeight - 10,
                height: Helper.voiceBoxHeight - 10,
              )
            : Image.asset(Helper.imageNotFound);
      } else {
        File f = File('${Helper.appDirectory}/${mImage.localFileName}');
        Image img = Image.file(f);

        objectWidget = Container(
          padding: EdgeInsets.fromLTRB(3.0, 3.0, 0.0, 3.0),
          child: FadeInImage(
            fadeInDuration: Duration(milliseconds: Helper.fadeInDuration),
            placeholder: MemoryImage(kTransparentImage),
            image: img.image,
          ),
        );
      }
    }

    if (mObject is MVideo) {
      MVideo mVideo = mObject;

      if (mVideo.useAsset == 1) {
        objectWidget = Image.asset(
                  mObject.fileName,
                  width: Helper.voiceBoxHeight - 10,
                  height: Helper.voiceBoxHeight - 10,
                ) !=
                null
            ? Image.asset(
                mObject.fileName,
                width: Helper.voiceBoxHeight - 10,
                height: Helper.voiceBoxHeight - 10,
              )
            : Image.asset(Helper.imageNotFound);
      } else {
        File f = File('${Helper.appDirectory}/${mVideo.localFileName}');
        Image img = Image.file(f);

        objectWidget = Container(
          child: FadeInImage(
            fadeInDuration: Duration(milliseconds: Helper.fadeInDuration),
            placeholder: MemoryImage(kTransparentImage),
            image: img.image,
          ),
          padding: EdgeInsets.fromLTRB(3.0, 3.0, 0.0, 3.0),
        );
      }
    }

    if (mObject is MSound) {
      MSound mSound = mObject;
      if (mSound.useAsset == 1) {
        objectWidget = Image.asset(
                  mObject.fileName,
                  width: Helper.voiceBoxHeight - 10,
                  height: Helper.voiceBoxHeight - 10,
                ) !=
                null
            ? Image.asset(
                mObject.fileName,
                width: Helper.voiceBoxHeight * .95,
                height: Helper.voiceBoxHeight - 10,
              )
            : Image.asset(Helper.imageNotFound);
      } else {
        File f = File('${Helper.appDirectory}/${mSound.localFileName}');
        Image img = Image.file(f);

        objectWidget = Container(
          child: FadeInImage(
            fadeInDuration: Duration(milliseconds: Helper.fadeInDuration),
            placeholder: MemoryImage(kTransparentImage),
            image: img.image,
          ),
          padding: EdgeInsets.fromLTRB(3.0, 3.0, 0.0, 3.0),
        );
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: mObject.highlighted ? Colors.yellow.shade600 : Colors.white,
      ),
      child: objectWidget,
    );
  }
}
