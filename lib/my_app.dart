// Author: Takahiro Watanabe
// Program Name: CS492 (Winter 2020) Project 5: Wasteagram / my_app.dart file
// Description: This file implements the MyApp widget, which is a root widget 
//              of this application
// Source: Lecture videos from Week 9 and Week 10 modules in CS492 (Winter 2020)

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:sentry/sentry.dart';
import 'screens/list_screen.dart';

const SENTRY_DSN = 'assets/sentry_dsn.txt';

class MyApp extends StatelessWidget {

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = 
    FirebaseAnalyticsObserver(analytics: analytics);

  static Future<void> reportError(dynamic error, dynamic stackTrace) async {

    String dsn = await rootBundle.loadString(SENTRY_DSN);
    final SentryClient sentry = SentryClient(dsn: dsn);
       
    final SentryResponse response = await sentry.captureException(
      exception: error,
      stackTrace: stackTrace
    );
    if (response.isSuccessful) {
      print('Sentry ID: ${response.eventId}');
    } else {
      print('Failed to report to Sentry: ${response.error}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: ListScreen(analytics: analytics, observer: observer),
    );
  }
}