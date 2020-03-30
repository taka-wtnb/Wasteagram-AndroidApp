// Author: Takahiro Watanabe
// Program Name: CS492 (Winter 2020) Project 5: Wasteagram / camera_fab.dart file
// Description: This file implements the image picker to select a photo of the food.
//              It also get the URL of the image form Firebase Storage 
// Source: Lecture videos from Week 9 and Week 10 modules in CS492 (Winter 2020)

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/new_post_screen.dart';

void cameraFab(BuildContext context) async {

  File image = await ImagePicker.pickImage(source: ImageSource.gallery);

  StorageReference storageReference =
    FirebaseStorage.instance.ref().child(createFilePath());
    StorageUploadTask uploadTask = storageReference.putFile(image);

  await uploadTask.onComplete;
  final imageURL = await storageReference.getDownloadURL();

  Navigator.push(
    context, 
    MaterialPageRoute(builder: (context) => NewPostScreen(image: image, imageURL: imageURL,) )
  );
}

String createFilePath() {
  return'foodImage_' + DateTime.now().toString();
}