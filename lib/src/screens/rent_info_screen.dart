import 'package:aeqarat/src/screens/terminate_contract_request_screen.dart';
import 'package:aeqarat/src/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RentInfoScreen extends StatefulWidget {
  @override
  _RentInfoScreenState createState() => _RentInfoScreenState();
}

class _RentInfoScreenState extends State<RentInfoScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    super.initState();
  }

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
            SizedBox(
              height: 16.0,
            ),
            TabBar(
                controller: _tabController,
                unselectedLabelColor: Colors.grey,
                labelColor: AppTheme.primaryColor,
                indicatorColor: AppTheme.primaryColor,
                tabs: [
                  Tab(text: AppLocalizations.of(context).currentRequests),
                  Tab(text: AppLocalizations.of(context).previousRequests)
                ]),
            Container(
              height: MediaQuery.of(context).size.height * 0.70,
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 32,
                                backgroundImage:
                                    AssetImage("assets/images/john-smith.jpg"),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('John Smith'),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Text('Request Type'),
                                ],
                              )
                            ],
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
                      itemCount: 4),
                  ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 32,
                                backgroundImage:
                                    AssetImage("assets/images/john-smith.jpg"),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('John Smith'),
                                  SizedBox(
                                    height: 2.0,
                                  ),
                                  Text('Request Type'),
                                ],
                              )
                            ],
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
                      itemCount: 4),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 3,
                      child: Container(
                          height: 48.0,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(TerminateContractRequestScreen.route());
                              },
                              style: ElevatedButton.styleFrom(
                                primary: AppTheme.primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                              ),
                              child: Text(
                                AppLocalizations.of(context)
                                    .terminateTheContract,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black),
                              )))),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                          height: 48.0,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: AppTheme.primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                              ),
                              child: Text(
                                AppLocalizations.of(context).maintenanceRequest,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                ),
                              ))))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
