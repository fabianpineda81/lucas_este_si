import 'dart:ffi';

import 'package:flutter/cupertino.dart';

import 'helper_firebase.dart';
import 'helper_toas.dart';
import 'helper_web_service.dart';

class HelperBackUp{


 static Future<Void> backup(String userEmail, String userName,  Function actualizarEstado)async{
   HelperWebService webService= HelperWebService(userEmail, userName);
   // este metodo hay pasarlo al metodo que hace el backup total por ahora esta aca

   HelperFirebase firebase = HelperFirebase(userEmail, userName, HelperFirebase.capetaFolders);
   // este metodo hay pasarlo al metodo que hace el backup total por ahora esta aca
   await firebase.eliminarArchivosPorUsuario();

    await webService.backUpTraslations(actualizarEstado);
    actualizarEstado("completed translations");
    HelperToast.showToast("completed translations");
    await webService.backUpRelation(actualizarEstado);
    HelperToast.showToast("Relations completed");
    actualizarEstado("Relations completed");

    await webService.backUpFolders(firebase,actualizarEstado);
    HelperToast.showToast("folders completed");
    actualizarEstado("folders completed");
    firebase.tipo=HelperFirebase.carpetaImagenes;
    await webService.backUpImages(firebase,actualizarEstado);
    HelperToast.showToast("images completed");
   actualizarEstado("Images completed");

   // HelperToast.showToast("Termino la subida de Images");
  }

  static Future<void> reestore(String userEmailNameToRestore, int selectedFolderToRestore, int selectedLocalFolder, Function actualizarEstado) async {
  HelperWebService webService=HelperWebService(userEmailNameToRestore, "");

  await webService.replaceFolder(userEmailNameToRestore, selectedFolderToRestore, selectedLocalFolder,actualizarEstado);
  }






}