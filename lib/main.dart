import 'dart:io';
import 'package:app_agenda/telas/android/appagenda.dart';
import 'package:flutter/material.dart';

void main() {

  if(Platform.isAndroid){
    debugPrint('app no android');
    runApp(AppAgenda());
  }
  if(Platform.isIOS) {
    debugPrint('app no ios');
  }


}


