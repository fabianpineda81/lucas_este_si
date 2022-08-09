import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HelperToast{


  static void showToast(String texto){
   Fluttertoast.showToast(msg: texto);

  }



}