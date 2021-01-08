import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController mapController;
  final LatLng _center = const LatLng(24.5538107, 46.0265294);
  String _mapStyle;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((jsonStyle) => {
          _mapStyle = jsonStyle,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 8.0,
            ),
            zoomControlsEnabled: false,
            compassEnabled: true,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin:
                      EdgeInsets.only(bottom: 20.0, right: 16.0, left: 16.0),
                  child: Row(
                    children: <Widget>[
                      _markersSelect(text: AppLocalizations.of(context).forRent),
                      _markersSelect(text: 'Sell'),
                      _markersSelect(text: 'Auction'),
                    ],
                  ))),
        ],
      ),
    );
  }

  Widget _markersSelect({String text}) {
    return Expanded(
        flex: 1,
        child: Container(
          height: 35,
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: const Color(0x709e9e9e),
                    offset: Offset(1, 2),
                    blurRadius: 5,
                    spreadRadius: 1),
              ],
              color: Colors.grey.withOpacity(0.5)),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(right: 12.0, left: 12.0),
                    child: Text(
                      text,
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ));
  }
}
