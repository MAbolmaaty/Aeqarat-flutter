import 'package:aeqarat/src/models/real_estate_review_item_model.dart';
import 'package:flutter/material.dart';

class RealEstateReviewsScreen extends StatefulWidget {
  @override
  _RealEstateReviewsScreenState createState() =>
      _RealEstateReviewsScreenState();
}

class _RealEstateReviewsScreenState extends State<RealEstateReviewsScreen> {
  List<RealEstateReviewItemModel> realEstateReviewsItems;

  @override
  Widget build(BuildContext context) {
    realEstateReviews(context);
    return ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: realEstateReviewsItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("assets/images/apartment.jpg"),
              )
            ],
          );
        });
  }

  realEstateReviews(BuildContext context) {
    realEstateReviewsItems = <RealEstateReviewItemModel>[
      RealEstateReviewItemModel(),
    ];
  }
}
