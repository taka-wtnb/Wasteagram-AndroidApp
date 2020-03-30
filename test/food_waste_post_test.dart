// Author: Taka Watanabe
// Program Name: CS492 (Winter 2020) Project 5: Wasteagram / food_waste_post_test.dart file
// Description: This file implements three unit tests that test the model class
// Source: Lecture videos from Week 9 and Week 10 modules in CS492 (Winter 2020)

import 'package:test/test.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:wasteagram/models/food_waste_post_list.dart';

void main() {
  test('Test 1 (FoodWastePost class): Post created from Map should have appropriate property values', () {
    final date = DateTime.parse('2020-03-14');
    const url = 'https://flutter/test/image/???';
    const quantity = 77;
    const latitude = 24.3368;
    const longitude = -57.1092;

    final firstTestPost = FoodWastePost.fromMap({
      'date' : date,
      'imageURL' : url,
      'quantity' : quantity,
      'latitude' : latitude,
      'longitude' : longitude
    });

    expect(firstTestPost.date, date);
    expect(firstTestPost.imageURL, url);
    expect(firstTestPost.quantity, quantity);
    expect(firstTestPost.latitude, latitude);
    expect(firstTestPost.longitude, longitude);
  });

  test('Test 2 (FoodWastePost class): Post created from the constructor should also have appropriate property values', () {
    final date = DateTime.parse('2019-12-30');
    const url = 'http://dart/unit/photo/!=4';
    const quantity = 0;
    const latitude = -82.0;
    const longitude = 39.0000;

    final secondTestPost = FoodWastePost(
      date: date, imageURL: url, quantity: quantity, latitude: latitude, longitude: longitude
    );

    expect(secondTestPost.date, date);
    expect(secondTestPost.imageURL, url);
    expect(secondTestPost.quantity, quantity);
    expect(secondTestPost.latitude, latitude);
    expect(secondTestPost.longitude, longitude);
  });

  test('Test 3 (FoodWastePostList class): Length of the List of posts should be equal to the number of elements', () {

    List<FoodWastePost> postList = [
      FoodWastePost(
        date: DateTime.parse('2018-05-02'), 
        imageURL: 'http://cs492/project5/image/%&#', 
        quantity: 999, 
        latitude: -258.3326, 
        longitude: -0.24,
      ),
      FoodWastePost.fromMap({
        'date' : DateTime.parse('1999-11-28'),
        'imageURL' : 'https://github/newrepo/file/93t7!',
        'quantity' : 3,
        'latitude' : 6.3,
        'longitude' : 82.794,
      })
    ]; 

    FoodWastePostList testList = FoodWastePostList(posts: postList);

    expect(testList.listLength, 2);
  });
}
