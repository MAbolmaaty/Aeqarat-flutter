import 'package:aeqarat/src/models/profile_response_model.dart';
import 'package:aeqarat/src/models/real_estate_response_model.dart';
import 'package:aeqarat/src/screens/accounting_details.dart';
import 'package:aeqarat/src/screens/real_estate_description_screen.dart';
import 'package:aeqarat/src/screens/real_estate_details_screen.dart';
import 'package:aeqarat/src/screens/real_estate_reviews_screen.dart';
import 'package:aeqarat/src/screens/rent_info_screen.dart';
import 'package:aeqarat/src/screens/request_screen.dart';
import 'package:aeqarat/src/screens/request_submitted_screen.dart';
import 'package:aeqarat/src/utils/app_theme.dart';
import 'package:aeqarat/src/utils/networking/real_estate_api.dart';
import 'package:aeqarat/src/utils/preferences/user_preferences.dart';
import 'package:aeqarat/src/widgets/login_dialog.dart';
import 'package:aeqarat/src/widgets/persistent_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String apiToken;
  int mainImage = 0;
  bool alreadyRequested = false;
  bool realEstateOwner = false;
  Requests userRequest;
  ProfileResponseModel userProfile;
  final RealEstateApi realEstateApi = RealEstateApi();

  _RealEstateScreenState(this.realEstateId);

  Future<Null> _realEstate() {
    return realEstateApi.loadRealEstate(realEstateId).then((result) async {
      if (result['status']) {
        RealEstateResponseModel realEstateResponseModel = result['data'];
        await UserPreferences().getUser().then((user) async {
          if (user.sId != null) {
            userProfile = user;
            await SharedPreferences.getInstance().then((instance) {
              String userId = instance.getString('user_id');
              if (realEstateResponseModel.ownerId == userId) {
                realEstateOwner = true;
              } else {
                for (Requests request in realEstateResponseModel.requests) {
                  if (request.userId == userId) {
                    alreadyRequested = true;
                    userRequest = request;
                  }
                }
              }
              setState(() {
                apiToken = instance.getString('api_token');
              });
            });
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
    return ChangeNotifierProvider(
      create: (context) => realEstateApi,
      child: Scaffold(
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _realEstate,
          child:
              Consumer<RealEstateApi>(builder: (context, realEstateApi, child) {
            return DefaultTabController(
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
                          ///////////////////////////////// App Bar
                          sliver: SliverAppBar(
                            toolbarHeight:
                                MediaQuery.of(context).size.width / 2,
                            leadingWidth: 0,
                            leading: Container(),
                            forceElevated: innerBoxIsScrolled,
                            ////////////////////////////////////// App Bar Labels
                            actions: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(top: 16),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(
                                                Icons.chevron_left,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 12.0,
                                                      left: 12.0,
                                                      top: 4,
                                                      bottom: 4),
                                                  decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                                  child: Wrap(
                                                      crossAxisAlignment:
                                                          WrapCrossAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xFFFFDB27),
                                                              shape: BoxShape
                                                                  .circle),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.0),
                                                            child: Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8.0,
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .byAeqarat,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ]),
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 8.0, right: 8.0),
                                                    padding: EdgeInsets.only(
                                                        right: 30.0,
                                                        left: 30.0,
                                                        top: 4,
                                                        bottom: 4),
                                                    decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20.0))),
                                                    child: Text(
                                                      realEstateApi
                                                                  .loadingStatus ==
                                                              RealEstateLoading
                                                                  .Succeed
                                                          ? realEstateApi
                                                              .realEstate.status
                                                          : "",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              'assets/images/exclamation.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Image.asset(
                                              'assets/images/share.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                            SizedBox(
                                              width: 8.0,
                                            ),
                                            Image.asset(
                                              'assets/images/bookmark.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
                                                      color: const Color(
                                                          0x709e9e9e),
                                                      offset: Offset(1, 2),
                                                      blurRadius: 5,
                                                      spreadRadius: 1),
                                                  BoxShadow(
                                                      color: const Color(
                                                          0x709e9e9e),
                                                      offset: Offset(1, 2),
                                                      blurRadius: 5,
                                                      spreadRadius: 1),
                                                  BoxShadow(
                                                      color: const Color(
                                                          0x709e9e9e),
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
                                                      color: const Color(
                                                          0x709e9e9e),
                                                      offset: Offset(1, 2),
                                                      blurRadius: 5,
                                                      spreadRadius: 1),
                                                  BoxShadow(
                                                      color: const Color(
                                                          0x709e9e9e),
                                                      offset: Offset(1, 2),
                                                      blurRadius: 5,
                                                      spreadRadius: 1),
                                                  BoxShadow(
                                                      color: const Color(
                                                          0x709e9e9e),
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
                            expandedHeight:
                                MediaQuery.of(context).size.height / 2,
                            ////////////////////////////////// Main Image
                            flexibleSpace: Stack(
                              children: <Widget>[
                                realEstateApi.loadingStatus ==
                                        RealEstateLoading.Succeed
                                    ? Positioned.fill(
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child:
                                                // Image.network(
                                                //   _realEstateImages[mainImage],
                                                //   fit: BoxFit.cover,
                                                // ),
                                                FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/images/placeholder.png',
                                              image: realEstateApi.realEstate
                                                  .images[mainImage].url,
                                              fit: BoxFit.cover,
                                            )))
                                    : Container(
                                        color: Colors.grey,
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
                            child: Center(
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(8.0),
                                  itemCount: realEstateApi.loadingStatus ==
                                          RealEstateLoading.Succeed
                                      ? realEstateApi.realEstate.images.length
                                      : 0,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          mainImage = index;
                                        });
                                      },
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        margin: EdgeInsets.only(
                                            right: 8.0, left: 8.0),
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    realEstateApi.realEstate
                                                        .images[index].url),
                                                fit: BoxFit.cover),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0))),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          ///////////////////////// Real Estate Info
                          realEstateApi.loadingStatus ==
                                  RealEstateLoading.Succeed
                              ? Container(
                                  margin: EdgeInsets.only(right: 16, left: 16),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.baseline,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              children: [
                                                Text(
                                                  realEstateApi
                                                      .realEstate.price,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)
                                                      .saudiCurrency,
                                                  style: TextStyle(
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              realEstateApi.realEstate.title,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                realEstateApi
                                                    .realEstate.address,
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
                                )
                              : Container(),
                          ////////////////////////////// Request Button
                          realEstateApi.loadingStatus ==
                                  RealEstateLoading.Succeed
                              ? Container(
                                  height: 48.0,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 16.0),
                                  child: realEstateOwner
                                      ? Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  showModalBottomSheet<dynamic>(
                                                      isScrollControlled: true,
                                                      context: context,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      builder: (BuildContext
                                                          buildContext) {
                                                        return StatefulBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              StateSetter
                                                                  setState) {
                                                            return RentInfoScreen();
                                                          },
                                                        );
                                                      });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary:
                                                      AppTheme.primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0)),
                                                ),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Image.asset(
                                                        'assets/images/info.png',
                                                        height: 20,
                                                        width: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 4.0,
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .rentInfo,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black),
                                                        maxLines: 1,
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 16.0,
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      AccountingDetails
                                                          .route());
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  primary:
                                                      AppTheme.primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0)),
                                                ),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Image.asset(
                                                        'assets/images/wallet.png',
                                                        height: 20,
                                                        width: 20,
                                                        color: Colors.black,
                                                      ),
                                                      SizedBox(
                                                        width: 4.0,
                                                      ),
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .accounting,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black),
                                                        maxLines: 1,
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        )
                                      : ElevatedButton(
                                          onPressed: () {
                                            if (apiToken != null) {
                                              if (realEstateApi
                                                      .realEstate.status !=
                                                  "auction") {
                                                if (alreadyRequested) {
                                                  Navigator.of(context).push(
                                                      RequestSubmittedScreen
                                                          .route(userRequest));
                                                } else {
                                                  Navigator.of(context).push(
                                                      RequestScreen.route(
                                                          realEstateApi
                                                              .realEstate,
                                                          apiToken,
                                                          userProfile));
                                                }
                                              }
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => LoginDialog(
                                                        realEstateId:
                                                            realEstateId,
                                                      ));
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: AppTheme.primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.0)),
                                          ),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/images/request.png',
                                                  height: 20,
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  width: 4.0,
                                                ),
                                                alreadyRequested
                                                    ? Text(AppLocalizations.of(
                                                            context)
                                                        .showYourRequest)
                                                    : Text(
                                                        realEstateApi.realEstate
                                                                    .status ==
                                                                'rent'
                                                            ? AppLocalizations
                                                                    .of(context)
                                                                .requestRent
                                                            : realEstateApi
                                                                        .realEstate
                                                                        .status ==
                                                                    'sale'
                                                                ? AppLocalizations.of(
                                                                        context)
                                                                    .requestOwnership
                                                                : AppLocalizations.of(
                                                                        context)
                                                                    .joinAuction,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                Colors.black),
                                                      ),
                                              ]),
                                        ),
                                )
                              : shimmer(),
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
                                    text: AppLocalizations.of(context)
                                        .description,
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
                      RealEstateDescriptionScreen(
                        realEstateApi.loadingStatus == RealEstateLoading.Succeed
                            ? realEstateApi.realEstate.description
                            : "",
                      ),
                      RealEstateDetailsScreen(),
                      RealEstateReviewsScreen(),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget shimmer() {
    return Column(
      children: <Widget>[
        Container(
          height: 12.0,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [
                0.1,
                0.4,
                0.7,
                0.9,
              ],
                  colors: [
                Color(0x70616161),
                Color(0x50616161),
                Color(0x30616161),
                Color(0x30616161),
              ])),
        ),
        Container(
          height: 12.0,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [
                0.1,
                0.4,
                0.7,
                0.9,
              ],
                  colors: [
                Color(0x70616161),
                Color(0x50616161),
                Color(0x30616161),
                Color(0x30616161),
              ])),
        ),
        Container(
          height: 12.0,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [
                0.1,
                0.4,
                0.7,
                0.9,
              ],
                  colors: [
                Color(0x70616161),
                Color(0x50616161),
                Color(0x30616161),
                Color(0x30616161),
              ])),
        ),
      ],
    );
  }
}
