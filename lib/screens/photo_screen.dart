// Author: Taka Watanabe
// Program Name: CS492 (Winter 2020) Project 5: Wasteagram / photo_screen.dart file
// Description: This file implements the route to be used for the image picker. 
// Source: Lecture videos from Week 9 and Week 10 modules in CS492 (Winter 2020)

import 'package:flutter/material.dart';
import '../widgets/camera_fab.dart';

class PhotoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    cameraFab(context);
    return Scaffold(
      body: Container()
    );
  }
}
