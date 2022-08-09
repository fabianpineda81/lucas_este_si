import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:lucas/models/MFolder.dart';
import 'package:lucas/models/MObject.dart';
import 'package:path/path.dart';

import '../helpers/Helper.dart';
import '../helpers/LocalPreferences.dart';
import '../models/MImage.dart';
import '../models/MRelation.dart';

import '../models/Translation.dart';
import 'helper.dart';
import 'helper_firebase.dart';
import 'helper_toas.dart';

class HelperWebService {
  static String baseUrl =
      'https://container-service-1.0n1v1jgsd67bu.us-east-1.cs.amazonlightsail.com';
  String userEmail;
  String userName;

  HelperWebService(this.userEmail, this.userName);

  Future<void> backUpFolders(
      HelperFirebase firebase, Function actualizarEstado) async {
    List<MFolder> folders = await MFolder.getAll();

    // se monta la imagen a firebase y se actualiza el link
    for (int i = 0; i < folders.length; i++) {
      if (folders[i].useAsset == 0) {
        actualizarEstado("uploading the image of ${folders[i].textToShow}");
        String link = await firebase.uploadFile(folders[i]);
        folders[i].fileName = link;
      }
      //HelperToast.showToast("se monto la imagen de ${folders[i].textToShow}");

    }

    String json = jsonEncode({
      "email": userEmail,
      "name": userName,
      "operation": "upload folders",
      "objects": folders,
    });
    String res = await invokeWebService(json, "backup/v1/uploadMfolderList");
    HelperToast.showToast(res);
  }

  Future<void> backUpImages(
      HelperFirebase firebase, Function actualizarEstado) async {
    List<MImage> images = await MImage.getAll();

    // se monta la imagen a firebase y se actualiza el link
    for (int i = 0; i < images.length; i++) {
      if (images[i].useAsset == 0) {
        actualizarEstado("uploading the image of ${images[i].textToShow}");
        String link = await firebase.uploadFile(images[i]);
        images[i].fileName = link;
      }
      //HelperToast.showToast("se monto la imagen de ${images[i].textToShow}");
    }

    String json = jsonEncode({
      "email": userEmail,
      "name": userName,
      "operation": "upload folders",
      "objects": images,
    });

    String res = await invokeWebService(json, "backup/v1/uploadMimageList");
    HelperToast.showToast(res);
  }

  Future<void> backUpRelation(Function actualizarEstado) async {
    bool isDelete;
    List<MRelation> relations = await MRelation.getAll();
    List<MRelation> relationsTemporal = [];
    actualizarEstado("Send relations");
    int count = 0;
    for (int i = 0; i < relations.length; i += 1000) {
      if (i == 0) {
        isDelete = true;
      } else {
        isDelete = false;
        actualizarEstado("relations sent $i of ${relations.length}");
      }
      if ((relations.length - i) > 1000) {
        relationsTemporal = relations.getRange(i, i + 1000).toList();
      } else {
        relationsTemporal =
            relations.getRange(i, relations.length - 1).toList();
      }
      await sendRelations(relationsTemporal, isDelete);
    }

    // se monta la imagen a firebase y se actualiza el link
  }

  Future<void> sendRelations(List<MRelation> relations, bool isDelete) async {
    String json = jsonEncode({
      "isDelete": isDelete,
      "email": userEmail,
      "name": userName,
      "operation": "upload relations",
      "objects": relations,
    });
    String res = await invokeWebService(json, "backup/v1/uploadMRelationList");
    HelperToast.showToast(res);
  }

  Future<void> backUpTraslations(Function actualizarEstado) async {
    bool isDelete;
    List<Translation> traslations = await Translation.getAll();
    List<Translation> traslationsTemporal = await Translation.getAll();
    actualizarEstado("Send traslations");
    int count = 0;
    for (int i = 0; i < traslations.length; i += 1000) {
      if (i == 0) {
        isDelete = true;
      } else {
        isDelete = false;
        actualizarEstado("translations sent $i of ${traslations.length}");
      }
      if ((traslations.length - i) > 1000) {
        traslationsTemporal = traslations.getRange(i, i + 1000).toList();
      } else {
        traslationsTemporal =
            traslations.getRange(i, traslations.length - 1).toList();
      }
      await sendTraslations(traslationsTemporal, isDelete);
    }

    // se monta la imagen a firebase y se actualiza el link
  }

  Future<void> sendTraslations(
      List<Translation> traslations, bool isDelete) async {
    String json = jsonEncode({
      "isDelete": isDelete,
      "email": userEmail,
      "name": userName,
      "operation": "upload translation",
      "objects": traslations,
    });
    String res =
        await invokeWebService(json, "backup/v1/uploadMTranslationList");

    HelperToast.showToast(res);
  }

  Future<dynamic> invokeWebService(String jsonString, String operacion) async {
    try {
      // set up POST request arguments

      Map<String, String> headers = {"Content-type": "application/json"};
      String finalUrl = "$baseUrl/$operacion";
      // make POST request
      http.Response response = await http.post(Uri.parse(finalUrl),
          headers: headers, body: jsonString);

      // check the status code for the result
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        Map<String, dynamic> res = jsonDecode(response.body);
        return res["message"];
      }
      if (statusCode > 400 && statusCode < 500) {
        Map<String, dynamic> res = jsonDecode(response.body);
        return res["message"];
      }
      if (statusCode == 500) {
        Map<String, dynamic> res = jsonDecode(response.body);
        return res["message"];
      }

      throw Exception('Failed to execute operation. Error $statusCode');
    } catch (err) {
      return err.toString();
    }
  }

  Future<dynamic> listRemoteFolders() async {
    String languageCode =
        await LocalPreferences.getString('languageCode', 'en');
    String operacion =
        "operations/v1/listFoldersOfAUser?email=$userEmail&language=$languageCode";
    return invokeWebServiceGet(operacion);
  }

  Future<List<dynamic>> invokeWebServiceGet(String operacion) async {
    // esto siempre tiene que devolcer una lista de objetos o un error

    // set up POST request arguments

    Map<String, String> headers = {"Content-type": "application/json"};
    String linkFinal = "$baseUrl/$operacion";
    // make POST request
    http.Response response =
        await http.get(Uri.parse(linkFinal), headers: headers);

    // check the status code for the result
    int statusCode = response.statusCode;

    if (statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);

      return res["message"];
    }
    if (statusCode > 400 && statusCode < 500) {
      Map<String, dynamic> res = jsonDecode(response.body);

      throw Exception("${res['message']} $statusCode");
    }

    throw Exception('Failed to execute operation. Error $statusCode');
  }

  Future<Map<String, dynamic>> invokeWebServiceGetFolders(
      String operacion) async {
    // esto siempre tiene que devolcer una lista de objetos o un error

    // set up POST request arguments

    Map<String, String> headers = {"Content-type": "application/json"};
    String linkFinal = "$baseUrl/$operacion";
    // make POST request
    http.Response response =
        await http.get(Uri.parse(linkFinal), headers: headers);

    // check the status code for the result
    int statusCode = response.statusCode;

    if (statusCode == 200) {
      Map<String, dynamic> res = jsonDecode(response.body);

      return res;
    }
    if (statusCode > 400 && statusCode < 500) {
      Map<String, dynamic> res = jsonDecode(response.body);

      return res;
    }

    throw Exception('Failed to execute operation. Error $statusCode');
  }

  Future<void> replaceFolder(
      String userEmailNameToRestore,
      int selectedFolderToRestore,
      int selectedLocalFolder,
      Function actualizarEstado) async {
  if(selectedLocalFolder==-1){
    HelperToast.showToast("can't choose home folder as destination");
    return;
  }

    MFolder localFolder = await MFolder.getByID(selectedLocalFolder);
    MFolder remoteFolder = await MFolder.getByID(selectedFolderToRestore);


    if (remoteFolder != null) {
      if (remoteFolder.id != localFolder.id) {

          HelperToast.showToast(
              "the folder ${remoteFolder.id} is already in the mobile");
          return;

      }
    }

    String typeOfConcept = await Helper.deleteAnObject(localFolder);
    List<MRelation> relations =
        await MRelation.getAllRelationsOfItemId('folder', localFolder.id);
    MRelation relation;
    for (int i = 0; i < relations.length; i++) {
      if (relations[i].gridColumns == 6) {
        relation = relations[i];
        break;
      }
    }

    for (int i = 0; i < relations.length; i++) {
      await MRelation.delete(relations[i]);
    }

    if (localFolder == null) {
      if (selectedLocalFolder == -1) {
        localFolder = MFolder();
      } else {
        HelperToast.showToast("error could not find local folder");
        return;
      }
    }

    actualizarEstado("restoring translations");

    List<Translation> remoteTranslations =
        await findARemoteTraslations(localFolder, selectedFolderToRestore);
    actualizarEstado("restoring Relations");
    List<MRelation> remoteRelations =
        await findRemoteRelations(selectedFolderToRestore);

    for (MRelation r in remoteRelations) {
      r.gridColumns = 6;
      MRelation.createWithID(r);
    }
    for (Translation t in remoteTranslations) {
      await Translation.createWithID(t);
    }

    List<MObject> objectsToDelete =
        await MRelation.getObjectsInFolder(6, selectedLocalFolder);

    actualizarEstado("restoring Images");
    await findRemoteImages(
        selectedFolderToRestore: selectedFolderToRestore,
        remoteTranslations: remoteTranslations,
        localFolder: localFolder,
        remoteRelations: remoteRelations);

    actualizarEstado("restoring Folders");
    await findRemoteFolders(
        selectedFolderToRestore: selectedFolderToRestore,
        remoteTranslations: remoteTranslations,
        localFolder: localFolder,
        remoteRelations: remoteRelations,
        relation: relation);

    actualizarEstado("restoring complete");

    // add videos

    // add sounds

    // add folders

    //dynamic remoteFolders = webResponseDynamic.content[4];

    /*final lucasState =
        PropertyChangeProvider.of<LucasState>(context, listen: false).value;
    int gridColumns = lucasState.getGridColumns();
    List<MObject> objects =
    await MRelation.getObjectsInFolder(gridColumns, localFolder.id);
    await lucasState.saveObject(StateProperties.gridObjects, objects);

    if (mounted) {
      setState(() {
        isRestoring = false;
        status = "";
        status = translations['operation completed successfully'];
      });
    }

    showSnackbar("operation completed successfully",
        Duration(milliseconds: 900));*/
    HelperToast.showToast("task completed");
  }

// esto

  Future<void> addRemoteImage(
      MImage image,
      List<Translation> remoteObjectTranslations,
      List<MRelation> remoteRelations,
      MFolder parentFolder) async {
    MImage mImage = MImage(
      id: image.id,
      fileName: image.fileName,
      isVisible: image.isVisible,
      isUnderstood: image.isUnderstood,
      useAsset: image.useAsset,
      localFileName: image.localFileName,
      userCreated: image.userCreated,
      isAvailable: image.isAvailable,
      backgroundColor: image.backgroundColor,
      minLevelToShow: image.minLevelToShow,
    );

    if (mImage.useAsset == 0) {
      HelperFirebase helperFirebase =
          HelperFirebase(userEmail, userName, HelperFirebase.carpetaImagenes);
      File file = await helperFirebase.DowloadFile(mImage, mImage.fileName);
      if (file != null) {
        mImage.fileName = file.path;
        String nombreArchivo = "${file.path.split('/').last}";
        mImage.localFileName = nombreArchivo;
        mImage.userCreated = 1;
        mImage.useAsset = 0;
      }
    }
    try {
      await MImage.createWithID(mImage);
    } catch (e) {
      print(e);
    }

    // add translation

    // Add relation
  }

  Future<void> addRemoteFolder(MFolder nFolder) async {
    /*  MFolder nFolder = MFolder(
      id: folder.id,
      fileName:folder.fileName ,
      isVisible: folder.isVisible,
      isUnderstood: folder.isUnderstood!,
      useAsset: folder.useAsset,
      localFileName:folder.localFileName,
      userCreated: folder.userCreated,
      isAvailable:folder.isAvailable!,
      backgroundColor:folder.backgroundColor!,
      minLevelToShow: folder.minLevelToShow,
    );*/
    if (nFolder.useAsset == 0) {
      HelperFirebase helperFirebase =
          HelperFirebase(userEmail, userName, HelperFirebase.capetaFolders);
      File file = await helperFirebase.DowloadFile(nFolder, nFolder.fileName);
      if (file != null) {
        nFolder.fileName = file.path;
        String nombreArchivo = "${file.path.split('/').last}";
        nFolder.localFileName = nombreArchivo;
        nFolder.userCreated = 1;
        nFolder.useAsset = 0;
      } else {
        nFolder.fileName = "assets/Images/folders_folder.png";
      }
    }

    try {
      await MFolder.createWithID(nFolder);
    } catch (e) {
      // HelperToast.showToast("error folde id ${nFolder.id} " );
      print(e.toString());
      return;
    }

    // Add relation
  }

  // esta funcion devuelve una lista por si se nesecita pero ya actualiza las traducciones en la bd
  Future<List<Translation>> findARemoteTraslations(
      MFolder localFolder, int selectedFolderToRestore) async {
    // peticion de las traslations
    //dynamic remoteTranslations = webResponseDynamic.content[0];
    String operacionTraslation =
        "operations/v1/listTranslationOfObjectsOfAFoldersOfAUser?email=$userEmail&folderIdInDevice=$selectedFolderToRestore";

    List<dynamic> remoteJsonTranslations =
        await invokeWebServiceGet(operacionTraslation);
    List<Translation> remoteTranslations =
        HelperBR.jsonToTranslation(remoteJsonTranslations);

    // update translations

    return remoteTranslations;
  }

  Future<List<MRelation>> findRemoteRelations(
      int selectedFolderToRestore) async {
    String operacion =
        'operations/v1/listRelationsOfAFoldersOfAUser?email=$userEmail&folderIdInDevice=$selectedFolderToRestore';
    List<dynamic> remoteJsonRelations = await invokeWebServiceGet(operacion);
    List<MRelation> remoteRelations =
        await HelperBR.jsonToRelations(remoteJsonRelations);
    return remoteRelations;
  }

  Future<List<MImage>> findRemoteImages(
      {int selectedFolderToRestore,
      List<Translation> remoteTranslations,
      MFolder localFolder,
      List<MRelation> remoteRelations}) async {
    // peticion de imagenes
    String operacionImages =
        "operations/v1/listImagesOfAFoldersOfAUser?email=$userEmail&folderIdInDevice=$selectedFolderToRestore";
    List<dynamic> remoteJsonImages = await invokeWebServiceGet(operacionImages);
    List<MImage> remoteImages = HelperBR.jsonToImages(remoteJsonImages);

    for (var i in remoteImages) {
      await addRemoteImage(i, remoteTranslations, remoteRelations, localFolder);
    }
    return remoteImages;
  }

  Future<List<MFolder>> findRemoteFolders(
      {int selectedFolderToRestore,
      List<Translation> remoteTranslations,
      MFolder localFolder,
      List<MRelation> remoteRelations,
      MRelation relation}) async {
    String operacionFolderes =
        "operations/v1/listFoldersOfAFoldersOfAUser?email=$userEmail&folderIdInDevice=$selectedFolderToRestore";

    Map<String, dynamic> json =
        await invokeWebServiceGetFolders(operacionFolderes);
    dynamic jsonRoofolder = json["rootFolder"];
    dynamic remoteJsonFolders = json["message"];

    List<MFolder> remoteFolders = HelperBR.jsonToFolder(remoteJsonFolders);
    MFolder roofolder = MFolder.jsonToFolder(jsonRoofolder["folder"][0]);
    MRelation rooRelation =
        MRelation.jsonToRelation(jsonRoofolder["relation"][0]);

    if (relation != null) {
      rooRelation.visibleIndex = relation.visibleIndex;
      rooRelation.parentFolderId = relation.parentFolderId;
    }

    rooRelation.gridColumns = 6;

    //roofolder.parentFolderId = localFolder.id;
    //roofolder.id= localFolder.id;

    //MFolder.createWithID(roofolder);

    await addRemoteFolder(roofolder);

    MRelation.createWithID(rooRelation);

    for (var i in remoteFolders) {
      await addRemoteFolder(i);
    }
    return remoteFolders;
  }
}
