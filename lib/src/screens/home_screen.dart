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
          ),
          ///////////////////////////////// Loading
          Align(
            alignment: locale.locale == Locale('en')
                ? Alignment.topLeft
                : Alignment.topRight,
            child: Padding(
                padding: EdgeInsets.only(top: 60, right: 8.0, left: 8.0),
                child: Visibility(
                    visible: _loadingRealEstates,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          child: CircularProgressIndicator(
                              strokeWidth: 1,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.black)),
                          height: 11,
                          width: 11,
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          AppLocalizations.of(context).loadingRealEstates,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ))),
          ),
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
                                  auctionsVisibility == MarkersVisibility.Visible
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/icons/marker.png')
        .then((icon) async {
      customMarker = icon;
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
            icon: customMarker,
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
    });
  }

  Future<List<RealEstatesResponseModel>> getRealEstates() async {
    List<RealEstatesResponseModel> realEstates;
    realEstates = await RealEstatesApi().getRealEstates();
    return realEstates;
  }

  void _rentMarkersVisibility(bool visible) {
    if(visible) {
      _markersOnMap = _markersOnMap.union(_rentMarkers.values.toSet());
      rentVisibility = MarkersVisibility.Visible;
    } else{
      _markersOnMap = _markersOnMap.difference(_rentMarkers.values.toSet());
      rentVisibility = MarkersVisibility.Invisible;
    }
  }

  void _saleMarkersVisibility(bool visible) {
    if(visible) {
      _markersOnMap = _markersOnMap.union(_saleMarkers.values.toSet());
      saleVisibility = MarkersVisibility.Visible;
    } else{
      _markersOnMap = _markersOnMap.difference(_saleMarkers.values.toSet());
      saleVisibility = MarkersVisibility.Invisible;
    }
  }

  void _auctionMarkersVisibility(bool visible) {
    if(visible) {
      _markersOnMap = _markersOnMap.union(_auctionMarkers.values.toSet());
      auctionsVisibility = MarkersVisibility.Visible;
    } else{
      _markersOnMap = _markersOnMap.difference(_auctionMarkers.values.toSet());
      auctionsVisibility = MarkersVisibility.Invisible;
    }
  }
}
