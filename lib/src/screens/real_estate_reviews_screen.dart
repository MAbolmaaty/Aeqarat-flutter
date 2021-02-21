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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage("assets/images/john-smith.jpg"),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 4.0, left: 4.0),
                    child: Column(
                      children: <Widget>[
                        Text('John Smith'),
                        SizedBox(
                          height: 2.0,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(5, (index) {
                            final int value = 3;
                            return Icon(
                              Icons.star,
                              size: 15,
                              color: index < value
                                  ? const Color(0xffFFDB27)
                                  : Colors.grey,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'What a wonderful deal, open the door i am on the way!!',
                style: TextStyle(fontSize: 13),
              ),
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
