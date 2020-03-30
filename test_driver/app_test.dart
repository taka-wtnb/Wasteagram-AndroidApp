// Author: Takahiro Watanabe
// Program Name: CS492 (Winter 2020) Project 5: Wasteagram / app_test.dart file
// Description: This file implements two integration tests to test this app's particular UX flows
// Source: Lecture videos from Week 9 and Week 10 modules in CS492 (Winter 2020)

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Westeagram Integration Test', () {

    final dateFinder = find.byValueKey('date');
    final qtyFinder = find.byValueKey('quantity');
    final locationFinder = find.byValueKey('location');
    final postDetailFinder = find.byValueKey('postDetail');
    final backToListFinder = find.byValueKey('backToList');
    final newPostFinder = find.byValueKey('newPost');
    final numOfItemsFinder = find.byValueKey('numberOfItems');
    final uploadFinder = find.byValueKey('upload');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Go to Detail screen and verify some values', () async {

      await driver.waitFor(postDetailFinder);

      expect(await driver.getText(dateFinder), 'Monday, March 16, 2020');
      expect(await driver.getText(qtyFinder), 'Item: 3');
      expect(await driver.getText(locationFinder), '(46.9462217, -69.0048483)');

      await driver.tap(backToListFinder);
    });

    test('Create a new Post and verify some values', () async {
      await driver.tap(newPostFinder);

      await driver.waitFor(numOfItemsFinder);
      await driver.tap(numOfItemsFinder);
      await driver.enterText('5');

      await driver.tap(uploadFinder);
      await driver.waitFor(postDetailFinder);

      expect(await driver.getText(dateFinder), 'Monday, March 16, 2020');
      expect(await driver.getText(qtyFinder), 'Item: 5');
      expect(await driver.getText(locationFinder), '(46.9462217, -69.0048483)');
    });
  });
}