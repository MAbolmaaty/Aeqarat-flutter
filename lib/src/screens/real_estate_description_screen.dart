import 'package:flutter/material.dart';

class RealEstateDescriptionScreen extends StatefulWidget {
  @override
  _RealEstateDescriptionScreenState createState() =>
      _RealEstateDescriptionScreenState();
}

class _RealEstateDescriptionScreenState
    extends State<RealEstateDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Text('Real Estate in the main district'),
      ),
    );
  }
}
