// Author: Taka Watanabe
// Program Name: CS492 (Winter 2020) Project 5: Wasteagram / food_waste_post.dart file
// Description: This file implements the FoodWastePost class, which is a model to
//              represent a post of the wasted food
// Source: Lecture videos from Week 9 and Week 10 modules in CS492 (Winter 2020)

class FoodWastePost {
  final DateTime date;
  final String imageURL; 
  final int quantity;
  final double latitude;
  final double longitude;

  FoodWastePost({this.date, this.imageURL, this.quantity, this.latitude, this.longitude});
  
  factory FoodWastePost.fromMap(Map<String, dynamic> post) {
    return FoodWastePost(
      date: post['date'],
      imageURL: post['imageURL'],
      quantity: post['quantity'],
      latitude: post['latitude'],
      longitude: post['longitude'],
    );
  }
}
