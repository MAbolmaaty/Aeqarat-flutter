import 'package:aeqarat/src/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountingDetailDialog extends StatefulWidget {
  @override
  _AccountingDetailDialogState createState() => _AccountingDetailDialogState();
}

class _AccountingDetailDialogState extends State<AccountingDetailDialog>
    with SingleTickerProviderStateMixin {
  String _websiteName;
  String _websiteURL;
  String _checkingTime;
  int _hours = 10;
  int _minutes = 10;
  final formKey = new GlobalKey<FormState>();

  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(15.0),
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Stack(children: <Widget>[
                    ///////////////////////////////////// Title
                    Align(
                      child: Text(
                        AppLocalizations.of(context).accountingDetails,
                        style: TextStyle(
                          color: const Color(0xff212121),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                    //////////////////// Cancel
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
                  ]),
                  SizedBox(
                    height: 16.0,
                  ),
                  const Divider(
                    color: const Color(0xffE3E3E6),
                    height: 2.0,
                    thickness: 0.7,
                    indent: 16.0,
                    endIndent: 16.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
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
                                  "220",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Text(
                                  AppLocalizations.of(context).saudiCurrency,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              "12-03-2019",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: AppTheme.primaryColor,
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).confirm,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
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
                  ////////////////////////////// Revenues
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/revenues.png",
                          height: 42.0,
                          width: 42.0,
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              '623',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              AppLocalizations.of(context).saudiCurrency,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  AppLocalizations.of(context).revenues,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ))),
                      ],
                    ),
                  ),
                  /////////////////////////// Expenses
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/expenses.png",
                          height: 42.0,
                          width: 42.0,
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              '623',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              AppLocalizations.of(context).saudiCurrency,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  AppLocalizations.of(context).expenses,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ))),
                      ],
                    ),
                  ),
                  /////////////////////////////// Profits
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/profits.png",
                          height: 42.0,
                          width: 42.0,
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              '623',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              AppLocalizations.of(context).saudiCurrency,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  AppLocalizations.of(context).profits,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ))),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
