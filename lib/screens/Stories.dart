import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:logger/logger.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/LocalPreferences.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MStory.dart';
import 'package:lucas/models/MVideo.dart';
import 'package:lucas/models/StoryObject.dart';
import 'package:lucas/screens/BottomNavigationOptions.dart';
import 'package:lucas/screens/ImageSettings.dart';
import 'package:lucas/screens/TextToSpeech.dart';
import 'package:transparent_image/transparent_image.dart';

class Stories extends StatefulWidget {
  @override
  _StoriesState createState() => _StoriesState();
}

@override
bool get wantKeepAlive => true;

class _StoriesState extends State<Stories> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //List<Widget> _story = new List<Widget>();

  List<MStory> stories = <MStory>[];
  List<MStoryObject> storyObjects = <MStoryObject>[];
  String newStoryName = '';
  String strStoryNameHint = '';
  String strCreateNewStory = '';
  String strNoStoriesInstructions = '';
  String strAddStory = '';
  String strClose = '';
  String strStories = 'Stories';
  int selectedStoryId = -1;
  String strAddStoryObject = '';
  bool isLoading = false;
  bool isEditMode = false;
  String strEditStoryName = '';
  String editedStoryName = '';
  String strStoryObjectsInstructions = '';

  //GlobalKey _globalKey = new GlobalKey();
  String pressed = "";

  _StoriesState();

  @override
  void initState() {
    super.initState();

    initialize().then((result) {
      setState(() { });
    });
  }

  Future<void> initialize() async {
    await getStories();

    strStoryNameHint = await L.item('story name hint');
    strCreateNewStory = await L.item('create new story');
    strNoStoriesInstructions = await L.item("no stories instructions");
    strAddStory = await L.item("add story");
    strClose = await L.item('close');
    strAddStoryObject = await L.item('add story object');
    strEditStoryName = await L.item('edit story name');
    //strStoryObjectsInstructions = await L.item('story object instructions');

    await getStoryObjects();
  }

  Future<void> getStories() async {
    List<MStory> objects = await MStory.getAll(false);

    setState(() {
      stories = objects;
    });

    if (objects.isNotEmpty) {
      if (selectedStoryId == -1) {
        setState(() {
          selectedStoryId = objects.first.id;
        });
      }
    }
  }

  Future<void> getStoryObjects() async {
    List<MStoryObject> objects =
        await MStoryObject.getAllObjectsInStory(selectedStoryId);
    setState(() {
      storyObjects = objects;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<Widget> listItems =
    //     storyObjects.toList().map((mObject) => buildListTile(mObject)).toList();

    Widget storyBoardWidget = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        getIsloadingWidget(),
        noStoriesWidget(),
        getStoriesCard(),
        instructionsCard(),
        getStoryObjectsListView(),
        // Expanded(
        //   child: ReorderableListView(
        //     children: [
        //       for (final item in storyObjects)
        //         ListTile(
        //           title: getObjectImage(item),
        //           key: ValueKey(item),
        //         )
        //     ],
        //     onReorder: (int oldIndex, int newIndex) {
        //       reorderStoryObjects(oldIndex, newIndex);
        //     },
        //   ),
        // ),
      ],
    );

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        //backgroundColor: Colors.white,
        //backgroundColor: Color(0xFFE1E1E1),
        appBar: AppBar(
          title: Text('Stories'),
          backgroundColor: Theme.of(context).primaryColor,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            !isEditMode
                ? Container()
                : IconButton(
                    icon: new Icon(
                      Icons.add_circle,
                    ),
                    onPressed: () async {
                      await addStory();
                    },
                  ),
            (selectedStoryId == -1 || !isEditMode)
                ? Container()
                : IconButton(
                    icon: new Icon(
                      Icons.delete,
                    ),
                    onPressed: () async {
                      deleteStory();
                    },
                  ),
            IconButton(
              icon: new Icon(
                Icons.edit,
              ),
              onPressed: () async {
                await getStoryObjects();
                setState(() {
                  isEditMode = !isEditMode;
                });
              },
            ),
          ],
        ),
        //SingleChildScrollView
        body: storyBoardWidget,
        //drawer: LDrawer(),
        bottomNavigationBar: BottomNavigationOptions(),
      ),
    );
  }

  Widget getStoryObjectsListView() {
    if (storyObjects == null || storyObjects.isEmpty) return Container();

    return Expanded(
        child: isEditMode
            ? ReorderableListView(
                children: [
                  for (final item in storyObjects)
                    ListTile(
                      title: Dismissible(
                        key: new ObjectKey(item),
                        child: buildListTile(item),
                        onDismissed: (direction) async {
                          await MStoryObject.delete(item);
                          setState(() {
                            storyObjects.remove(item);
                          });
                        },
                        background: new Container(
                          color: Colors.red,
                          child: new ListTile(
                            leading:
                                new Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                      ),
                      key: ValueKey(item),
                    )
                ],
                onReorder: (int oldIndex, int newIndex) {
                  reorderStoryObjects(oldIndex, newIndex);
                },
              )
            : ListView.builder(
                itemCount: storyObjects.length,
                itemBuilder: (context, index) {
                  return buildListTile(storyObjects[index]);
                }));
  }

  Future<void> deleteStory() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: L.getText('delete story'),
          content: L.getText('confirm delete story'),
          actions: <Widget>[
            new TextButton(
              child: L.getUpperText('accept'),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                MStory mStory = await MStory.getByID(selectedStoryId);
                await MStory.delete(mStory);
                await MStoryObject.deleteByStoryId(selectedStoryId);

                selectedStoryId = -1;
                await getStories();
                await getStoryObjects();

                setState(() {
                  isLoading = false;
                });

                Navigator.of(context).pop();
              },
            ),
            new TextButton(
              child: L.getUpperText('close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  reorderStoryObjects(oldIndex, newIndex) async {
    if (!isEditMode) return;

    // reorder moved item
    MStoryObject mStoryObject = storyObjects[oldIndex];
    await MStoryObject.delete(mStoryObject);
    int id = await MStoryObject.maxId();
    mStoryObject.id = id;
    await MStoryObject.createWithID(mStoryObject);
    //storyObjects.remove(mStoryObject);

    // reorder the rest oif the items
    for (int i = newIndex; i < storyObjects.length; i++) {
      if (i != oldIndex) {
        MStoryObject mStoryObject = storyObjects[i];
        await MStoryObject.delete(mStoryObject);
        id = await MStoryObject.maxId();
        mStoryObject.id = id;
        await MStoryObject.createWithID(mStoryObject);
      }
    }

    await getStoryObjects();
  }

  getIsloadingWidget() {
    return isLoading
        ? Container(
            height: Helper.LinearProgressIndicatorHeight,
            child: LinearProgressIndicator(
              value: null,
              valueColor: new AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor),
              backgroundColor: Colors.white,
              //backgroundColor: Color(0xFF000000),
            ),
          )
        : Container();
  }

  getStoryObject(int index) async {
    return storyObjects[index];
  }

  Widget buildListTile(MStoryObject mStoryObject) {
    return isEditMode
        ? ListTile(
            title: Column(
              children: <Widget>[
                Dismissible(
                  onDismissed: (direction) async {
                    await MStoryObject.delete(mStoryObject);
                    setState(() {
                      storyObjects.remove(mStoryObject);
                    });
                  },
                  background: new Container(
                    color: Colors.red,
                  ),
                  child: getObjectImage(mStoryObject),
                  key: UniqueKey(),
                ),
              ],
            ),
            key: UniqueKey(),
          )
        : ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              key: UniqueKey(),
              children: <Widget>[
                Dismissible(
                  onDismissed: (direction) async {
                    setState(() {
                      storyObjects.remove(mStoryObject);
                    });
                  },
                  background: new Container(
                    color: Colors.grey,
                    //color: Color(0xFF000000),
                  ),
                  key: UniqueKey(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[getObjectImage(mStoryObject)],
                  ),
                ),
              ],
            ),
          );
  }

  Widget getObjectImage(MStoryObject mStoryObject) {
    var image;
    Image localImage;
    String textToShow = '';
    File f;
    if (mStoryObject.mObject is MImage) {
      MImage mImage = mStoryObject.mObject;
      if (mImage.useAsset == 0) {
        f = File('${Helper.appDirectory}/${mImage.localFileName}');
        localImage = Image.file(
          f,
          fit: BoxFit.scaleDown,
        );
      }
      image = mImage.useAsset == 1
          ? Image.asset(mImage.fileName) != null
              ? Image.asset(
                  mImage.fileName,
                  fit: BoxFit.scaleDown,
                )
              : Image.asset(Helper.imageNotFound)
          : localImage == null
              ? Container()
              : FadeInImage(
                  fadeInDuration: Duration(milliseconds: Helper.fadeInDuration),
                  placeholder: MemoryImage(kTransparentImage),
                  //placeholder: kTransparentImage,
                  image: localImage.image,
                );
      textToShow = mImage.textToShow;
    }

    return GestureDetector(
      onTap: () async {
        if(pressed == '') {
          for (MStoryObject story in storyObjects) {
            MObject mObject = story.mObject;
            if (story.mObject is MImage) {
              MImage mImage = mObject;
              press(mImage.textToShow);
              await playObject(story);
            } else {
              await playObject(story);
            }
            await Future.delayed(const Duration(milliseconds: 1600));
          }
        }
        press('');
      },
      onDoubleTap: () {  },
      child: Container(
        padding: EdgeInsets.only(bottom: 5.0, right: 5.0, left: 5.0),
        height: 150.0,
        width: 150,
        color: pressed.contains(textToShow) ? Colors.green[200] : Colors.transparent,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: image,
              ),
            ),
            Text(
              textToShow,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  Future<void> playObject(MStoryObject mStoryObject) async {
    bool objectIsImage = (mStoryObject.mObject is MImage);
    bool objectIsVideo = (mStoryObject.mObject is MVideo);
    bool objectIsSound = (mStoryObject.mObject is MSound);

    MObject mObject = mStoryObject.mObject;
    if (objectIsImage) {
      MImage mImage = mObject;
      await saySomething(mImage.textToSay);
    }

    if (objectIsSound) {
      MSound mSound = mObject;
      if (mSound.localSoundFileName.isEmpty) {
        saySomething(mSound.textToSay);
      } else {
        FlutterSoundPlayer flutterSoundPlayer = await initializeAudioPlayer();
        await flutterSoundPlayer.startPlayer(
            fromURI: mSound.localSoundFileName);
      }
    }

    /// TODO play video
    if (objectIsVideo) {
      MVideo mVideo = mObject;
      await saySomething(mVideo.textToSay);
    }
  }

  Future<FlutterSoundPlayer> initializeAudioPlayer() async {
    FlutterSoundPlayer flutterSoundPlayer = new FlutterSoundPlayer();
    // flutterSound.setSubscriptionDuration(0.01);
    // flutterSound.setDbPeakLevelUpdate(0.8);
    // flutterSound.setDbLevelEnabled(true);

    return flutterSoundPlayer;
  }

  Future<void> saySomething(String somethingToSay) async {
    FlutterTts flutterTts = new FlutterTts();
    String languageCountry =
        await LocalPreferences.getString("languageCountry", "");

    bool isLanguageAvailable =
        await flutterTts.isLanguageAvailable(languageCountry);
    String settingsText = await L.item("settings title");

    if (isLanguageAvailable) {
      await flutterTts.setLanguage(languageCountry);

      double ttsSpeed = await LocalPreferences.getDouble("ttsSpeed", 0.5);
      await flutterTts.setSpeechRate(ttsSpeed);

      await flutterTts.speak(somethingToSay);
    } else {
      if (mounted) {
        final snackBar = SnackBar(
          content: L.getLocalizedText('no voice selected'),
          action: SnackBarAction(
            label: settingsText,
            onPressed: () {
              // open TextToSpeech settings
              Route route =
                  MaterialPageRoute(builder: (context) => TextToSpeech());
              Navigator.push(context, route);
            },
          ),
        );

        if (_scaffoldKey.currentState != null) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //(snackBar);
        }
      }
    }
  }

  Future<bool> _onBackPressed() async {
    return true;
  }

  Widget getStoriesCard() {
    if (stories.isEmpty) return Container();

    List<DropdownMenuItem> items = stories.map((MStory story) {
      return DropdownMenuItem(
        child: Text(
          story.storyName,
          //style: TextStyle(color: Colors.white),
          //overflow: TextOverflow.ellipsis,
        ),
        value: story.id,
      );
    }).toList();

    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(6.0),
      child: Column(
        children: <Widget>[
          DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              //style: TextStyle(color: Colors.black),
              isExpanded: true,
              value: selectedStoryId,
              //isDense: true,
              onChanged: (newValue) async {
                setState(() {
                  selectedStoryId = newValue;
                });
                await getStoryObjects();
              },
              items: items,
            ),
          ),
          Row(
            children: <Widget>[
              !isEditMode
                  ? Container()
                  : MaterialButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Icon(Icons.edit_attributes,
                              color: Theme.of(context).primaryColor),
                          Text(
                            strEditStoryName.toUpperCase(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        MStory mStory = await MStory.getByID(selectedStoryId);
                        setState(() {
                          editedStoryName = mStory.storyName;
                        });

                        showEditStoryDialog();
                      },
                    ),
              !isEditMode
                  ? Container()
                  : Container(
                      width: 5.0,
                    ),
              !isEditMode
                  ? Container()
                  : MaterialButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Icon(Icons.add_box,
                              color: Theme.of(context).primaryColor),
                          Text(
                            strAddStoryObject.toUpperCase(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        Route route = MaterialPageRoute(
                            builder: (context) => ImageSettings(
                                false, false, false, false,
                                isSelectingObject: true));
                        var mObject = await Navigator.push(context, route);
                        await addObjectToStory(mObject);
                      },
                    ),
            ],
          )
        ],
      ),
    );
  }

  Widget instructionsCard() {
    if (isEditMode) return Container();
    if (strStoryObjectsInstructions.isEmpty) return Container();

    return Card(
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Text(strStoryObjectsInstructions),
      ),
    );
  }

  Widget noStoriesWidget() {
    if (stories.isNotEmpty) return Container();

    return Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
              child: ListTile(
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(strNoStoriesInstructions),
                  ],
                ),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                  child: Text(strAddStory.toUpperCase()),
                  onPressed: () async {
                    setState(() {
                      isEditMode = true;
                    });
                    await addStory();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  addStory() async {
    setState(() {
      isLoading = true;
      newStoryName = '';
    });

    await showAddStoryDialog();

    setState(() {
      isLoading = false;
    });
  }

  showEditStoryDialog() async {
    MStory mStory = await MStory.getByID(selectedStoryId);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(strCreateNewStory),
          content: Container(
            child: TextFormField(
              initialValue: mStory.storyName,
              onChanged: (text) {
                setState(() {
                  editedStoryName = text;
                });
              },
              decoration: InputDecoration(
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.all(5.0),
                hintText: strStoryNameHint,
              ),
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: Text(strEditStoryName.toUpperCase()),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                MStory mStory = await MStory.getByID(selectedStoryId);
                mStory.storyName = editedStoryName;
                await MStory.update(mStory);

                await getStories();

                setState(() {
                  editedStoryName = '';
                });
                await getStoryObjects();

                setState(() {
                  isLoading = false;
                });

                Navigator.of(context).pop();
              },
            ),
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: Text(strClose.toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  showAddStoryDialog() async {
    Color getBackgroundColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        // the color to return when button is in pressed, hovered, focused state
        return Colors.red;
      }
      // the color to return when button is in it's normal/unfocused state
      return Colors.white;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(strCreateNewStory),
          content: Container(
            child: TextField(
              //initialValue: '',
              onChanged: (text) {
                setState(() {
                  newStoryName = text;
                });
              },
              decoration: InputDecoration(
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.all(5.0),
                hintText: strStoryNameHint,
              ),
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith(getBackgroundColor),
                // todo
                // shape: const RoundedRectangleBorder(
                //   borderRadius: BorderRadius.all(
                //     Radius.circular(20.0),
                //   ),
                // ),
              ),
              child: Text(strAddStory.toUpperCase()),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                int newId = await MStory.maxId();
                MStory mStory = MStory(id: newId, storyName: newStoryName);
                await MStory.createWithID(mStory);

                await getStories();

                setState(() {
                  selectedStoryId = newId;
                });
                await getStoryObjects();

                setState(() {
                  isLoading = false;
                });

                Navigator.of(context).pop();
              },
            ),
            // usually buttons at the bottom of the dialog
            TextButton(
              child: Text(strClose.toUpperCase()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addObjectToStory(MObject mObject) async {
    if (mObject == null) return;

    setState(() {
      isLoading = true;
    });

    MStoryObject mStoryObject = MStoryObject();
    mStoryObject.id = await MStoryObject.maxId();
    if (mObject is MImage) mStoryObject.objectType = 'image';
    if (mObject is MVideo) mStoryObject.objectType = 'video';
    if (mObject is MSound) mStoryObject.objectType = 'sound';
    mStoryObject.objectId = mObject.id;
    mStoryObject.storyId = selectedStoryId;

    await MStoryObject.createWithID(mStoryObject);
    await getStoryObjects();

    setState(() {
      isLoading = false;
    });
  }

  press(String text) {

    setState(() {
      pressed = text;
    });
  }
}
