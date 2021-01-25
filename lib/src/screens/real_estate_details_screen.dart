import 'package:aeqarat/src/models/real_estate_detail_item_model.dart';
import 'package:flutter/material.dart';

class RealEstateDetailsScreen extends StatefulWidget {
  @override
  _RealEstateDetailsScreenState createState() =>
      _RealEstateDetailsScreenState();
}

class _RealEstateDetailsScreenState extends State<RealEstateDetailsScreen> {
  List<RealEstateDetailItemModel> realEstateDetailsItems =
      <RealEstateDetailItemModel>[
    RealEstateDetailItemModel(icon: Icon(Icons.reorder_outlined), detail: 'Ad Number', value: '8754')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: null),
    );
  }
}
