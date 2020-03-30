// Author: Takahiro Watanabe
// Program Name: CS492 (Winter 2020) Project 5: Wasteagram / food_waste_post_list.dart file
// Description: This file implements the FoodWastePostList class, which is a model to
//              represent a list of food waste posts.
// Source: Lecture videos from Week 9 and Week 10 modules in CS492 (Winter 2020)

import 'food_waste_post.dart';

class FoodWastePostList {

  final List<FoodWastePost> posts;

  FoodWastePostList({this.posts});

  int get listLength => posts.length;

  FoodWastePost getEachEntry(int i) {
    return posts[i];
  }
}