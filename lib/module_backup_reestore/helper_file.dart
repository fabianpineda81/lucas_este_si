import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../models/MObject.dart';


class HelPerFile{
  static  String directorioArchivo="";
  static void init(){
    crearDirectorioFinal();
  }


  static Future<String> moverImagenPermanente( File imagen,) async {
   String pathFinalFoto = join(directorioArchivo,imagen.path.split('/').last);

    File imagenCopiada= await imagen.copy(pathFinalFoto);
   await imagen.delete(recursive: false );
     return imagenCopiada.path;
  }
  static Future<String> guardarArchivo( File imagen,String ruta ) async {
    String pathFinalFoto = join(directorioArchivo,imagen.path.split('/').last);
    Directory(directorioArchivo).create(recursive: false);
    File imagenCopiada= await imagen.copy(pathFinalFoto);
    await imagen.delete(recursive: false );
    return imagenCopiada.path;
  }

  static Future<void>  crearDirectorioFinal() async {
    Directory directoryPath= await getApplicationSupportDirectory();
     directorioArchivo = join(directoryPath.path);
     Directory(directorioArchivo).create(recursive: false);

  }
  static Future<void> deleteLocalFile(MObject object) async {
    File file = File(object.fileName);
    if (file != null) {
      file.delete();
    }
  }
}