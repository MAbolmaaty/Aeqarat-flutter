import 'package:aeqarat/src/utils/app_theme.dart';
import 'package:aeqarat/src/widgets/screen_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaintenanceRequestScreen extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => MaintenanceRequestScreen());

  @override
  _MaintenanceRequestScreenState createState() =>
      _MaintenanceRequestScreenState();
}

class _MaintenanceRequestScreenState extends State<MaintenanceRequestScreen> {
  String _maintenanceType;
  List<String> maintenanceTypes;

  @override
  void didChangeDependencies() {
    _maintenanceType = AppLocalizations.of(context).electricity;
    maintenanceTypes = [
      AppLocalizations.of(context).electricity,
      AppLocalizations.of(context).water,
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
            screenTitle: AppLocalizations.of(context).maintenanceRequest,
            implyLeading: true,
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewPortConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: viewPortConstraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    ///////////////////////////////// Maintenance Type
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
                                labelText: AppLocalizations.of(context).maintenanceType,
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
                                value: _maintenanceType,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _maintenanceType = newValue;
                                  });
                                },
                                underline: SizedBox(),
                                isExpanded: true,
                                items: <String>[
                                  AppLocalizations.of(context).electricity,
                                  AppLocalizations.of(context).water,
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
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                          child: Row(
                            children: <Widget>[
                              ////////////////////////////////// Save
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
                              //////////////////////////// cancel
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
