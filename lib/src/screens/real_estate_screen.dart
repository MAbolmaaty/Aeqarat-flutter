import 'package:aeqarat/src/screens/real_estate_description_screen.dart';
import 'package:aeqarat/src/screens/real_estate_details_screen.dart';
import 'package:aeqarat/src/screens/real_estate_reviews_screen.dart';
import 'package:aeqarat/src/widgets/persistent_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RealEstateScreen extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (context) => RealEstateScreen());

  @override
  _RealEstateScreenState createState() => _RealEstateScreenState();
}

class _RealEstateScreenState extends State<RealEstateScreen>
    with SingleTickerProviderStateMixin {
  //TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(
    //   length: 3,
    //   vsync: this,
    // );
  }

  @override
  void dispose() {
    //_tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverPadding(
                  padding: EdgeInsets.all(0.0),
                  sliver: SliverAppBar(
                    leading: Icon(
                      Icons.chevron_left,
                      size: 35,
                      color: Colors.white,
                    ),
                    forceElevated: innerBoxIsScrolled,
                    actions: <Widget>[
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                right: 12.0, left: 12.0, top: 4, bottom: 4),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                            child: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFFFDB27),
                                        shape: BoxShape.circle),
                                    child: Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(
                                        Icons.check,
                                        size: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    AppLocalizations.of(context).byAeqarat,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ]),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 8.0, right: 8.0),
                              padding: EdgeInsets.only(
                                  right: 30.0, left: 30.0, top: 4, bottom: 4),
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.2),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                              child: Text(
                                AppLocalizations.of(context).sale,
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                    ],
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(0.0),
                      child: Expanded(
                        child: Transform.translate(
                          offset: const Offset(0, 30.0),
                          child: Container(
                            margin: EdgeInsets.all(16.0),
                            child: Stack(children: <Widget>[
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    padding: EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: <BoxShadow>[BoxShadow(
                                            color: const Color(0x709e9e9e),
                                            offset: Offset(1, 2),
                                            blurRadius: 5,
                                            spreadRadius: 1),
                                          BoxShadow(
                                              color: const Color(0x709e9e9e),
                                              offset: Offset(1, 2),
                                              blurRadius: 5,
                                              spreadRadius: 1),
                                          BoxShadow(
                                              color: const Color(0x709e9e9e),
                                              offset: Offset(1, 2),
                                              blurRadius: 5,
                                              spreadRadius: 1),]),
                                    child: Image.asset(
                                      'assets/images/360.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                  )),
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    padding: EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle, boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: const Color(0x709e9e9e),
                                          offset: Offset(1, 2),
                                          blurRadius: 5,
                                          spreadRadius: 1),
                                      BoxShadow(
                                          color: const Color(0x709e9e9e),
                                          offset: Offset(1, 2),
                                          blurRadius: 5,
                                          spreadRadius: 1),
                                      BoxShadow(
                                          color: const Color(0x709e9e9e),
                                          offset: Offset(1, 2),
                                          blurRadius: 5,
                                          spreadRadius: 1),
                                    ]),
                                    child: Image.asset(
                                      'assets/images/navigation.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                  )),
                            ]),
                          ),
                        ),
                      ),
                    ),
                    pinned: true,
                    floating: true,
                    //toolbarHeight: MediaQuery.of(context).size.height / 7,
                    expandedHeight: MediaQuery.of(context).size.height / 2,
                    flexibleSpace: Stack(
                      children: <Widget>[
                        Positioned.fill(
                            child: Image.asset(
                              'assets/images/apartment.jpg',
                              fit: BoxFit.cover,
                            )),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 85.0, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset(
                                  'assets/images/exclamation.png',
                                  height: 40,
                                  width: 40,
                                ),
                                Image.asset(
                                  'assets/images/share.png',
                                  height: 40,
                                  width: 40,
                                ),
                                Image.asset(
                                  'assets/images/bookmark.png',
                                  height: 40,
                                  width: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  Container(
                    height: 100,
                    margin: EdgeInsets.only(top: 16.0),
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
                                      image: AssetImage(
                                          'assets/images/apartment.jpg'),
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
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xffFFDB27),
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/request.png',
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            'Rent Request',
                            style: TextStyle(fontSize: 14),
                          ),
                        ]),
                  )
                ]),
              ),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: PersistentHeader(
                      widget: Column(children: [
                        Material(
                          color: Colors.white,
                          elevation: 2.0,
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
                        )
                      ])))
            ];
          },
          body: TabBarView(
            children: <Widget>[
              RealEstateDescriptionScreen(),
              RealEstateDetailsScreen(),
              RealEstateReviewsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
