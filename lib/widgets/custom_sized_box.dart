// Author: Takahiro Watanabe
// Program Name: CS492 (Winter 2020) Project 5: Wasteagram / custom_sized_box.dart file
// Description: This file implements a utility function to provide a sized box for spacing. 

import 'package:flutter/material.dart';

Widget customSizedBox(BuildContext context, double portHeight, double landHeight) {
  if (MediaQuery.of(context).orientation == Orientation.landscape) {
    return SizedBox(height: landHeight);
  } else {
    return SizedBox(height: portHeight);
  }
}