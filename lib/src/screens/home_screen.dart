import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:aeqarat/src/models/real_estates_response_model.dart';
import 'package:aeqarat/src/utils/localization/app_locale.dart';
import 'package:aeqarat/src/utils/networking/real_estates_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

enum MarkersVisibility {
  Visible,
  Invisible,
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController mapController;
  final LatLng _center = const LatLng(24.5538107, 46.0265294);
  String _mapStyle;
  BitmapDescriptor customMarker;
  bool _loadingRealEstates = false;
  MarkersVisibility rentVisibility = MarkersVisibility.Visible;
  MarkersVisibility saleVisibility = MarkersVisibility.Visible;
  MarkersVisibility auctionsVisibility = MarkersVisibility.Visible;

  final Map<String, Marker> _allMarkers = {};
  final Map<String, Marker> _rentMarkers = {};
  final Map<String, Marker> _saleMarkers = {};
  final Map<String, Marker> _auctionMarkers = {};

  Set<Marker> _markersOnMap = {};

  String serviceType = "rent";
  String propertyType = "apartment";
  String region = "riyadh";
  String district = "riyadh";
  String propertyAge = "10";
  RangeValues priceRangeValues = const RangeValues(1000, 1000000);
  RangeLabels priceRangeLabels = RangeLabels('1000', '1000000');
  RangeValues distanceRangeValues = const RangeValues(1000, 1000000);
  RangeLabels distanceRangeLabels = RangeLabels('1000', '1000000');

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((jsonStyle) => {
          _mapStyle = jsonStyle,
        });
  }

  @override
  Widget build(BuildContext context) {
    var locale = Provider.of<AppLocale>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ///////////////////////////// Map
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 3.0,
            ),
            zoomControlsEnabled: false,
            markers: _markersOnMap,
            myLocationButtonEnabled: false,
            myLocationEnabled: false,
          ),
          ///////////////////////////////// Search Delegate
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 60.0, right: 16.0, left: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: const Color(0x709e9e9e),
                      offset: Offset(1, 2),
                      blurRadius: 5,
                      spreadRadius: 1),
                  BoxShadow(
                      color: const Color(0x709e9e9e),
                      offset: Offset(1, 2),
                      blurRadius: 5,
                      spreadRadius: 1),
                  BoxShadow(
                      color: const Color(0x709e9e9e),
                      offset: Offset(1, 2),
                      blurRadius: 5,
                      spreadRadius: 1),
                ],
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.search,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: EdgeInsets.only(right: 4.0, left: 4.0),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            isDense: true,
                            hintText:
                                AppLocalizations.of(context).searchBarHint,
                            hintStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.withOpacity(0.6)),
                            border: InputBorder.none,
                          ),
                        )),
                  ),
                  GestureDetector(
                      onTap: () {
                        _showSearchFilter(context);
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFDB27),
                            shape: BoxShape.circle),
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Image.asset('assets/images/filter.png'),
                        ),
                      )),
                ],
              ),
            ),
          ),
          ///////////////////////////////// Loading
          Align(
              alignment: Alignment.center,
              child: Visibility(
                  visible: _loadingRealEstates,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            child: CircularProgressIndicator(
                                strokeWidth: 1,
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.black)),
                            height: 13,
                            width: 13,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            AppLocalizations.of(context).loading,
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                        ],
                      )))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin:
                      EdgeInsets.only(bottom: 20.0, right: 16.0, left: 16.0),
                  child: Row(
                    children: <Widget>[
                      //////////////////////////////////// Rent Select
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  rentVisibility == MarkersVisibility.Visible
                                      ? _rentMarkersVisibility(false)
                                      : _rentMarkersVisibility(true);
                                });
                              },
                              child: Container(
                                height: 35,
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    boxShadow: rentVisibility ==
                                            MarkersVisibility.Visible
                                        ? <BoxShadow>[
                                            BoxShadow(
                                                color: const Color(0x709e9e9e),
                                                offset: Offset(1, 2),
                                                blurRadius: 5,
                                                spreadRadius: 1),
                                          ]
                                        : null,
                                    color: rentVisibility ==
                                            MarkersVisibility.Visible
                                        ? Colors.grey.withOpacity(0.6)
                                        : Colors.grey.withOpacity(0.1)),
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: locale.locale == Locale('en')
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 8.0, left: 8.0),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .forRent,
                                            style: TextStyle(
                                              color: rentVisibility ==
                                                      MarkersVisibility.Visible
                                                  ? Colors.white
                                                      .withOpacity(1.0)
                                                  : Colors.white
                                                      .withOpacity(0.3),
                                              fontSize: 13,
                                            ),
                                          )),
                                    ),
                                    Align(
                                      alignment: locale.locale == Locale('en')
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Container(
                                        margin: EdgeInsets.all(8.0),
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: rentVisibility ==
                                                    MarkersVisibility.Visible
                                                ? (const Color(0xFFFFDB27))
                                                    .withOpacity(1.0)
                                                : (const Color(0xFFFFDB27))
                                                    .withOpacity(0.3),
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Icon(Icons.check,
                                              size: 15,
                                              color: rentVisibility ==
                                                      MarkersVisibility.Visible
                                                  ? Colors.black
                                                  : Colors.grey
                                                      .withOpacity(0.3)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))),
                      /////////////////////////////////////// Sale Select
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  saleVisibility == MarkersVisibility.Visible
                                      ? _saleMarkersVisibility(false)
                                      : _saleMarkersVisibility(true);
                                });
                              },
                              child: Container(
                                height: 35,
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    boxShadow: saleVisibility ==
                                            MarkersVisibility.Visible
                                        ? <BoxShadow>[
                                            BoxShadow(
                                                color: const Color(0x709e9e9e),
                                                offset: Offset(1, 2),
                                                blurRadius: 5,
                                                spreadRadius: 1),
                                          ]
                                        : null,
                                    color: saleVisibility ==
                                            MarkersVisibility.Visible
                                        ? Colors.grey.withOpacity(0.6)
                                        : Colors.grey.withOpacity(0.1)),
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: locale.locale == Locale('en')
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 8.0, left: 8.0),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .forSale,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: saleVisibility ==
                                                      MarkersVisibility.Visible
                                                  ? Colors.white
                                                      .withOpacity(1.0)
                                                  : Colors.white
                                                      .withOpacity(0.3),
                                            ),
                                          )),
                                    ),
                                    Align(
                                      alignment: locale.locale == Locale('en')
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Container(
                                        margin: EdgeInsets.all(8.0),
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: saleVisibility ==
                                                    MarkersVisibility.Visible
                                                ? (const Color(0xFFFFDB27))
                                                    .withOpacity(1.0)
                                                : (const Color(0xFFFFDB27))
                                                    .withOpacity(0.3),
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.check,
                                            size: 15,
                                            color: saleVisibility ==
                                                    MarkersVisibility.Visible
                                                ? Colors.black
                                                : Colors.grey.withOpacity(0.3),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))),
                      ///////////////////////////////////// Auctions Select
                      Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  auctionsVisibility ==
                                          MarkersVisibility.Visible
                                      ? _auctionMarkersVisibility(false)
                                      : _auctionMarkersVisibility(true);
                                });
                              },
                              child: Container(
                                height: 35,
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    boxShadow: auctionsVisibility ==
                                            MarkersVisibility.Visible
                                        ? <BoxShadow>[
                                            BoxShadow(
                                                color: const Color(0x709e9e9e),
                                                offset: Offset(1, 2),
                                                blurRadius: 5,
                                                spreadRadius: 1),
                                          ]
                                        : null,
                                    color: auctionsVisibility ==
                                            MarkersVisibility.Visible
                                        ? Colors.grey.withOpacity(0.6)
                                        : Colors.grey.withOpacity(0.1)),
                                child: Stack(
                                  children: <Widget>[
                                    Align(
                                      alignment: locale.locale == Locale('en')
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 8.0, left: 8.0),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .auctions,
                                            style: TextStyle(
                                                color: auctionsVisibility ==
                                                        MarkersVisibility
                                                            .Visible
                                                    ? Colors.white
                                                        .withOpacity(1.0)
                                                    : Colors.white
                                                        .withOpacity(0.3),
                                                fontSize: 13),
                                          )),
                                    ),
                                    Align(
                                      alignment: locale.locale == Locale('en')
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Container(
                                        margin: EdgeInsets.all(8.0),
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            color: auctionsVisibility ==
                                                    MarkersVisibility.Visible
                                                ? (const Color(0xFFFFDB27))
                                                    .withOpacity(1.0)
                                                : (const Color(0xFFFFDB27))
                                                    .withOpacity(0.3),
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.check,
                                            size: 15,
                                            color: auctionsVisibility ==
                                                    MarkersVisibility.Visible
                                                ? Colors.black
                                                : Colors.grey.withOpacity(0.3),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ))),
                    ],
                  ))),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/marker.png', 100);
    setState(() {
      _loadingRealEstates = true;
    });
    List<RealEstatesResponseModel> realEstates = await getRealEstates();
    setState(() {
      _allMarkers.clear();
      for (final realEstate in realEstates) {
        final marker = Marker(
          markerId: MarkerId(realEstate.title),
          position: LatLng(double.parse(realEstate.latitude),
              double.parse(realEstate.longitude)),
          icon: BitmapDescriptor.fromBytes(markerIcon),
        );
        _allMarkers[realEstate.sId] = marker;
        switch (realEstate.status) {
          case 'rent':
            _rentMarkers[realEstate.sId] = marker;
            break;
          case 'sale':
            _saleMarkers[realEstate.sId] = marker;
            break;
          case 'auction':
            _auctionMarkers[realEstate.sId] = marker;
            break;
        }
      }
      _markersOnMap = _allMarkers.values.toSet();
      _loadingRealEstates = false;
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future<List<RealEstatesResponseModel>> getRealEstates() async {
    List<RealEstatesResponseModel> realEstates;
    realEstates = await RealEstatesApi().getRealEstates();
    return realEstates;
  }

  void _rentMarkersVisibility(bool visible) {
    if (visible) {
      _markersOnMap = _markersOnMap.union(_rentMarkers.values.toSet());
      rentVisibility = MarkersVisibility.Visible;
    } else {
      _markersOnMap = _markersOnMap.difference(_rentMarkers.values.toSet());
      rentVisibility = MarkersVisibility.Invisible;
    }
  }

  void _saleMarkersVisibility(bool visible) {
    if (visible) {
      _markersOnMap = _markersOnMap.union(_saleMarkers.values.toSet());
      saleVisibility = MarkersVisibility.Visible;
    } else {
      _markersOnMap = _markersOnMap.difference(_saleMarkers.values.toSet());
      saleVisibility = MarkersVisibility.Invisible;
    }
  }

  void _auctionMarkersVisibility(bool visible) {
    if (visible) {
      _markersOnMap = _markersOnMap.union(_auctionMarkers.values.toSet());
      auctionsVisibility = MarkersVisibility.Visible;
    } else {
      _markersOnMap = _markersOnMap.difference(_auctionMarkers.values.toSet());
      auctionsVisibility = MarkersVisibility.Invisible;
    }
  }

  void _showSearchFilter(context) {
    showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext buildContext) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.only(top: 50.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(20.0)),
                  color: const Color(0xffF9FBFC)),
              child: Wrap(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                              AppLocalizations.of(context).advancedSearch)),
                      ////////////////////// Close Bottom Dialog
                      Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF60B0B),
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 15.0,
                                  )))),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  const Divider(
                    color: const Color(0x309e9e9e),
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  /////////////////// Service type list
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffE3E3E6))),
                    child: DropdownButton<String>(
                      value: serviceType,
                      onChanged: (String newValue) {
                        setState(() {
                          serviceType = newValue;
                        });
                      },
                      underline: SizedBox(),
                      isExpanded: true,
                      items: <String>['rent', 'sale', 'auction']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ),
                  /////////////////// Property type list
                  Container(
                    height: 55,
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffE3E3E6))),
                    child: DropdownButton<String>(
                      value: propertyType,
                      onChanged: (String newValue) {
                        setState(() {
                          propertyType = newValue;
                        });
                      },
                      underline: SizedBox(),
                      isExpanded: true,
                      items: <String>['apartment', 'house', 'garage']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ),
                  //////////////////// Region list
                  Container(
                    height: 55,
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffE3E3E6))),
                    child: DropdownButton<String>(
                      value: region,
                      onChanged: (String newValue) {
                        setState(() {
                          region = newValue;
                        });
                      },
                      underline: SizedBox(),
                      isExpanded: true,
                      items: <String>['riyadh']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ),
                  /////////////// District list
                  Container(
                    height: 55,
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffE3E3E6))),
                    child: DropdownButton<String>(
                      value: district,
                      onChanged: (String newValue) {
                        setState(() {
                          district = newValue;
                        });
                      },
                      underline: SizedBox(),
                      isExpanded: true,
                      items: <String>['riyadh']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ),
                  //////////// property age list
                  Container(
                    height: 55,
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.white,
                        border: Border.all(color: const Color(0xffE3E3E6))),
                    child: DropdownButton<String>(
                      value: propertyAge,
                      onChanged: (String newValue) {
                        setState(() {
                          propertyAge = newValue;
                        });
                      },
                      underline: SizedBox(),
                      isExpanded: true,
                      items: <String>['10']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                  ),
                  /////////////// Price range slider
                  Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffE3E3E6))),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Text('Price')),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: RangeSlider(
                                  values: priceRangeValues,
                                  activeColor: const Color(0xffFFDB27),
                                  inactiveColor: const Color(0xffE3E3E6),
                                  min: 1000,
                                  max: 1000000,
                                  divisions: 100,
                                  labels: priceRangeLabels,
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      priceRangeValues = values;
                                      priceRangeLabels = RangeLabels(
                                          "${values.start.toInt().toString()}\$",
                                          "${values.end.toInt().toString()}\$");
                                    });
                                  },
                                ))),
                      ])),
                  /////////////////// Distance range slider
                  Container(
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.white,
                          border: Border.all(color: const Color(0xffE3E3E6))),
                      child: Stack(children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Text('Distance')),
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: RangeSlider(
                                  values: distanceRangeValues,
                                  activeColor: const Color(0xffFFDB27),
                                  inactiveColor: const Color(0xffE3E3E6),
                                  min: 1000,
                                  max: 1000000,
                                  divisions: 100,
                                  labels: distanceRangeLabels,
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      distanceRangeValues = values;
                                      distanceRangeLabels = RangeLabels(
                                          "${values.start.toInt().toString()}\$",
                                          "${values.end.toInt().toString()}\$");
                                    });
                                  },
                                ))),
                      ])),
                  const Divider(
                    color: const Color(0x309e9e9e),
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              flex: 2,
                              child: GestureDetector(
                                child: Container(
                                    height: 50,
                                    margin: EdgeInsets.only(
                                      bottom: 20.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffFFDB27),
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                                    ),
                                    child: Center(child: Text('Search'))),
                              )),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                child: Container(
                                    height: 50,
                                    margin: EdgeInsets.only(bottom: 20.0),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffECECEC),
                                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                                    ),
                                    child: Center(child: Text('Reset'))),
                              )),
                        ],
                      )),
                ],
              ),
            ));
          });
        });
  }
}
