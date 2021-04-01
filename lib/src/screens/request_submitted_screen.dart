import 'dart:ui';

import 'package:aeqarat/src/models/real_estate_response_model.dart';
import 'package:aeqarat/src/utils/app_theme.dart';
import 'package:aeqarat/src/widgets/screen_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestSubmittedScreen extends StatefulWidget {
  final Requests userRequest;

  RequestSubmittedScreen(this.userRequest);

  static Route<dynamic> route(Requests userRequest) => MaterialPageRoute(
        builder: (context) => RequestSubmittedScreen(userRequest),
      );

  @override
  _RequestSubmittedScreenState createState() => _RequestSubmittedScreenState();
}

class _RequestSubmittedScreenState extends State<RequestSubmittedScreen> {
  List<String> durations;
  List<String> paymentMethods;

  @override
  void didChangeDependencies() {
    durations = [
      AppLocalizations.of(context).threeMonths,
      AppLocalizations.of(context).sixMonths,
      AppLocalizations.of(context).twelveMonths
    ];
    paymentMethods = [
      AppLocalizations.of(context).creditCard,
      AppLocalizations.of(context).cash,
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          ScreenAppBar(
            screenTitle: widget.userRequest.realEstateStatus == 1
                ? AppLocalizations.of(context).requestRent
                : AppLocalizations.of(context).requestOwnership,
            implyLeading: true,
          )
        ],
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 16.0,
            ),
            const Divider(
              color: const Color(0xffE3E3E6),
              height: 2.0,
              thickness: 0.6,
              indent: 16.0,
              endIndent: 16.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                color: AppTheme.grey,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            widget.userRequest.amount,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            AppLocalizations.of(context).saudiCurrency,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        AppLocalizations.of(context).amount,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Container(
                    height: 64,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: Text(
                        widget.userRequest.requestStatus == 0
                            ? AppLocalizations.of(context).negotiating
                            : AppLocalizations.of(context).requestAccepted,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              color: const Color(0xffE3E3E6),
              height: 2.0,
              thickness: 0.7,
              indent: 16.0,
              endIndent: 16.0,
            ),
            ///////////////////////////////// Request Date
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/numbering.png",
                    height: 16.0,
                    width: 16.0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    AppLocalizations.of(context).requestDate,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.userRequest.requestDate,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ///////////////////////////////// Start Date
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/timing.png",
                    height: 16.0,
                    width: 16.0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    AppLocalizations.of(context).startDate,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.userRequest.startDate,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ///////////////////////////////// Insurance Amount
            widget.userRequest.realEstateStatus == 1 ?
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/wallet.png",
                    height: 16.0,
                    width: 16.0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    AppLocalizations.of(context).insuranceAmount,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    '( ',
                    style:
                        TextStyle(color: AppTheme.primaryColor, fontSize: 10),
                  ),
                  Text(
                    AppLocalizations.of(context).saudiCurrency,
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    ' )',
                    style:
                        TextStyle(color: AppTheme.primaryColor, fontSize: 10),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        widget.userRequest.insuranceAmount,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
            ) : Container(),
            ///////////////////////////////// Duration
            widget.userRequest.realEstateStatus == 1 ?
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/calendar.png",
                    height: 16.0,
                    width: 16.0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    AppLocalizations.of(context).duration,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    '( ',
                    style:
                        TextStyle(color: AppTheme.primaryColor, fontSize: 10),
                  ),
                  Text(
                    AppLocalizations.of(context).month,
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    ' )',
                    style:
                        TextStyle(color: AppTheme.primaryColor, fontSize: 10),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        durations[widget.userRequest.duration],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
            ) : Container(),
            ///////////////////////////////// Payment Method
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/area.png",
                    height: 16.0,
                    width: 16.0,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    AppLocalizations.of(context).paymentMethod,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        paymentMethods[widget.userRequest.paymentMethod],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 36,
            ),
            const Divider(
              color: const Color(0xffE3E3E6),
              height: 2.0,
              thickness: 0.7,
              indent: 16.0,
              endIndent: 16.0,
            ),
            Align(
              alignment: AppLocalizations.of(context).localeName == 'en'
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  AppLocalizations.of(context).documents,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Divider(
              color: const Color(0xffE3E3E6),
              height: 2.0,
              thickness: 0.7,
              indent: 16.0,
              endIndent: 16.0,
            ),
            SizedBox(
              height: 24,
            ),
            ///////////////////////////////// Tenancy Agreement
            Container(
              height: 48.0,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: ElevatedButton(
                  onPressed: () {},
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context).tenancyAgreement,
                          style: TextStyle(
                              color: AppTheme.primaryColor, fontSize: 12),
                        ),
                      ),
                      Align(
                        alignment:
                            AppLocalizations.of(context).localeName == 'en'
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Image.asset(
                          "assets/images/download.png",
                          height: 16.0,
                          width: 16.0,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                  )),
            ),
            ///////////////////////////////// ID
            Container(
              height: 48.0,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: ElevatedButton(
                  onPressed: () {},
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context).personal_id,
                          style: TextStyle(
                              color: AppTheme.primaryColor, fontSize: 12),
                        ),
                      ),
                      Align(
                        alignment:
                            AppLocalizations.of(context).localeName == 'en'
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Image.asset(
                          "assets/images/download.png",
                          height: 16.0,
                          width: 16.0,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
