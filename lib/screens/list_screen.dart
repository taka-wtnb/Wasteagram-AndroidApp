// Author: Takahiro Watanabe
// Program Name: CS492 (Winter 2020) Project 5: Wasteagram / list_screen.dart file
// Description: This file implements the route to display the list of food waste posts.
//              If there is no post, it shows the circular progress indicator. 
// Source 1: Lecture videos from Week 9 and Week 10 modules in CS492 (Winter 2020)
// Source 2: <Title> How do I make some text tappable (respond to taps) in Flutter?
//           <Author> Alexi Coard
//           <Date of Retrieval> 03/16/20
//           <Availability> https://stackoverflow.com/questions/44466908/how-do-i-make-some-text-tappable-respond-to-taps-in-flutter

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/screens/crash_error_screen.dart';
import '../models/food_waste_post.dart';
import '../models/food_waste_post_list.dart';
import 'crash_error_screen.dart';
import 'detail_screen.dart';
import 'photo_screen.dart';

class ListScreen extends StatefulWidget {
  
  ListScreen({Key key, this.analytics, this.observer}) : super(key: key);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _ListScreenState createState() => _ListScreenState(analytics, observer);
}

class _ListScreenState extends State<ListScreen> {

  _ListScreenState(this.analytics, this.observer);
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  Future<void> _sendAnalyticsEvent() async {
    await analytics.logEvent(
      name: 'tap_appBar',
      parameters: <String, dynamic>{
        'string': 'tap_list_screen_appBar',
      },
    );
  }

  Future<void> _sendTitleTapEvent() async {
    await analytics.logEvent(
      name: 'tap_title_text',
      parameters: <String, dynamic>{
        'string': 'tap_list_screen_title_text',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () { _sendAnalyticsEvent(); },
          child: Center(child: Text('Tap!', style: TextStyle(fontSize: 20)),)
        ),
        centerTitle: true, 
        title: StreamBuilder(
          stream: Firestore.instance.collection('post').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.documents != null && snapshot.data.documents.length > 0) {
              int itemTotal = 0;
              for (int i = 0; i < snapshot.data.documents.length; i++) {
                itemTotal += snapshot.data.documents[i]['quantity'];
              }
              return Semantics(
                child: InkWell(
                  onTap: () { _sendTitleTapEvent(); },
                  child: Text('Wasteagram - ' + itemTotal.toString(), style: TextStyle(fontSize: 30, color: Colors.white)),
                ),
                label: 'Total number of wasted items in this list',
              );
              
            } else {
              return Text('Wasteagram', style: TextStyle(fontSize: 30));
            }
          }
        ),
        actions: [
          Semantics(
            child: IconButton(
              icon: Icon(Icons.warning, color: Colors.white, size: 36.0,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CrashErrorScreen()),
                );
              },
            ),
            enabled: true,
            onTapHint: 'Error occurs to notify Sentry',
          ),
        ],
      ),
      body: displayBody(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: 80.0,
        height: 80.0,
        child: fabSemantics(context),
      ),
    );
  }
  
  Widget displayBody(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('post').orderBy('date', descending: true).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data.documents != null && snapshot.data.documents.length > 0) {
          FoodWastePostList postList;
          List<FoodWastePost> posts = List();
          for (int i = 0; i < snapshot.data.documents.length; i++) {
            posts.add(
              FoodWastePost.fromMap({
                'date' : snapshot.data.documents[i]['date'].toDate(),
                'imageURL' : snapshot.data.documents[i]['imageURL'],
                'quantity' : snapshot.data.documents[i]['quantity'],
                'latitude' : snapshot.data.documents[i]['latitude'],
                'longitude' : snapshot.data.documents[i]['longitude'],
              })
            );
          }
          postList = FoodWastePostList(posts: posts);          
          return SafeArea(
            child: Container(
              child: ListView.builder(
                itemCount: postList.listLength,
                itemBuilder: (context, index) {
                  return Semantics(
                    child: ListTile(
                      key: Key('postDetail'),
                      title: Text(
                        DateFormat.yMMMMEEEEd().format(postList.getEachEntry(index).date), 
                        style: TextStyle(fontSize: 20),
                        key: Key('listDate_$index'),
                        ),
                      trailing: Text(
                        postList.getEachEntry(index).quantity.toString(), 
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        key: Key('listQty_$index'),
                        ),
                      onTap: () {
                        final FoodWastePost display = FoodWastePost(
                          date: postList.getEachEntry(index).date,
                          imageURL: postList.getEachEntry(index).imageURL,
                          quantity: postList.getEachEntry(index).quantity,
                          latitude: postList.getEachEntry(index).latitude,
                          longitude: postList.getEachEntry(index).longitude,
                        );
              
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DetailScreen(post: display)),
                        );
                      }
                    ),
                    onTapHint: 'See this post\'s detail',
                    enabled: true,
                  );
                },
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget fabSemantics(BuildContext context) {
    return Semantics(
      child: FloatingActionButton(
        key: Key('newPost'),
        child: Icon(Icons.camera_alt, size: 50.0,),
        onPressed: () {     
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => PhotoScreen() )
          ); 
        }
      ),
      button: true,
      enabled: true,
      onTapHint: 'Select an image',
    ); 
  }
}