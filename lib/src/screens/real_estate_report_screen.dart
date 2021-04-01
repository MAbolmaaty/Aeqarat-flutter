import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RealEstateReportScreen extends StatefulWidget {
  @override
  _RealEstateReportScreenState createState() => _RealEstateReportScreenState();
}

class _RealEstateReportScreenState extends State<RealEstateReportScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16.0),
                topRight: const Radius.circular(16.0)),
            color: const Color(0xffF9FBFC)),
        child: Column(
          children: <Widget>[
            ///////////////////// Title
            Container(
                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context).rentInfo,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                    GestureDetector(
                        onTap: () => {
                          setState(() {
                            Navigator.pop(context);
                          })
                        },
                        child: Align(
                          child: Icon(
                            Icons.cancel,
                            size: 24.0,
                            color: const Color(0xffF60B0B),
                          ),
                          alignment:
                          AppLocalizations.of(context).localeName == 'en'
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
