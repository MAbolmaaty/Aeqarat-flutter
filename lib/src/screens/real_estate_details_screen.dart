import 'package:aeqarat/src/models/real_estate_detail_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RealEstateDetailsScreen extends StatefulWidget {
  @override
  _RealEstateDetailsScreenState createState() =>
      _RealEstateDetailsScreenState();
}

class _RealEstateDetailsScreenState extends State<RealEstateDetailsScreen> {
  List<RealEstateDetailItemModel> realEstateDetailsItems;

  @override
  Widget build(BuildContext context) {
    realEstateDetails(context);
    return Scaffold(
      body: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: realEstateDetailsItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    realEstateDetailsItems[index].iconData ?? Icons.warning,
                    size: 30,
                    color: const Color(0xFFFFDB27),
                  ),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          realEstateDetailsItems[index].detail ?? '',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Text(realEstateDetailsItems[index].hint ?? '')),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          realEstateDetailsItems[index].value ?? '',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ))
                ],
              ),
            );
          }),
    );
  }

  realEstateDetails(BuildContext context){
    realEstateDetailsItems =
    <RealEstateDetailItemModel>[
      RealEstateDetailItemModel(
          iconData: Icons.flag_rounded, detail: AppLocalizations.of(context).adNumber, value: '8754'),
      RealEstateDetailItemModel(
          iconData: Icons.alarm, detail: 'Age', value: '15')
    ];
  }
}
