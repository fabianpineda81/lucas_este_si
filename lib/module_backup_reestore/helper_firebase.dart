
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart'  as firebase_core;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';





import '../helpers/Helper.dart';
import '../models/MObject.dart';
import 'helper_file.dart';
import 'helper_toas.dart';





class HelperFirebase{
   static const String carpertaRaiz   = "uploads";
   static const String carpetaImagenes= "Images";
   static const String capetaFolders  ="folder";
  String userName;
  String tipo;
  String userEmail;
  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;

  HelperFirebase(this.userEmail,this.userName, this.tipo);


  Future<String> uploadFile(MObject folder) async {

    String  nombreArchivo="${folder.textToSay}-${folder.id}";

    File file = File('${Helper.appDirectory}/${folder.localFileName}');
 try {
      String rutaFirebase= 'uploads/$userEmail/$tipo/$nombreArchivo';
      await firebase_storage.FirebaseStorage.instance.ref(rutaFirebase).putFile(file);
      String link = await firebase_storage.FirebaseStorage.instance.ref(rutaFirebase).getDownloadURL();
      return link ;
    } catch (e) {
      // e.g, e.code == 'canceled'
      return "";
    }
  }
  Future<void> eliminarArchivosPorUsuario()async{

    HelperToast.showToast("Delete files of $userEmail");
    await eliminarArchivos(capetaFolders);
    await eliminarArchivos(carpetaImagenes);
    HelperToast.showToast("deletion completed");
  }


   Future <void> eliminarArchivos( String tipo)async {

    firebase_storage.ListResult result = await firebase_storage.FirebaseStorage.instance.ref("/uploads/$userEmail/$tipo").listAll();
    for (firebase_storage.Reference ref in result.items) {
      await ref.delete();
    }

  }


  Future <File> DowloadFile(MObject object, String link)async {
    String nombreArchivo="";
    String rutaArchivo="";
    try {
      String  v1 = Uuid().v1();
      nombreArchivo="${object.id}$v1.jpeg";
      rutaArchivo= '${Helper.appDirectory}/$nombreArchivo';
      File downloadToFile = File(rutaArchivo);
      await firebase_storage.FirebaseStorage.instance.refFromURL(link).writeToFile(downloadToFile);

      return downloadToFile;

    } catch (e) {
      HelperToast.showToast("fallo la descarga del archivo $nombreArchivo");
      return null;
    }
  }


}


