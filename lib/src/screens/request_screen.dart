import 'package:aeqarat/src/models/profile_response_model.dart';
import 'package:aeqarat/src/models/real_estate_response_model.dart';
import 'package:aeqarat/src/screens/bottom_nav_screen.dart';
import 'package:aeqarat/src/utils/app_theme.dart';
import 'package:aeqarat/src/utils/networking/real_estate_update_api.dart';
import 'package:aeqarat/src/widgets/screen_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RequestScreen extends StatefulWidget {
  final RealEstateResponseModel realEstate;
  final String apiToken;
  final ProfileResponseModel userProfile;

  RequestScreen(this.realEstate, this.apiToken, this.userProfile);

  static Route<dynamic> route(RealEstateResponseModel realEstate,
          String apiToken, ProfileResponseModel userProfile) =>
      MaterialPageRoute(
        builder: (context) => RequestScreen(realEstate, apiToken, userProfile),
      );

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final formKey = GlobalKey<FormState>();
  final sKey = GlobalKey<ScaffoldState>();
  String startDate = DateTime.now().day.toString() +
      "/" +
      DateTime.now().month.toString() +
      "/" +
      DateTime.now().year.toString();
  String requestDate = DateTime.now().day.toString() +
      "/" +
      DateTime.now().month.toString() +
      "/" +
      DateTime.now().year.toString();
  TextEditingController _controllerStartDate;
  String _duration;
  String _paymentMethod;
  List<String> durations;
  List<String> paymentMethods;

  @override
  void initState() {
    _controllerStartDate = TextEditingController(text: startDate);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _duration = AppLocalizations.of(context).threeMonths;
    _paymentMethod = AppLocalizations.of(context).creditCard;
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
    return ChangeNotifierProvider(
      create: (context) => RealEstateUpdateApi(),
      child: Scaffold(
        key: sKey,
        backgroundColor: AppTheme.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.8,
          actions: [
            ScreenAppBar(
              screenTitle: widget.realEstate.status == 'rent'
                  ? AppLocalizations.of(context).requestRent
                  : AppLocalizations.of(context).requestOwnership,
              implyLeading: true,
            )
          ],
        ),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewPortConstraints) {
          return SingleChildScrollView(
            child: Form(
              key: formKey,
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewPortConstraints.maxHeight),
                child: IntrinsicHeight(
                  child: Container(
                    color: const Color(0xffF9FBFC),
                    margin: EdgeInsets.only(top: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ///////////////////////////////// Amount
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              TextFormField(
                                maxLines: 1,
                                enabled: false,
                                initialValue: widget.realEstate.price,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 11,
                                        bottom: 11,
                                        left: 16,
                                        right: 16),
                                    labelText:
                                        AppLocalizations.of(context).amount,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 2.0,
                                      fontSize: 12,
                                    ),
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                            color: const Color(0xffE3E3E6))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                            color: const Color(0xffE3E3E6))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                            color: const Color(0xffE3E3E6))),
                                    isDense: true),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: 16.0, left: 16.0),
                                  child: Text(AppLocalizations.of(context)
                                      .currencyPerMonth),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ///////////////////////////////// Insurance Amount
                        Visibility(
                          visible: widget.realEstate.status == 'rent',
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                TextFormField(
                                  maxLines: 1,
                                  enabled: false,
                                  initialValue:
                                      widget.realEstate.insuranceAmount,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 11,
                                          bottom: 11,
                                          left: 16,
                                          right: 16),
                                      labelText: AppLocalizations.of(context)
                                          .insuranceAmount,
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                        letterSpacing: 2.0,
                                        fontSize: 12,
                                      ),
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                              color: const Color(0xffE3E3E6))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                              color: const Color(0xffE3E3E6))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                              color: const Color(0xffE3E3E6))),
                                      isDense: true),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: 16.0, left: 16.0),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .saudiCurrency,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        ///////////////////////////////// Start Date
                        GestureDetector(
                          onTap: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime.now(), onConfirm: (date) {
                              setState(() {
                                startDate = date.day.toString() +
                                    "/" +
                                    date.month.toString() +
                                    "/" +
                                    date.year.toString();
                                _controllerStartDate =
                                    TextEditingController(text: startDate);
                              });
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                TextFormField(
                                  maxLines: 1,
                                  enabled: false,
                                  controller: _controllerStartDate,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 11,
                                          bottom: 11,
                                          left: 16,
                                          right: 16),
                                      labelText: AppLocalizations.of(context)
                                          .startDate,
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                        letterSpacing: 2.0,
                                        fontSize: 12,
                                      ),
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                              color: const Color(0xffE3E3E6))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                              color: const Color(0xffE3E3E6))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                              color: const Color(0xffE3E3E6))),
                                      isDense: true),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: 16.0, left: 16.0),
                                    child: Image.asset(
                                      "assets/images/calendar.png",
                                      height: 16.0,
                                      width: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ///////////////////////////////// Duration
                        Visibility(
                          visible: widget.realEstate.status == 'rent',
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 16.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                TextFormField(
                                  maxLines: 1,
                                  enabled: false,
                                  initialValue: " ",
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 11,
                                          bottom: 11,
                                          left: 16,
                                          right: 16),
                                      labelText:
                                          AppLocalizations.of(context).duration,
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                        letterSpacing: 2.0,
                                        fontSize: 12,
                                      ),
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                              color: const Color(0xffE3E3E6))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                              color: const Color(0xffE3E3E6))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                              color: const Color(0xffE3E3E6))),
                                      isDense: true),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: 16.0, left: 16.0),
                                    child: DropdownButton<String>(
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      value: _duration,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          _duration = newValue;
                                        });
                                      },
                                      underline: SizedBox(),
                                      isExpanded: true,
                                      items: <String>[
                                        AppLocalizations.of(context)
                                            .threeMonths,
                                        AppLocalizations.of(context).sixMonths,
                                        AppLocalizations.of(context)
                                            .twelveMonths,
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ///////////////////////////////// Payment Methods
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              TextFormField(
                                maxLines: 1,
                                enabled: false,
                                initialValue: " ",
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 11,
                                        bottom: 11,
                                        left: 16,
                                        right: 16),
                                    labelText: AppLocalizations.of(context)
                                        .paymentMethod,
                                    labelStyle: TextStyle(
                                      letterSpacing: 2.0,
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                            color: const Color(0xffE3E3E6))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                            color: const Color(0xffE3E3E6))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                            color: const Color(0xffE3E3E6))),
                                    isDense: true),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: 16.0, left: 16.0),
                                  child: DropdownButton<String>(
                                    icon: Icon(Icons.keyboard_arrow_down),
                                    value: _paymentMethod,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _paymentMethod = newValue;
                                      });
                                    },
                                    underline: SizedBox(),
                                    isExpanded: true,
                                    items: <String>[
                                      AppLocalizations.of(context).creditCard,
                                      AppLocalizations.of(context).cash,
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                          value: value, child: Text(value));
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.all(24.0),
                              child: Row(
                                children: <Widget>[
                                  ////////////////////////////////// Save
                                  Expanded(
                                    flex: 2,
                                    child: Consumer<RealEstateUpdateApi>(
                                        builder: (context, realEstateUpdateApi,
                                            child) {
                                      return Container(
                                          height: 48.0,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: AppTheme.primaryColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0)),
                                            ),
                                            onPressed: () {
                                              realEstateUpdateApi
                                                  .updateRealEstate(
                                                widget.apiToken,
                                                widget.realEstate.sId,
                                                widget.userProfile,
                                                widget.realEstate,
                                                startDate,
                                                requestDate,
                                                durations.indexOf(_duration),
                                                paymentMethods
                                                    .indexOf(_paymentMethod),
                                              )
                                                  .then((result) {
                                                if (result['status']) {
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          BottomNavScreen.route(
                                                              currentIndex: 2,
                                                              realEstateId:
                                                                  widget
                                                                      .realEstate
                                                                      .sId),
                                                          (route) => false);
                                                }
                                              });
                                            },
                                            child: realEstateUpdateApi
                                                        .loadingStatus ==
                                                    RealEstateUpdateLoading
                                                        .Loading
                                                ? _loading()
                                                : Text(
                                                    AppLocalizations.of(context)
                                                        .save,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.0),
                                                  ),
                                          ));
                                    }),
                                  ),
                                  SizedBox(
                                    width: 16.0,
                                  ),
                                  /////////////////////////// Cancel
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 48.0,
                                      child: RaisedButton(
                                        color: const Color(0xffECECEC),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16.0)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          AppLocalizations.of(context).cancel,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _loading() {
    return Center(
      child: SizedBox(
        child: CircularProgressIndicator(
            backgroundColor: const Color(0xffFFDB27),
            strokeWidth: 2,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.black)),
        height: 20,
        width: 20,
      ),
    );
  }
}
