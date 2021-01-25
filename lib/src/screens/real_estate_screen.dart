import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:aeqarat/src/screens/real_estate_description_screen.dart';
import 'package:aeqarat/src/screens/real_estate_details_screen.dart';
import 'package:aeqarat/src/screens/real_estate_reviews_screen.dart';

class RealEstateScreen extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => RealEstateScreen());

  @override
  _RealEstateScreenState createState() =>
      _RealEstateScreenState();
}

class _RealEstateScreenState extends State<RealEstateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            leading: Icon(
              Icons.chevron_left,
              size: 35,
              color: Colors.white,
            ),
            expandedHeight: MediaQuery.of(context).size.height / 2,
            flexibleSpace: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Image.asset(
                  'assets/images/apartment.jpg',
                  fit: BoxFit.cover,
                ))
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Container(
                height: 100,
                child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(right: 8.0, left: 8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/apartment.jpg'),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                        ),
                      );
                    }),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 8.0,
                ),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              '230,456',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 4.0, right: 4.0, top: 8.0),
                              child: Text(
                                'SAR',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 11,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: Text(
                          'Address Details',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Real Estate name'),
              ),
              DefaultTabController(
                length: 3,
                child: Column(
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(maxHeight: 150.0),
                      child: Material(
                        color: Colors.white,
                        child: TabBar(
                          unselectedLabelColor: Colors.grey,
                          labelColor: const Color(0xFFFFDB27),
                          indicatorColor: const Color(0xFFFFDB27),
                          tabs: [
                            Tab(
                              text: AppLocalizations.of(context).description,
                            ),
                            Tab(
                              text: AppLocalizations.of(context).details,
                            ),
                            Tab(
                              text: AppLocalizations.of(context).reviews,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.50,
                      child: TabBarView(
                        children: <Widget>[
                          RealEstateDescriptionScreen(),
                          RealEstateDetailsScreen(),
                          RealEstateReviewsScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
