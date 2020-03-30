// Author: Taka Watanabe
// Program Name: CS492 (Winter 2020) Project 5: Wasteagram / detail_screen.dart file
// Description: This file implements the route to display the details of a single food waste post.
// Source 1: Lecture videos from Week 9 and Week 10 modules in CS492 (Winter 2020)
// Source 2: <Title> Check image is loaded in Image.network widget in flutter
//           <Author> Aditya Sharma
//           <Date of Retrieval> 03/12/20
//           <Availability> https://stackoverflow.com/questions/50759555/check-image-is-loaded-in-image-network-widget-in-flutter

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/food_waste_post.dart';
import '../widgets/custom_sized_box.dart';
import 'list_screen.dart';

class DetailScreen extends StatelessWidget {

  final FoodWastePost post;

  DetailScreen({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Semantics(
          child:  IconButton(
            key: Key('backToList'),
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
      body: layout(context),
    );
  }

  Widget layout(BuildContext context) {
    return SizedBox.expand(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customSizedBox(context, 20, 5),
              Semantics(
                child: Text(
                  DateFormat.yMMMMEEEEd().format(post.date), 
                  key: Key('date'),
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                label: 'The date the post was created',
              ),
              customSizedBox(context, 20, 5),
              imageSemantics(post),
              customSizedBox(context, 20, 0),
              Semantics(
                child: Text(
                  'Item: ${post.quantity}', 
                  key: Key('quantity'),
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)
                  ),
                label: 'The number of wasted items',
              ),
              customSizedBox(context, 20, 0),
              Semantics(
                child: Text(
                  '(${post.latitude}, ${post.longitude})', 
                  key: Key('location'),
                  style: TextStyle(fontSize: 24)),
                label: 'The latitude and longitude of the location where the post was submitted',
              ),
            ],
          )
        )
      )
    );
  }

  Widget imageSemantics(FoodWastePost post) {
    return Semantics(
      child: SizedBox(
        width: 350,
        height: 200,
        child:  Image.network(
          post.imageURL, 
          fit: BoxFit.fitWidth,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator( 
                value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                  : null,
              ),
            );
          },
        ),
      ),
      image: true,
      label: 'The photo of wasted food',
    );
  }
}
