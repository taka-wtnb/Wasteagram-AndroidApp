// Author: Takahiro Watanabe
// Program Name: CS492 (Winter 2020) Project 5: Wasteagram / crash_error_screen.dart file
// Description: This file implements the route to cause the app crashed.
//              It is only used to report an error to Sentry for the project's extra credit purpose. 
// Source: Lecture videos from Week 9 and Week 10 modules in CS492 (Winter 2020)

import 'package:flutter/material.dart';

class CrashErrorScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    throw StateError('Wasteagram Error!');

    return Scaffold(
      body: Container()
    );
  }
}