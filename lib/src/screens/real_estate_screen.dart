import 'package:aeqarat/src/models/real_estate_response_model.dart';
import 'package:aeqarat/src/screens/real_estate_description_screen.dart';
import 'package:aeqarat/src/screens/real_estate_details_screen.dart';
import 'package:aeqarat/src/screens/real_estate_reviews_screen.dart';
import 'package:aeqarat/src/utils/networking/real_estate_api.dart';
import 'package:aeqarat/src/widgets/persistent_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RealEstateScreen extends StatefulWidget {
  final String realEstateId;

  RealEstateScreen(this.realEstateId);

  static Route<dynamic> route(String realEstateId) =>
      MaterialPageRoute(builder: (context) => RealEstateScreen(realEstateId));

  @override
  _RealEstateScreenState createState() => _RealEstateScreenState(realEstateId);
}

class _RealEstateScreenState extends State<RealEstateScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  TabController _tabController;
  String realEstateId;
  String _realEstateTitle = "";

  String _realEstateDescription = "";
  String _realEstateStatus = "";
  String _realEstatePrice = "0";
  String _realEstateAddress = "";
  List<String> _realEstateImages = [];
  int mainImage = 0;

  _RealEstateScreenState(this.realEstateId);

  Future<Null> _realEstate() {
    return RealEstateApi().realEstate(realEstateId).then((result) {
      if (result['status']) {
        RealEstateResponseModel realEstateResponseModel = result['data'];
        setState(() {
          _realEstateTitle = realEstateResponseModel.title;
          _realEstateDescription = realEstateResponseModel.description;
          _realEstateStatus = realEstateResponseModel.status;
          _realEstatePrice = realEstateResponseModel.price;
          _realEstateAddress = realEstateResponseModel.address;
          for (var image in realEstateResponseModel.images) {
            _realEstateImages.add(image.url);
          }
        });
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    _tabController = TabController(vsync: this, length: 3, initialIndex: 1);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _realEstate,
        child: DefaultTabController(
          length: 3,
          child: Container(
            color: Colors.white,
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverPadding(
                      padding: EdgeInsets.all(0.0),
                      sliver: SliverAppBar(
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.chevron_left,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                        forceElevated: innerBoxIsScrolled,
                        ////////////////////////////////////// App Bar Labels
                        actions: <Widget>[
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    right: 12.0, left: 12.0, top: 4, bottom: 4),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
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
                                  margin:
                                      EdgeInsets.only(left: 8.0, right: 8.0),
                                  padding: EdgeInsets.only(
                                      right: 30.0,
                                      left: 30.0,
                                      top: 4,
                                      bottom: 4),
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: Text(
                                    _realEstateStatus,
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          ),
                        ],
                        ////////////////////////////////////////////// Bottom 360 and nav
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
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color:
                                                      const Color(0x709e9e9e),
                                                  offset: Offset(1, 2),
                                                  blurRadius: 5,
                                                  spreadRadius: 1),
                                              BoxShadow(
                                                  color:
                                                      const Color(0x709e9e9e),
                                                  offset: Offset(1, 2),
                                                  blurRadius: 5,
                                                  spreadRadius: 1),
                                              BoxShadow(
                                                  color:
                                                      const Color(0x709e9e9e),
                                                  offset: Offset(1, 2),
                                                  blurRadius: 5,
                                                  spreadRadius: 1),
                                            ]),
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
                                            shape: BoxShape.circle,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color:
                                                      const Color(0x709e9e9e),
                                                  offset: Offset(1, 2),
                                                  blurRadius: 5,
                                                  spreadRadius: 1),
                                              BoxShadow(
                                                  color:
                                                      const Color(0x709e9e9e),
                                                  offset: Offset(1, 2),
                                                  blurRadius: 5,
                                                  spreadRadius: 1),
                                              BoxShadow(
                                                  color:
                                                      const Color(0x709e9e9e),
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
                        expandedHeight: MediaQuery.of(context).size.height / 2,
                        ////////////////////////////////// Main Image
                        flexibleSpace: Stack(
                          children: <Widget>[
                            _realEstateImages.length > 0
                                ? Positioned.fill(
                                    child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: Image.network(
                                      _realEstateImages[mainImage],
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                                : Container(
                                    color: Colors.grey,
                                  ),
                            ////////////////////////////// Additional Icons
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: kToolbarHeight + 16.0, right: 16.0, left: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      'assets/images/exclamation.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    SizedBox(width: 8.0,),
                                    Image.asset(
                                      'assets/images/share.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    SizedBox(width: 8.0,),
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
                  /////////////////////////////////////////// More Images List
                  SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                      Container(
                        height: 100,
                        margin: EdgeInsets.only(top: 16.0),
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8.0),
                            itemCount: _realEstateImages.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    mainImage = index;
                                  });
                                },
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  margin:
                                      EdgeInsets.only(right: 8.0, left: 8.0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              _realEstateImages[index]),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                ),
                              );
                            }),
                      ),
                      ///////////////////////// Real Estate Info
                      Container(
                        margin: EdgeInsets.only(right: 16, left: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    children: [
                                      Text(
                                        _realEstatePrice,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .saudiCurrency,
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(_realEstateTitle),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(top: 2),
                                      child: Icon(
                                        Icons.location_on,
                                        color: Colors.grey,
                                        size: 16,
                                      )),
                                  Expanded(
                                    child: Text(
                                      _realEstateAddress,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ////////////////////////////// Request
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(
                            left: 20, right: 20, bottom: 10, top: 16),
                        decoration: BoxDecoration(
                            color: const Color(0xffFFDB27),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
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
                            controller: _tabController,
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
                controller: _tabController,
                children: <Widget>[
                  RealEstateDescriptionScreen(_realEstateDescription),
                  RealEstateDetailsScreen(),
                  RealEstateReviewsScreen(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
