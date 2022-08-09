import 'package:flutter/foundation.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MVideo.dart';

class VoiceboxState with ChangeNotifier {
  static List<MObject> imageCards = <MObject>[];

  List<MObject> getImageCards() {
    return imageCards;
  }

  static bool mustDeleteListOnImageAdd = false;
  setMustDeleteListOnImageAdd(bool value) {
    mustDeleteListOnImageAdd = value;
  }

  addImageCard(MImage imageCard) {
    if (mustDeleteListOnImageAdd) {
      imageCards.clear();
      mustDeleteListOnImageAdd = false;
    }

    // must not allow adding the same image twice
    if (imageCards.isNotEmpty) {
      if (imageCards[imageCards.length - 1].id == imageCard.id &&
          imageCards[imageCards.length - 1] is MImage) {
        notifyListeners();
        return;
      }
    }

    // The imagelist will be automatically deleted after adding a new image once the list has played
    imageCards.add(imageCard);

    notifyListeners();
  }

  addVideoCard(MVideo videoCard) {
    if (mustDeleteListOnImageAdd) {
      imageCards.clear();
      mustDeleteListOnImageAdd = false;
    }

    // must not allow adding the same video twice
    if (imageCards.isNotEmpty) {
      if (imageCards[imageCards.length - 1].id == videoCard.id &&
          imageCards[imageCards.length - 1] is MVideo) {
        notifyListeners();
        return;
      }
    }

    // The imagelist will be automatically deleted after adding a new image once the list has played
    imageCards.add(videoCard);

    notifyListeners();
  }

  addSoundCard(MSound soundCard) {
    if (mustDeleteListOnImageAdd) {
      imageCards.clear();
      mustDeleteListOnImageAdd = false;
    }

    // must not allow adding the same sound twice
    if (imageCards.isNotEmpty) {
      if (imageCards[imageCards.length - 1].id == soundCard.id &&
          imageCards[imageCards.length - 1] is MSound) {
        notifyListeners();
        return;
      }
    }

    // The imagelist will be automatically deleted after adding a new image once the list has played
    imageCards.add(soundCard);

    notifyListeners();
  }
}
