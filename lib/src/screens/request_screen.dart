import 'package:aeqarat/src/models/real_estate_response_model.dart';
import 'package:aeqarat/src/widgets/screen_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestScreen extends StatefulWidget {
  final RealEstateResponseModel realEstate;

  RequestScreen(this.realEstate);

  static Route<dynamic> route(RealEstateResponseModel realEstate) =>
      MaterialPageRoute(
        builder: (context) => RequestScreen(realEstate),
      );

  @override
  _RequestScreenState createState() => _RequestScreenState(realEstate);
}

class _RequestScreenState extends State<RequestScreen> {
  final formKey = GlobalKey<FormState>();
  final sKey = GlobalKey<ScaffoldState>();
  String startDate = DateTime.now().day.toString() +
      "/" +
      DateTime.now().month.toString() +
      "/" +
      DateTime.now().year.toString();
  TextEditingController _controllerStartDate;
  String _duration;
  String _paymentMethod;
  RealEstateResponseModel _realEstate;

  _RequestScreenState(this._realEstate);

  @override
  void initState() {
    _controllerStartDate = TextEditingController(text: startDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_duration == null) {
      _duration = AppLocalizations.of(context).threeMonths;
    }
    if (_paymentMethod == null) {
      _paymentMethod = AppLocalizations.of(context).creditCard;
    }
    return Scaffold(
      key: sKey,
      backgroundColor: const Color(0xffF9FBFC),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.8,
        actions: [
          ScreenAppBar(
            screenTitle: _realEstate.status == 'rent'
                ? AppLocalizations.of(context).requestRent
                : AppLocalizations.of(context).requestOwnership,
            implyLeading: true,
          )
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewPortConstraints) {
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
                              initialValue: _realEstate.price,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      top: 11, bottom: 11, left: 16, right: 16),
                                  labelText:
                                      AppLocalizations.of(context).amount,
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    letterSpacing: 2.0,
                                    fontSize: 12,
                                  ),
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: const Color(0xffE3E3E6))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: const Color(0xffE3E3E6))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
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
                        visible: _realEstate.status == 'rent',
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
                                initialValue: _realEstate.insuranceAmount,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        top: 11, bottom: 11, left: 16, right: 16),
                                    labelText: AppLocalizations.of(context)
                                        .insuranceAmount,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 2.0,
                                      fontSize: 12,
                                    ),
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                            color: const Color(0xffE3E3E6))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                            color: const Color(0xffE3E3E6))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                            color: const Color(0xffE3E3E6))),
                                    isDense: true),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: 16.0, left: 16.0),
                                  child: Text(
                                    AppLocalizations.of(context).saudiCurrency,
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
                                    labelText:
                                        AppLocalizations.of(context).startDate,
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
                                  child: Icon(Icons.calendar_today),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ///////////////////////////////// Duration
                      Visibility(
                        visible: _realEstate.status == 'rent',
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
                                        top: 11, bottom: 11, left: 16, right: 16),
                                    labelText:
                                        AppLocalizations.of(context).duration,
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 2.0,
                                      fontSize: 12,
                                    ),
                                    alignLabelWithHint: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                            color: const Color(0xffE3E3E6))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                        borderSide: BorderSide(
                                            color: const Color(0xffE3E3E6))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25.0),
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
                                    value: _duration,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _duration = newValue;
                                      });
                                    },
                                    underline: SizedBox(),
                                    isExpanded: true,
                                    items: <String>[
                                      AppLocalizations.of(context).threeMonths,
                                      AppLocalizations.of(context).sixMonths,
                                      AppLocalizations.of(context).twelveMonths,
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
                                      top: 11, bottom: 11, left: 16, right: 16),
                                  labelText: AppLocalizations.of(context)
                                      .paymentMethod,
                                  labelStyle: TextStyle(
                                    letterSpacing: 2.0,
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: const Color(0xffE3E3E6))),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: const Color(0xffE3E3E6))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
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
                                  child: Container(
                                    height: 48.0,
                                    child: RaisedButton(
                                      color: const Color(0xffFFDB27),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16.0)),
                                      onPressed: () {},
                                      child: Text(
                                        AppLocalizations.of(context).save,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
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
    );
  }
}
