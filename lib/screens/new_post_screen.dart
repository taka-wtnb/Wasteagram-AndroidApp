// Author: Taka Watanabe
// Program Name: CS492 (Winter 2020) Project 5: Wasteagram / new_post_screen.dart file
// Description: This file implements the route to display a form to enter and upload a new post. 
// Source: Lecture videos from Week 9 and Week 10 modules in CS492 (Winter 2020)

import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/post_form.dart';
import 'list_screen.dart';

class NewPostScreen extends StatelessWidget {

  final File image;
  final String imageURL;

  NewPostScreen({Key key, this.image, this.imageURL,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Semantics(
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 36.0,), 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListScreen()),
              );
            }
          ),
          onTapHint: 'Go back to the list screen',
          enabled: true,
        ),
        centerTitle: true, 
        title: const Text('Wasteagram', style: TextStyle(fontSize: 30)),
      ),
      body: SafeArea(child: PostForm(image: image, imageURL: imageURL,),),
    );
  }
}
