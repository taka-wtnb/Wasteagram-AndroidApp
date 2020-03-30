// Author: Takahiro Watanabe
// Program Name: CS492 (Winter 2020) Project 5: Wasteagram / post_form.dart file
// Description: This file implements a form for a new food waste post. 
// Source 1: Lecture videos from Week 9 and Week 10 modules in CS492 (Winter 2020)
// Source 2: <Title> How to create number input field in Flutter?
//           <Author> Rissmon Suresh
//           <Date of Retrieval> 03/08/20
//           <Availability> https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import '../screens/list_screen.dart';
import '../db/new_post_dto.dart';
import 'custom_sized_box.dart';

class PostForm extends StatefulWidget {

  final File image;
  final String imageURL;

  PostForm({Key key, this.image, this.imageURL,}) : super(key: key);

  @override
  _PostFormState createState() => _PostFormState();
}  

class _PostFormState extends State<PostForm> {

  final formKey = GlobalKey<FormState>();
  final newPostFields = NewPostDTO();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: formContent(context, widget.image, widget.imageURL,),
    ); 
  }

  Widget formContent(BuildContext context, File image, String imageURL,) {

    newPostFields.date = DateTime.now();
    newPostFields.imageURL = imageURL;

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Center( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customSizedBox(context, 10, 5),
              Semantics(
                child: SizedBox(
                  width: 350,
                  height: 200,
                  child:  Image.file(image, fit: BoxFit.fitWidth)
                ),
                image: true,
                label: 'The photo of wasted food',
              ),
              customSizedBox(context, 10, 5), 
              Container(
                width: 350,  
                child: numberField(),
              ),
              customSizedBox(context, 200, 5), 
              uploadButton(context),                
            ],
          ),
        ),
      )
    );
  }

  Widget numberField() {
    return TextFormField(
      key: Key('numberOfItems'),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Number of Wasted Items',
        labelText: 'Number of Items',
      ),
      style: Theme.of(context).textTheme.title,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
      onSaved: (value) {
        // Store value in some object
        newPostFields.quantity = int.parse(value);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a number of watested items';
        } else {
          return null;
        }
      },
    );
  }

  Widget uploadButton(BuildContext context) {
    return Semantics(
      child: ButtonTheme(
        minWidth: 400,
        height: 100,
        child: RaisedButton(
          key: Key('upload'),
          onPressed: () async {
            if (formKey.currentState.validate()) {
              formKey.currentState.save();
              var locationService = Location();
              LocationData locationData = await locationService.getLocation();
              newPostFields.latitude = locationData.latitude;
              newPostFields.longitude = locationData.longitude;              
              Firestore.instance.collection('post').add({
                'date': newPostFields.date,
                'imageURL': newPostFields.imageURL,
                'quantity': newPostFields.quantity,
                'latitude': newPostFields.latitude,
                'longitude': newPostFields.longitude,
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListScreen()),
              );
            }
          },
          child: Icon(Icons.cloud_upload, color: Colors.white, size: 100.0,),
        ),
      ),
      button: true,
      enabled: true,
      onTapHint: 'Save and updload the new post',
    );
  }
}