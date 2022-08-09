import '../helpers/Helper.dart';
import '../models/MEmpty.dart';
import '../models/MFolder.dart';
import '../models/MImage.dart';
import '../models/MObject.dart';
import '../models/MRelation.dart';
import '../models/MSound.dart';
import '../models/MVideo.dart';
import '../models/Translation.dart';
import '../module_backup_reestore/helper_file.dart';

class HelperBR {
  static Future<String> deleteAnObject(MObject mObjectToDelete) async {
    String typeOfConcept = '';
    if (mObjectToDelete is MFolder) {
      typeOfConcept = 'folder';
      MFolder mFolder = mObjectToDelete;

      // Delete all objects (including subfolders)
      List<MObject> objectsToDelete =
          await MRelation.getObjectsInFolderBD(mObjectToDelete.id);

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

      await Translation.deleteForObject("Images", mObjectToDelete.id);
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

  static List<Translation> jsonToTranslation(List<dynamic> lista) {
    List<Translation> translations = [];
    for (var json in lista) {
      Translation t = Translation.fromMap(json);
      translations.add(t);
    }

    return translations;
  }

  static List<MRelation> jsonToRelations(List<dynamic> lista) {
    List<MRelation> MRelations = [];
    for (var json in lista) {
      MRelation t = MRelation.jsonToRelation(json);
      MRelations.add(t);
    }

    return MRelations;
  }

  static List<MImage> jsonToImages(List<dynamic> lista) {
    List<MImage> MImages = [];
    for (var json in lista) {
      MImage t = MImage.jsonToImage(json);
      MImages.add(t);
    }

    return MImages;
  }

  static List<MFolder> jsonToFolder(List<dynamic> lista) {
    List<MFolder> MFolders = [];
    for (var json in lista) {
      MFolder t = MFolder.jsonToFolder(json);
      MFolders.add(t);
    }

    return MFolders;
  }
  static Future<void> DeleteChildrens(MObject mObject) async {
    String typeOfConcept = await Helper.deleteAnObject(mObject);


    MRelation relation = await MRelation.getByID(mObject.relationId);

    List<MRelation> relations = await MRelation.getAllRelationsOfItemId(typeOfConcept, mObject.id);
    for (int i = 0; i < relations.length; i++) {
      await MRelation.delete(relations[i]);
    }
    /*
    final lucasState = PropertyChangeProvider.of<LucasState>(
        context,
        listen: false)
        .value;

    // update environment
    if (relations.length == 1) {
      relation = relations.first;
    }
   MFolder parentFolder =
    await MFolder.getByID(relation.parentFolderId);
    await refreshFolder(parentFolder);
    await lucasState.saveObject(
        StateProperties.currentFolder, parentFolder);
    await lucasState.saveObject(
        StateProperties.selectedFolder, parentFolder);

    await lucasState.saveObject(
        StateProperties.selectedImage, null);
    await lucasState.saveObject(
        StateProperties.selectedVideo, null);
    await lucasState.saveObject(
        StateProperties.selectedSound, null);
    await lucasState.saveObject(
        StateProperties.selectedEmpty, null);

    if (onRefreshParentWidget != null) {
      onRefreshParentWidget(null);
    }*/


  }


}
