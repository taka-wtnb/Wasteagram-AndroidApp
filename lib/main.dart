// Author: Taka Watanabe
// Program Name: CS492 (Winter 2020) Project 5: Wasteagram / main.dart file
// Description: This file implements the main function, which is an entry point 
//              of this application
// Source: Lecture videos from Week 9 and Week 10 modules in CS492 (Winter 2020)

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'my_app.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
    
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  FlutterError.onError = (FlutterErrorDetails details) {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };
  runZoned( () {
    runApp(MyApp());
  }, onError: (error, stackTrace) {
    MyApp.reportError(error, stackTrace);
  });
}
