import 'package:aeqarat/src/models/accounting_detail.dart';
import 'package:aeqarat/src/utils/app_theme.dart';
import 'package:aeqarat/src/widgets/screen_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:aeqarat/src/widgets/accounting_detail_dialog.dart';

class AccountingDetails extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => AccountingDetails(),
      );

  @override
  _AccountingDetailsState createState() => _AccountingDetailsState();
}

class _AccountingDetailsState extends State<AccountingDetails>
    with SingleTickerProviderStateMixin {
  DateTime _selectedFromDate;
  DateTime _selectedToDate;
  List<AccountingDetail> accountingDetails = [];
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    super.initState();
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
            screenTitle: AppLocalizations.of(context).accountingDetails,
            implyLeading: true,
          )
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
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
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: AppTheme.border,
                  width: 1.0,
                )),
            height: 48.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now())
                          .then((pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            _selectedFromDate = pickedDate;
                          });
                        }
                      });
                    },
                    child: Text(
                      _selectedFromDate == null
                          ? AppLocalizations.of(context).from
                          : ' ${DateFormat('yyyy/MM/dd').format(_selectedFromDate)}',
                      style: TextStyle(
                        color: _selectedFromDate == null
                            ? Colors.grey
                            : Colors.black,
                        fontSize: 14,
                      ),
                    )),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
                GestureDetector(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now())
                          .then((pickedDate) {
                        if (pickedDate != null) {
                          setState(() {
                            _selectedToDate = pickedDate;
                          });
                        }
                      });
                    },
                    child: Text(
                      _selectedToDate == null
                          ? AppLocalizations.of(context).to
                          : ' ${DateFormat('yyyy/MM/dd').format(_selectedToDate)}',
                      style: TextStyle(
                        color: _selectedToDate == null
                            ? Colors.grey
                            : Colors.black,
                        fontSize: 14,
                      ),
                    )),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 48.0,
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: AppTheme.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
              ),
              child: Text(
                AppLocalizations.of(context).search,
                style: TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 1,
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
          GestureDetector(
            onTap: () {
              showDialog(context: context, builder: (_) => AccountingDetailDialog());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
          ),
          const Divider(
            color: const Color(0xffE3E3E6),
            height: 2.0,
            thickness: 0.7,
            indent: 16.0,
            endIndent: 16.0,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 20,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).confirmed,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: const Color(0xffE3E3E6),
                  height: 2.0,
                  thickness: 0.7,
                  indent: 16.0,
                  endIndent: 16.0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
