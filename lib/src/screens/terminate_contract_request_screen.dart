import 'package:aeqarat/src/utils/app_theme.dart';
import 'package:aeqarat/src/widgets/screen_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class TerminateContractRequestScreen extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => TerminateContractRequestScreen());

  @override
  _TerminateContractRequestScreenState createState() =>
      _TerminateContractRequestScreenState();
}

class _TerminateContractRequestScreenState
    extends State<TerminateContractRequestScreen> {
  List<String> _locations = ['كاش', 'فيزا'];

  String startDate = "20/20/2020";
  String exitDate = DateTime.now().day.toString() +
      "/" +
      DateTime.now().month.toString() +
      "/" +
      DateTime.now().year.toString();
  String insuranceAmount = "234";
  TextEditingController _controllerStartDate;
  TextEditingController _controllerExitDate;
  TextEditingController _controllerInsuranceAmount;
  String _paymentMethod;
  List<String> paymentMethods;

  @override
  void initState() {
    _controllerStartDate = TextEditingController(text: startDate);
    _controllerExitDate = TextEditingController(text: exitDate);
    _controllerInsuranceAmount = TextEditingController(text: insuranceAmount);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _paymentMethod = AppLocalizations.of(context).creditCard;
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
        automaticallyImplyLeading: false,
        elevation: 0.0,
        actions: [
          ScreenAppBar(
            screenTitle: AppLocalizations.of(context).terminateTheContract,
            implyLeading: true,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
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
            SizedBox(
              height: 16.0,
            ),
            ////////////////////////////// Start Date
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0)),
              child: TextFormField(
                maxLines: 1,
                enabled: false,
                controller: _controllerStartDate,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        top: 11, bottom: 11, left: 16, right: 16),
                    labelText: AppLocalizations.of(context).startDate,
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      letterSpacing: 2.0,
                      fontSize: 12,
                    ),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: const Color(0xffE3E3E6))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: const Color(0xffE3E3E6))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: const Color(0xffE3E3E6))),
                    isDense: true),
              ),
            ),
            ///////////////////////////////// Exit Date
            GestureDetector(
              onTap: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 2))
                    .then((pickedDate) {
                  if (pickedDate != null) {
                    setState(() {
                      exitDate = DateFormat('yyyy/MM/dd').format(pickedDate);
                      _controllerExitDate =
                          TextEditingController(text: exitDate);
                    });
                  }
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    TextFormField(
                      maxLines: 1,
                      enabled: false,
                      controller: _controllerExitDate,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: 11, bottom: 11, left: 16, right: 16),
                          labelText: AppLocalizations.of(context).exitDate,
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 2.0,
                            fontSize: 12,
                          ),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide:
                                  BorderSide(color: const Color(0xffE3E3E6))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide:
                                  BorderSide(color: const Color(0xffE3E3E6))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide:
                                  BorderSide(color: const Color(0xffE3E3E6))),
                          isDense: true),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(right: 16.0, left: 16.0),
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
            ///////////////////////////////// Insurance Amount
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0)),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  TextFormField(
                    maxLines: 1,
                    enabled: false,
                    controller: _controllerInsuranceAmount,
                    style: TextStyle(fontSize: 14.0),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: 11, bottom: 11, left: 16, right: 16),
                        labelText: AppLocalizations.of(context).insuranceAmount,
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 2.0,
                          fontSize: 12,
                        ),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide:
                                BorderSide(color: const Color(0xffE3E3E6))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide:
                                BorderSide(color: const Color(0xffE3E3E6))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide:
                                BorderSide(color: const Color(0xffE3E3E6))),
                        isDense: true),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 16.0, left: 16.0),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text("(", style: TextStyle(fontSize: 13.0)),
                          Text(
                            AppLocalizations.of(context).saudiCurrency,
                            style: TextStyle(fontSize: 10.0),
                          ),
                          Text(")", style: TextStyle(fontSize: 13.0)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            ///////////////////////////////// Payment Methods
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0)),
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
                        labelText: AppLocalizations.of(context).paymentMethod,
                        labelStyle: TextStyle(
                          letterSpacing: 2.0,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide:
                                BorderSide(color: const Color(0xffE3E3E6))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide:
                                BorderSide(color: const Color(0xffE3E3E6))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide:
                                BorderSide(color: const Color(0xffE3E3E6))),
                        isDense: true),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(right: 16.0, left: 16.0),
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
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 14.0),
                              ));
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //////////////////////////// More Info
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.0)),
              child: TextFormField(
                style: TextStyle(fontSize: 14.0),
                maxLines: 8,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        top: 11, bottom: 11, left: 16, right: 16),
                    labelText: AppLocalizations.of(context).anotherNotes,
                    labelStyle: TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: const Color(0xffE3E3E6))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: const Color(0xffE3E3E6))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: const Color(0xffE3E3E6))),
                    isDense: true),
              ),
            ),
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
            SizedBox(
              height: 16.0,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 3,
                      child: Container(
                        height: 48.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppTheme.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                          ),
                          onPressed: () {},
                          child: Text(
                            AppLocalizations.of(context).save,
                            style: TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                        ),
                      )),
                  SizedBox(width: 16.0,),
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: 48.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppTheme.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            AppLocalizations.of(context).cancel,
                            style: TextStyle(fontSize: 14.0, color: Colors.black),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
