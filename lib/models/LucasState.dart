import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_notifier.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MVideo.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';

class LucasState extends PropertyChangeNotifier<String> {
  //static bool canNotify = true;
  static Map<String, dynamic> buffer = new Map();

  // @override
  // void dispose() {
  //   //_bloc.dispose();
  //   super.dispose();
  // }

  saveObject(String key, dynamic value) {
    bool mustNotify = false;

    if (buffer[key] != value ||
        key == StateProperties.refreshVoiceBox ||
        key == StateProperties.refreshLearnScreen ||
        key == StateProperties.currentActivity) mustNotify = true;

    buffer[key] = value;

    if (mustNotify) {
      notifyListeners(key);
    }
  }

  saveObjectWithoutNotifyingListeners(String key, dynamic value) {
    buffer[key] = value;
  }

  dynamic getObject(String key) {
    return buffer[key];
  }

  String rebuildDatabaseStatus = '';
  String getRebuildDatabaseStatus() {
    return rebuildDatabaseStatus;
  }

  setRebuildDatabaseStatus(String status) {
    rebuildDatabaseStatus = status;
    notifyListeners();
  }

  // static bool mustDeleteListOnImageAdd = false;
  // setMustDeleteListOnImageAdd(bool value) {
  //   mustDeleteListOnImageAdd = value;
  // }

  // static int currentFolderId = -1;

  // setCurrentFolderId(int value) {
  //   currentFolderId = value;
  //   notifyListeners();
  // }

  // int getCurrentFolderId() {
  //   return currentFolderId;
  // }

  static int gridColumns = -1;
  static int gridRows = -1;
  int getGridColumns() {
    return (gridColumns == -1 ? 6 : gridColumns);
  }

  int getGridRows() {
    return (gridRows == -1 ? 6 : gridRows);
  }

  setGridColumns(int value) {
    gridColumns = value;
    notifyListeners(StateProperties.gridDimensions);
  }

  setGridRows(int value) {
    gridRows = value;
    notifyListeners(StateProperties.gridDimensions);
  }

  // static bool _firstTime = true;
  // bool getFirstTime() {return _firstTime;}
  // setFirstTime(bool value) {
  //   _firstTime = value;
  //   //notifyListeners();
  // }

  static int firstReinforcer = -1;
  static int secondReinforcer = -1;
  static int thirdReinforcer = -1;
  static MImage firstReinforcerImage;
  static MImage secondReinforcerImage;
  static MImage thirdReinforcerImage;
  setReinforcer(number, imageId) async {
    if (number == 1) {
      firstReinforcer = imageId;
      firstReinforcerImage = await MImage.getByID(imageId);
    }
    if (number == 2) {
      secondReinforcer = imageId;
      secondReinforcerImage = await MImage.getByID(imageId);
    }
    if (number == 3) {
      thirdReinforcer = imageId;
      thirdReinforcerImage = await MImage.getByID(imageId);
    }
    notifyListeners();
  }

  int getReinforcer(number) {
    if (number == 1) {
      return firstReinforcer;
    }
    if (number == 2) {
      return secondReinforcer;
    }
    if (number == 3) {
      return thirdReinforcer;
    }
    return -1;
  }

  MImage getReinforcerImage(number) {
    if (number == 1) {
      return firstReinforcerImage;
    }
    if (number == 2) {
      return secondReinforcerImage;
    }
    if (number == 3) {
      return thirdReinforcerImage;
    }
    return null;
  }

  //static List<MObject> imageCards = List<MObject>();
  // List<MObject> getImageCards() {
  //   return imageCards;
  // }

  notifyAll() {
    notifyListeners();
  }

  // ***********************************************************
  // voice box state implementation
  // ***********************************************************

  static List<MObject> imageCards = <MObject>[];

  List<MObject> getImageCards() {
    return imageCards;
  }

  setImageCards(List<MObject> value) {
    imageCards = value;
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
        //notifyListeners(StateProperties.voiceBoxConcepts);
        return;
      }
    }

    // The imagelist will be automatically deleted after adding a new image once the list has played
    imageCards.add(imageCard);

    notifyListeners(StateProperties.voiceBoxItems);
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
        //notifyListeners(StateProperties.voiceBoxConcepts);
        return;
      }
    }

    // The imagelist will be automatically deleted after adding a new image once the list has played
    imageCards.add(videoCard);

    notifyListeners(StateProperties.voiceBoxItems);
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
        //notifyListeners(StateProperties.voiceBoxConcepts);
        return;
      }
    }

    // The imagelist will be automatically deleted after adding a new image once the list has played
    imageCards.add(soundCard);
    //foo=5;
    notifyListeners(StateProperties.voiceBoxItems);
  }

  // int _foo;
  // int get foo => _foo;
  // set foo(int value) {
  //   _foo = value;
  //   notifyListeners(StateProperties.voiceBoxItems);
  // }
}
