import 'package:flutter/material.dart';

class RealEstateDescriptionScreen extends StatefulWidget {
  final String description;
  RealEstateDescriptionScreen(this.description);
  @override
  _RealEstateDescriptionScreenState createState() =>
      _RealEstateDescriptionScreenState(description);
}

class _RealEstateDescriptionScreenState
    extends State<RealEstateDescriptionScreen> {
  String description = "";
  _RealEstateDescriptionScreenState(this.description);
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(8.0),
      child: Text(description),
    ));
  }
}
