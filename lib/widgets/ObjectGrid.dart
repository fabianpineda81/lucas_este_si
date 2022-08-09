// @dart=2.9
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:lucas/helpers/Helper.dart';
import 'package:lucas/helpers/StateProperties.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_consumer.dart';
import 'package:lucas/helpers/property_change_notifier/property_change_provider.dart';
import 'package:lucas/localizations/L.dart';
import 'package:lucas/models/LucasState.dart';
import 'package:lucas/models/MEmpty.dart';
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MImage.dart';
import 'package:lucas/models/MObject.dart';
import 'package:lucas/models/MRelation.dart';
import 'package:lucas/models/MSound.dart';
import 'package:lucas/models/MVideo.dart';
import 'package:lucas/screens/Folders.dart';
import 'package:lucas/widgets/WFolder.dart';
import 'package:lucas/widgets/WImage.dart';
import 'package:lucas/widgets/WSound.dart';
import 'package:lucas/widgets/WVideo.dart';
//import 'package:property_change_notifier/property_change_notifier.dart';

import 'WEmpty.dart';

class ObjectGrid extends StatefulWidget {
  final String currentLevel;
  //final bool isEditMode;
  final ValueChanged<MObject> onItemTap; // callback for tapping an item
  final ValueChanged<MObject>
      onItemDoubleTap; // callback for double tapping an item
  final ValueChanged<MObject>
      onItemLongPress; // callback when an item in the grid has been long pressed
  int parentFolderId;
  final ValueChanged<MObject>
      onRefreshParentWidget; // callback for refreshing parent widget

  ObjectGrid(this.currentLevel, this.onItemTap, this.onItemDoubleTap,
      this.onItemLongPress, this.onRefreshParentWidget,
      {Key key})
      : super(key: key);

  @override
  _ObjectGridState createState() {
    // SharedPreferences.getInstance().then((prefs) {
    //   //bool darkMode = prefs.getBool('darkMode') ?? true;
    //   String languageCode = prefs.getString('languageCode') ?? "en";
    //   return _ObjectGridState(
    //     //darkMode,
    //     languageCode,
    //   );
    // });
    return _ObjectGridState(
      this.currentLevel,
      this.onItemTap,
      this.onItemDoubleTap,
      this.onItemLongPress,
      this.onRefreshParentWidget,
    );
    //   //true,
    //   'en',
    // );
  }
}

class _ObjectGridState extends State<ObjectGrid> {
  bool isLoading = false;
  //int gridColumns = 4;
  int gridColumns = 6; //cambie las grid
  int parentFolderId;
  String currentLevel;
  final ValueChanged<MObject> onItemTap; // callback for updating folder
  final ValueChanged<MObject>
      onItemDoubleTap; // callback for double tapping an item
  final ValueChanged<MObject> onItemLongPress; // callback for updating folder
  final ValueChanged<MObject>
      onRefreshParentWidget; // callback for refreshing parent widget

  int maxPageIndex = 0;
  bool dragModeOn = true;


  _ObjectGridState(this.currentLevel, this.onItemTap, this.onItemDoubleTap,
      this.onItemLongPress, this.onRefreshParentWidget);

  @override
  void initState() {
    // L.item('Not assigned').then((str) {
    //   setState(() {
    //     _strNotAssigned = str;
    //   });
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<LucasState>(
      properties: [
        StateProperties.learningObjects,
        StateProperties.gridObjects,
        //StateProperties.gridDimensions,
      ],
      builder: (context, model, property) {
        int iCurrentLevel = int.parse(currentLevel);
        final lucasState =
            PropertyChangeProvider.of<LucasState>(context, listen: false).value;

        MFolder parentFolder =
            lucasState.getObject(StateProperties.parentFolder);
        if (parentFolder != null)
          parentFolderId = parentFolder.id;
        else
          parentFolderId = -1;

        gridColumns = lucasState.getGridColumns();

        if(iCurrentLevel == 5){
          lucasState.saveObject(StateProperties.currentFolder, parentFolder);
        }

        // columns = lucasState.getGridColumns();
        // rows = lucasState.getGridRows();
        bool isEditMode = lucasState.getObject('isEditMode');

        List<MObject> gridObjects;
        if (isEditMode) {
          gridObjects =
              lucasState.getObject(StateProperties.gridObjects) ?? <MObject>[];
        }else{
          gridObjects = lucasState.getObject(StateProperties.learningObjects) ??
              <MObject>[];
        }

        if (!isEditMode) {
          if (iCurrentLevel == 5) {
            bool hasVisibleObjects = getHasVisibleObjects(gridObjects);
            if (!hasVisibleObjects) return noConceptsUnlockedWidget(isEditMode);
          }
        }

        return gridBuilder(gridObjects, isEditMode);
      },
    );
  }

  Widget gridBuilder(List<MObject> gridObjects, bool isEditMode) {
    if (isLoading)
      return Container(
        height: 0,
        width: 0,
      );

    final rows = <Widget>[];
    int index = 0;
    int columnIndex = 1;
    Row column;
    List<Widget> cells;

    while (index < gridObjects.length) {
      MObject mObject = gridObjects[index];
      Widget widget = buildListTile(mObject, isEditMode);

      if (columnIndex == 1) {
        cells = <Widget>[];
      }

      cells.add(widget);

      if (columnIndex >= gridColumns || index == gridObjects.length - 1) {
        if (index == gridObjects.length - 1) {
          for (int missing = columnIndex; missing < gridColumns; missing++) {
            cells.add(Container(
              height: Helper.tileHeight(context),
              width: Helper.tileHeight(context),
            ));
          }
        }

        columnIndex = 0;

        column = Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: cells,
        );

        rows.add(SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: column,
        ));
      }

      index++;
      columnIndex++;
    }

    /*return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: rows,
      ),
    );*/

    return GridView(
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 6,
              childAspectRatio: 1,
              crossAxisSpacing: 0,
              mainAxisSpacing: 2),
          children: [
            for (final item in gridObjects) buildListTile(item, isEditMode),
          ],
        );
  }

  Widget buildListTile(MObject mObject, bool isEditMode) {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    bool canDrag = lucasState.getObject(StateProperties.canDrag) ?? false;

    if (!isEditMode && int.parse(currentLevel) < mObject.minLevelToShow) {
      return WEmpty(
        false,
        null,
        currentLevel,
        _refreshScreen,
        onItemDoubleTap,
        onItemLongPress,
        key: UniqueKey(),
      );
    }

    Widget widget = widgetFactory(mObject);

    if (!isEditMode || !canDrag) return widget;

    Widget lowOpacityWidget = widgetFactory(mObject);

    if (widget == null) widget = Container();
    if (lowOpacityWidget == null) lowOpacityWidget = Container();

    Opacity dragFeedbackItem = Opacity(
      opacity: 0.7,
      child: lowOpacityWidget,
    );

    DragTargetObject dragTargetObject = DragTargetObject(
      mObject,
      currentLevel,
      this.onItemTap,
      this.onItemDoubleTap,
      this.onItemLongPress,
      this.gridColumns,
      this.onRefreshParentWidget,
      key: UniqueKey(),
    );

    //return widget;
    return Draggable(
      data: mObject,
      affinity: null,
      maxSimultaneousDrags: 1,
      child: dragTargetObject,
      feedback: Container(
          height: Helper.tileHeight(context),
          width: Helper.tileHeight(context),
          child: dragFeedbackItem),
      childWhenDragging: Container(
        height: Helper.tileHeight(context),
        width: Helper.tileHeight(context),
      ),
      //onDragCompleted: onDragEnded,
    );
  }

  Widget noConceptsUnlockedWidget(bool isEditMode) {
    if (isEditMode) return Container();

    return Container(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          Card(
            color: Colors.redAccent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  child: ListTile(
                    title: L.getText("nothing unlocked"),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        L.getText("nothing unlocked instructions"),
                      ],
                    ),
                  ),
                ),
                ButtonBar(
                  children: <Widget>[
                    TextButton(
                      child: L.getUpperText("open folders"),
                      onPressed: () async {
                        final lucasState =
                            PropertyChangeProvider.of<LucasState>(context,
                                    listen: false)
                                .value;
                        lucasState.saveObject('isEditMode', true);

                        MFolder folder;
                        if (currentLevel == '5') {
                          int defaultFolderId =
                              lucasState.getObject('defaultFolderId');
                          folder = await MFolder.getByID(defaultFolderId);
                        } else {
                          folder = await MFolder.getByID(-1);
                        }

                        lucasState.saveObject('_selectedFolder', folder);

                        int gridColumns = lucasState.getGridColumns();

                        List<MObject> objects =
                            await MRelation.getObjectsInFolder(
                                gridColumns, folder.id);
                        await lucasState.saveObject(
                            StateProperties.gridObjects, objects);

                        Route route = MaterialPageRoute(
                            builder: (context) => Folders(currentLevel));
                        Navigator.push(context, route);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool getHasVisibleObjects(List<MObject> gridObjects) {
    for (int i = 0; i < gridObjects.length; i++) {
      if (gridObjects[i].isVisible == 1) return true;
    }

    return false;
  }

  // bool getAllObjectsHavePageToShow(List<MObject> gridObjects, bool isEditMode) {
  //   for (var i = 0; i < gridObjects.length; i++) {
  //     if (isEditMode) {
  //       if (gridObjects[i].pageToShow == -1) {
  //         return false;
  //       }
  //     } else {
  //       if (gridObjects[i].pageToShow == -1 && gridObjects[i].isVisible == 1) {
  //         return false;
  //       }
  //     }
  //   }

  //   return true;
  // }

  Widget widgetFactory(MObject mObject) {
    bool ignoreVisibility = false;

    Widget widget = Container();
    if (mObject is MEmpty) {
      MEmpty mEmpty = mObject;
      widget = WEmpty(
        ignoreVisibility,
        mEmpty,
        currentLevel,
        _refreshScreen,
        onItemDoubleTap,
        onItemLongPress,
        key: UniqueKey(),
      );
    }
    if (mObject is MImage) {
      MImage mImage = mObject;
      widget = WImage(
        ignoreVisibility,
        mImage,
        currentLevel,
        _refreshScreen,
        onItemDoubleTap,
        onItemLongPress,
        key: UniqueKey(),
      );
    }
    if (mObject is MFolder) {
      MFolder mFolder = mObject;
      widget = WFolder(
        mFolder,
        currentLevel,
        onItemTap,
        onItemDoubleTap,
        onItemLongPress,
        key: UniqueKey(),
      );
    }
    if (mObject is MVideo) {
      MVideo mVideo = mObject;
      widget = WVideo(
        ignoreVisibility,
        mVideo,
        currentLevel,
        _refreshScreen,
        onItemDoubleTap,
        onItemLongPress,
        key: UniqueKey(),
      );
    }
    if (mObject is MSound) {
      MSound mSound = mObject;
      widget = WSound(
        ignoreVisibility,
        mSound,
        currentLevel,
        _refreshScreen,
        onItemDoubleTap,
        onItemLongPress,
        key: UniqueKey(),
      );
    }
    return widget;
  }

  Widget getEmptyCell(bool isEditMode) {
    return isEditMode
        ? GestureDetector(
            //onTap: () => onCardTap(context, imageCard, currentLevel),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(1),
                decoration: myOuterBoxDecoration(), //
                child: Container(
                  decoration: emptyInnerBoxDecoration(), //
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: Image.asset(
                              'assets/images/ui_empty.png',
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '                                      ',
                              //_strNotAssigned,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      )),
                ),
              ),
              //),
            ),
          )
        : Container();
  }

  Map<int, bool> getValidColumns(MObject mObject, bool isEditMode) {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    int gridColumns = lucasState.getGridColumns();

    int minColumn = mObject.minColumn;
    int maxColumn = mObject.maxColumn;

    Map<int, bool> validColumns = Map<int, bool>();
    for (int i = 0; i < gridColumns; i++) {
      validColumns[i] = false;
    }

    int startingColumn = 1;
    int endingColumn = gridColumns;

    if (minColumn > 0) {
      if (maxColumn > 0) {
        startingColumn = min(minColumn, maxColumn);
        endingColumn = max(minColumn, maxColumn);
      } else {
        startingColumn = min(minColumn, gridColumns + maxColumn + 1);
        endingColumn = max(minColumn, gridColumns + maxColumn + 1);
      }
    } else {
      if (maxColumn > 0) {
        startingColumn = min(gridColumns + minColumn, maxColumn);
        endingColumn = max(gridColumns + minColumn, maxColumn);
      } else {
        startingColumn =
            min(gridColumns + minColumn + 1, gridColumns + maxColumn + 1);
        endingColumn =
            max(gridColumns + minColumn + 1, gridColumns + maxColumn + 1);
      }
    }

    if (startingColumn < 1 || startingColumn > gridColumns) startingColumn = 1;
    if (endingColumn < 1 || endingColumn > gridColumns) endingColumn = 1;

    for (int i = startingColumn; i <= endingColumn; i++) {
      if (mObject.isVisible == 1 || isEditMode) {
        validColumns[i - 1] = true;
      }
    }

    return validColumns;
  }

  bool canShowObjectInColumn(MObject mObject, int column, bool isEditMode) {
    return mObject.canShow[column];
  }

  _refreshScreen(MObject mObject) {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: true).value;
    lucasState.saveObject(StateProperties.refreshVoiceBox, 1);
    //lucasState.notifyAll();

    if (onItemTap != null) {
      onItemTap(mObject);
    }
  }

  BoxDecoration myInnerBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 2,
        color: Colors.white,
      ),
    );
  }

  BoxDecoration emptyInnerBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 0,
        color: Colors.transparent,
      ),
    );
  }

  BoxDecoration myOuterBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 1,
        color: Colors.grey,
      ),
    );
  }
}

class DragTargetObject extends StatefulWidget {
  final mObject;
  final currentLevel;
  final ValueChanged<MObject> onItemTap; // callback for updating folder
  final ValueChanged<MObject>
      onItemDoubleTap; // callback for double tapping an item
  final ValueChanged<MObject> onItemLongPress; // callback for updating folder
  final gridColumns;
  //int parentFolderId;
  final ValueChanged<MObject>
      onRefreshParentWidget; // callback for refreshing parent widget

  DragTargetObject(
      this.mObject,
      this.currentLevel,
      this.onItemTap,
      this.onItemDoubleTap,
      this.onItemLongPress,
      this.gridColumns,
      this.onRefreshParentWidget,
      {Key key})
      : super(key: key);

  @override
  _DragTargetObjectState createState() {
    return _DragTargetObjectState(
      this.mObject,
      this.currentLevel,
      this.onItemTap,
      this.onItemDoubleTap,
      this.onItemLongPress,
      this.gridColumns,
      this.onRefreshParentWidget,
    );
  }
}

class _DragTargetObjectState extends State<DragTargetObject> {
  final mObject;
  final currentLevel;
  final ValueChanged<MObject> onItemTap; // callback for updating folder
  final ValueChanged<MObject>
      onItemDoubleTap; // callback for double tapping an item
  final ValueChanged<MObject> onItemLongPress; // callback for updating folder
  final gridColumns;
  int parentFolderId;
  final ValueChanged<MObject>
      onRefreshParentWidget; // callback for refreshing parent widget

  _DragTargetObjectState(
    this.mObject,
    this.currentLevel,
    this.onItemTap,
    this.onItemDoubleTap,
    this.onItemLongPress,
    this.gridColumns,
    this.onRefreshParentWidget,
  );

  @override
  Widget build(BuildContext context) {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;

    MFolder parentFolder = lucasState.getObject(StateProperties.parentFolder);
    parentFolderId = parentFolder.id;

    return DragTarget(
      builder: (BuildContext context, List<dynamic> accepted,
          List<dynamic> rejected) {
        return widgetFactory(mObject);
      },
      onAccept: (MObject mDraggedObject) {
        if (mDraggedObject != null) {
          reorder(mDraggedObject, mObject);
        }
      },
    );
  }

  Widget widgetFactory(MObject mObject) {
    bool ignoreVisibility = false;

    Widget widget = Container();
    if (mObject is MEmpty) {
      MEmpty mEmpty = mObject;
      widget = WEmpty(
        ignoreVisibility,
        mEmpty,
        currentLevel,
        _refreshScreen,
        onItemDoubleTap,
        onItemLongPress,
        key: UniqueKey(),
      );
    }

    if (mObject is MImage) {
      MImage mImage = mObject;
      widget = WImage(
        ignoreVisibility,
        mImage,
        currentLevel,
        _refreshScreen,
        onItemDoubleTap,
        onItemLongPress,
        key: UniqueKey(),
      );
    }

    if (mObject is MFolder) {
      MFolder mFolder = mObject;
      widget = WFolder(
        mFolder,
        currentLevel,
        onItemTap,
        onItemDoubleTap,
        onItemLongPress,
        key: UniqueKey(),
      );
    }

    if (mObject is MVideo) {
      MVideo mVideo = mObject;
      widget = WVideo(
        ignoreVisibility,
        mVideo,
        currentLevel,
        _refreshScreen,
        onItemDoubleTap,
        onItemLongPress,
        key: UniqueKey(),
      );
    }

    if (mObject is MSound) {
      MSound mSound = mObject;
      widget = WSound(
        ignoreVisibility,
        mSound,
        currentLevel,
        _refreshScreen,
        onItemDoubleTap,
        onItemLongPress,
        key: UniqueKey(),
      );
    }
    return widget;
  }

  _refreshScreen(MObject mObject) {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: true).value;
    lucasState.saveObject(StateProperties.refreshVoiceBox, 1);

    if (onItemTap != null) {
      onItemTap(mObject);
    }
  }

  void reorder(MObject mDraggedObject, mDraggedToObject) async {
    final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: true).value;

    int gridColumns = lucasState.getGridColumns();

    MFolder currentFolder = lucasState.getObject(StateProperties.currentFolder);

    List<MObject> objectsInFolder = await MRelation.moveItem(
        mDraggedObject, mDraggedToObject, gridColumns, currentFolder.id);

    await lucasState.saveObject(StateProperties.gridObjects, objectsInFolder);

    List<MObject> learningObjects = await MRelation.getLearningObjectsInFolder(
        int.parse(currentLevel), currentFolder.id, gridColumns);
    await lucasState.saveObject(
        StateProperties.learningObjects, learningObjects);

    if (onRefreshParentWidget != null) {
      onRefreshParentWidget(null);
    }
  }
}
