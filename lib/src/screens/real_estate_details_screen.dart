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
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: realEstateDetailsItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Row(
              children: <Widget>[
                Image.asset(
                  realEstateDetailsItems[index].assetImage,
                  height: 24.0,
                  width: 24.0,
                ),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        realEstateDetailsItems[index].detail ?? '',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
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
        });
  }

  realEstateDetails(BuildContext context) {
    realEstateDetailsItems = <RealEstateDetailItemModel>[
      RealEstateDetailItemModel(
          assetImage: 'assets/images/numbering.png',
          detail: AppLocalizations.of(context).adNumber,
          value: '8754'),
      RealEstateDetailItemModel(
          assetImage: 'assets/images/timing.png',
          detail: AppLocalizations.of(context).age,
          value: '15'),
      RealEstateDetailItemModel(
          assetImage: 'assets/images/area.png',
          detail: AppLocalizations.of(context).area,
          value: '15'),
      RealEstateDetailItemModel(
          assetImage: 'assets/images/bed.png',
          detail: AppLocalizations.of(context).rooms,
          value: '15'),
      RealEstateDetailItemModel(
          assetImage: 'assets/images/wallet.png',
          detail: AppLocalizations.of(context).insurance,
          value: '15'),
      RealEstateDetailItemModel(
          assetImage: 'assets/images/buildings.png',
          detail: AppLocalizations.of(context).apartments,
          value: '15'),
      RealEstateDetailItemModel(
          assetImage: 'assets/images/electricity.png',
          detail: AppLocalizations.of(context).electricityAccount,
          value: '15'),
      RealEstateDetailItemModel(
          assetImage: 'assets/images/water.png',
          detail: AppLocalizations.of(context).waterAccount,
          value: '15'),
      RealEstateDetailItemModel(
          assetImage: 'assets/images/bathtub.png',
          detail: AppLocalizations.of(context).bathrooms,
          value: '15'),
      RealEstateDetailItemModel(
          assetImage: 'assets/images/floors.png',
          detail: AppLocalizations.of(context).floors,
          value: '15'),
      RealEstateDetailItemModel(
          assetImage: 'assets/images/offices.png',
          detail: AppLocalizations.of(context).offices,
          value: '15'),
      RealEstateDetailItemModel(
          assetImage: 'assets/images/shop.png',
          detail: AppLocalizations.of(context).shops,
          value: '15'),
      RealEstateDetailItemModel(
          assetImage: 'assets/images/lounges.png',
          detail: AppLocalizations.of(context).lounges,
          value: '15'),
      RealEstateDetailItemModel(
          assetImage: 'assets/images/street_width.png',
          detail: AppLocalizations.of(context).streetWidth,
          value: '15')
    ];
  }
}
