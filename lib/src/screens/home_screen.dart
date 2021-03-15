import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:aeqarat/src/models/real_estates_response_model.dart';
import 'package:aeqarat/src/screens/real_estate_screen.dart';
import 'package:aeqarat/src/utils/localization/app_locale.dart';
import 'package:aeqarat/src/utils/networking/real_estates_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final String lastVisitedRealEstateId;

  HomeScreen({this.lastVisitedRealEstateId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RestorationMixin {
  var locale;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  GoogleMapController mapController;
  Uint8List markerIcon;
  List<RealEstatesResponseModel> _realEstatesList;
  final LatLng _center = const LatLng(24.5538107, 46.0265294);
  String _mapStyle;
  BitmapDescriptor customMarker;

  final Map<String, Marker> _allMarkers = {};
  final Map<String, Marker> _rentMarkers = {};
  final Map<String, Marker> _saleMarkers = {};
  final Map<String, Marker> _auctionMarkers = {};

  Set<Marker> _markersOnMap = {};

  String serviceType;
  String realEstateType;
  String region;
  String district;
  String realEstateAge = "10";
  RangeValues priceRangeValues = const RangeValues(1000, 1000000);
  RangeLabels priceRangeLabels = RangeLabels('1000', '1000000');
  RangeValues distanceRangeValues = const RangeValues(1000, 1000000);
  RangeLabels distanceRangeLabels = RangeLabels('1000', '1000000');

  final RestorableBool isSelectedForRent = RestorableBool(true);
  final RestorableBool isSelectedForSale = RestorableBool(true);
  final RestorableBool isSelectedAuctions = RestorableBool(false);

  @override
  String get restorationId => 'filter_chip_demo';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(isSelectedForRent, 'selected_for_rent');
    registerForRestoration(isSelectedForSale, 'selected_for_sale');
    registerForRestoration(isSelectedAuctions, 'selected_auctions');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    rootBundle.loadString('assets/map_style.txt').then((jsonStyle) => {
          _mapStyle = jsonStyle,
        });
  }

  @override
  Widget build(BuildContext context) {
    locale = Provider.of<AppLocale>(context);
    serviceType = AppLocalizations.of(context).rent;
    realEstateType = AppLocalizations.of(context).apartment;
    region = AppLocalizations.of(context).riyadh;
    district = AppLocalizations.of(context).riyadh;
    final chips = [
      FilterChip(
        avatar: isSelectedForRent.value
            ? Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: const Color(0xFFFFDB27), shape: BoxShape.circle),
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(Icons.check, size: 15, color: Colors.black),
                ),
              )
            : null,
        showCheckmark: false,
        elevation: 0.0,
        labelStyle: TextStyle(
            color: isSelectedForRent.value ? Colors.white : Colors.grey,
            fontSize: 13,
            fontFamily: 'Cairo'),
        backgroundColor: Colors.grey.withOpacity(0.6),
        selectedColor: const Color(0xff707070),
        label: Text(AppLocalizations.of(context).forRent),
        selected: isSelectedForRent.value,
        onSelected: (value) {
          setState(() {
            isSelectedForRent.value = !isSelectedForRent.value;
            _rentMarkersVisibility(isSelectedForRent.value);
          });
        },
      ),
      FilterChip(
        avatar: isSelectedForSale.value
            ? Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: const Color(0xFFFFDB27), shape: BoxShape.circle),
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(Icons.check, size: 15, color: Colors.black),
                ),
              )
            : null,
        showCheckmark: false,
        elevation: 0.0,
        labelStyle: TextStyle(
            color: isSelectedForSale.value ? Colors.white : Colors.grey,
            fontSize: 13,
            fontFamily: 'Cairo'),
        backgroundColor: Colors.grey.withOpacity(0.6),
        selectedColor: const Color(0xff707070),
        label: Text(AppLocalizations.of(context).forSale),
        selected: isSelectedForSale.value,
        onSelected: (value) {
          setState(() {
            isSelectedForSale.value = !isSelectedForSale.value;
            _saleMarkersVisibility(isSelectedForSale.value);
          });
        },
      ),
      FilterChip(
        avatar: isSelectedAuctions.value
            ? Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: const Color(0xFFFFDB27), shape: BoxShape.circle),
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(Icons.check, size: 15, color: Colors.black),
                ),
              )
            : null,
        showCheckmark: false,
        elevation: 0.0,
        labelStyle: TextStyle(
            color: isSelectedAuctions.value ? Colors.white : Colors.grey,
            fontSize: 13,
            fontFamily: 'Cairo'),
        backgroundColor: Colors.grey.withOpacity(0.6),
        selectedColor: const Color(0xff707070),
        label: Text(AppLocalizations.of(context).auctions),
        selected: isSelectedAuctions.value,
        onSelected: (value) {
          setState(() {
            isSelectedAuctions.value = !isSelectedAuctions.value;
            _auctionMarkersVisibility(isSelectedAuctions.value);
          });
        },
      )
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _realEstates,
        child: Stack(
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
              mapToolbarEnabled: false,
            ),
            ///////////////////////////////// Search Delegate
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
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
            /////////////////////////// Filter Chip
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0, right: 16.0, left: 16.0),
                child: Wrap(
                  children: <Widget>[
                    for (final chip in chips)
                      Padding(padding: const EdgeInsets.all(4), child: chip)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
    markerIcon = await getBytesFromAsset('assets/images/marker.png', 100);
    if (widget.lastVisitedRealEstateId != null) {
      Navigator.of(context)
          .push(RealEstateScreen.route(widget.lastVisitedRealEstateId));
    }
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

  Future<Null> _realEstates() async {
    return RealEstatesApi().getRealEstates().then((realEstatesList) {
      setState(() {
        _realEstatesList = realEstatesList;
        _allMarkers.clear();
        for (final realEstate in _realEstatesList) {
          final marker = Marker(
            markerId: MarkerId(realEstate.sId),
            position: LatLng(double.parse(realEstate.latitude),
                double.parse(realEstate.longitude)),
            icon: BitmapDescriptor.fromBytes(markerIcon),
            onTap: () {
              Navigator.of(context)
                  .push(RealEstateScreen.route(realEstate.sId));
            },
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
        _markersOnMap =
            _rentMarkers.values.toSet().union(_saleMarkers.values.toSet());
      });
    });
  }

  void _rentMarkersVisibility(bool visible) {
    if (visible) {
      _markersOnMap = _markersOnMap.union(_rentMarkers.values.toSet());
    } else {
      _markersOnMap = _markersOnMap.difference(_rentMarkers.values.toSet());
    }
  }

  void _saleMarkersVisibility(bool visible) {
    if (visible) {
      _markersOnMap = _markersOnMap.union(_saleMarkers.values.toSet());
    } else {
      _markersOnMap = _markersOnMap.difference(_saleMarkers.values.toSet());
    }
  }

  void _auctionMarkersVisibility(bool visible) {
    if (visible) {
      _markersOnMap = _markersOnMap.union(_auctionMarkers.values.toSet());
    } else {
      _markersOnMap = _markersOnMap.difference(_auctionMarkers.values.toSet());
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
                      items: <String>[
                        AppLocalizations.of(context).rent,
                        AppLocalizations.of(context).sale,
                        AppLocalizations.of(context).auction,
                      ].map<DropdownMenuItem<String>>((String value) {
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
                      value: realEstateType,
                      onChanged: (String newValue) {
                        setState(() {
                          realEstateType = newValue;
                        });
                      },
                      underline: SizedBox(),
                      isExpanded: true,
                      items: <String>[
                        AppLocalizations.of(context).apartment,
                        AppLocalizations.of(context).house,
                        AppLocalizations.of(context).garage,
                      ].map<DropdownMenuItem<String>>((String value) {
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
                      items: <String>[
                        AppLocalizations.of(context).riyadh,
                      ].map<DropdownMenuItem<String>>((String value) {
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
                      items: <String>[
                        AppLocalizations.of(context).riyadh,
                      ].map<DropdownMenuItem<String>>((String value) {
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
                      value: realEstateAge,
                      onChanged: (String newValue) {
                        setState(() {
                          realEstateAge = newValue;
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
                          alignment: locale.locale == Locale('en')
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Text(AppLocalizations.of(context).price)),
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
                                  divisions: 1000,
                                  labels: priceRangeLabels,
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      priceRangeValues = values;
                                      priceRangeLabels = RangeLabels(
                                          "${values.start.toInt().toString()}",
                                          "${values.end.toInt().toString()}");
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
                          alignment: locale.locale == Locale('en')
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child:
                                  Text(AppLocalizations.of(context).distance)),
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
                                  divisions: 1000,
                                  labels: distanceRangeLabels,
                                  onChanged: (RangeValues values) {
                                    setState(() {
                                      distanceRangeValues = values;
                                      distanceRangeLabels = RangeLabels(
                                          "${values.start.toInt().toString()}",
                                          "${values.end.toInt().toString()}");
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Center(
                                        child: Text(AppLocalizations.of(context)
                                            .search))),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Center(
                                        child: Text(AppLocalizations.of(context)
                                            .reset))),
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
