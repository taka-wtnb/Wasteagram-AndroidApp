// Author: Takahiro Watanabe
// Program Name: CS492 (Winter 2020) Project 5: Wasteagram / app.dart file
// Description: This file will used for the integration test of this app's some UX flows
// Source: Lecture videos from Week 9 and Week 10 modules in CS492 (Winter 2020)

import 'package:flutter_driver/driver_extension.dart';
import 'package:wasteagram/main.dart' as app;

void main() {
  enableFlutterDriverExtension();
  app.main();
}