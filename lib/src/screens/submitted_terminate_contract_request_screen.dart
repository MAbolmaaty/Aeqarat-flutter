import 'package:aeqarat/src/utils/app_theme.dart';
import 'package:aeqarat/src/widgets/screen_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubmittedTerminateContractRequestScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
      builder: (context) => SubmittedTerminateContractRequestScreen());

  @override
  _SubmittedTerminateContractRequestScreenState createState() =>
      _SubmittedTerminateContractRequestScreenState();
}

class _SubmittedTerminateContractRequestScreenState
    extends State<SubmittedTerminateContractRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          actions: [
            ScreenAppBar(
              screenTitle: AppLocalizations.of(context).terminateTheContract,
              implyLeading: true,
            )
          ],
        ),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewPortConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
              BoxConstraints(minHeight: viewPortConstraints.maxHeight),
              child: IntrinsicHeight(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "220",
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
                              ///////////////////////////// Insurance Amount
                              Text(
                                AppLocalizations.of(context).insuranceAmount,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
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
                              color: const Color(0xFFCCCCCC),
                            ),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context).negotiating,
                                style: TextStyle(
                                    color: Colors.black,
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
                      thickness: 0.6,
                      indent: 16.0,
                      endIndent: 16.0,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    ///////////////////////////////// Request Date
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                                '20/20/2020',
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                                "20/20/2020",
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
                    ///////////////////////////////// Exit Date
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                            AppLocalizations.of(context).exitDate,
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
                                "20/20/2020",
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
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                            style: TextStyle(
                                color: AppTheme.primaryColor, fontSize: 10),
                          ),
                          Text(
                            AppLocalizations.of(context).saudiCurrency,
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            ' )',
                            style: TextStyle(
                                color: AppTheme.primaryColor, fontSize: 10),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "313458",
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
                    ///////////////////////////////// Payment Method
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                                "Visa",
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
                      height: 16.0,
                    ),
                    const Divider(
                      color: const Color(0xffE3E3E6),
                      height: 2.0,
                      thickness: 0.6,
                      indent: 16.0,
                      endIndent: 16.0,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            child: Text(
                              AppLocalizations.of(context).anotherNotes,
                              style: TextStyle(fontSize: 14.0),
                            ))),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 24.0),
                            child: Text(
                              "User Added Notes",
                              style: TextStyle(fontSize: 12.0, color: Colors.grey),
                            ))),
                    SizedBox(
                      height: 16.0,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: const Divider(
                          color: const Color(0xffE3E3E6),
                          height: 2.0,
                          thickness: 0.6,
                          indent: 16.0,
                          endIndent: 16.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 48.0,
                          width: MediaQuery.of(context).size.width,
                          margin:
                              EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppTheme.primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                            ),
                            onPressed: () {},
                            child: Text(
                              AppLocalizations.of(context).modifyRequest,
                              style: TextStyle(fontSize: 14.0, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
