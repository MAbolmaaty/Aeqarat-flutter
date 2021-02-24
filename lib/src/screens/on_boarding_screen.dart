import 'dart:async';

import 'package:aeqarat/src/screens/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<PageViewItem> pages;
  bool skip = false;
  bool getStarted = false;

  @override
  Widget build(BuildContext context) {
    getPages(context);
    autoSkipping();
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 56.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    if (!getStarted) {
                      setState(() {
                        skip = true;
                      });
                      Timer(
                          Duration(seconds: 2),
                          () => Navigator.of(context)
                              .pushReplacement(BottomNavScreen.route(2, true)));
                    }
                  },
                  child: skip && !getStarted
                      ? Align(alignment: Alignment.topRight, child: _loading())
                      : Text(
                          AppLocalizations.of(context).skip,
                          style: TextStyle(
                            color: const Color(0xffCCCCCC),
                            fontSize: 15,
                          ),
                        ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  itemCount: pages.length,
                  itemBuilder: (context, position) {
                    return _pageViewItem(pages[position]);
                  },
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator()),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          if (_currentPage > 0) {
                            _pageController.previousPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease);
                          }
                        },
                        child: _currentPage > 0 ? Text('Previous') : Text('')),
                    GestureDetector(
                      onTap: () {
                        if (_currentPage != pages.length - 1) {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        } else {
                          if (!skip) {
                            setState(() {
                              getStarted = true;
                            });
                            Timer(
                                Duration(seconds: 2),
                                () => Navigator.of(context)
                                    .pushReplacement(BottomNavScreen.route(2, true)));
                          }
                        }
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        padding: _currentPage != pages.length - 1
                            ? EdgeInsets.all(0.0)
                            : EdgeInsets.all(8.0),
                        decoration: _currentPage != pages.length - 1
                            ? null
                            : getStarted && !skip
                                ? null
                                : BoxDecoration(
                                    color: const Color(0xffFFDB27),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0))),
                        child: _currentPage != pages.length - 1
                            ? Text('Next')
                            : getStarted && !skip
                                ? _loading()
                                : Text('Get Started'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < pages.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: 8.0,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFFDB27) : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _pageViewItem(PageViewItem pageViewItem) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Image(
                  image: AssetImage(pageViewItem.image),
                  height: 200,
                  width: 200,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: Text(
                pageViewItem.title,
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: 15.0,
              ),
              Center(
                  child: Text(
                pageViewItem.subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: const Color(0xffCCCCCC)),
              )),
            ],
          ),
        ),
      ),
    );
  }

  List<PageViewItem> getPages(BuildContext context) {
    return pages = <PageViewItem>[
      PageViewItem(
          'assets/images/slide_1.png',
          AppLocalizations.of(context).onBoardingSlide1_title,
          AppLocalizations.of(context).onBoardingSlide1_subTitle),
      PageViewItem(
          'assets/images/slide_2.png',
          AppLocalizations.of(context).onBoardingSlide2_title,
          AppLocalizations.of(context).onBoardingSlide2_subTitle),
      PageViewItem(
          'assets/images/slide_3.png',
          AppLocalizations.of(context).onBoardingSlide3_title,
          AppLocalizations.of(context).onBoardingSlide3_subTitle),
    ];
  }

  Widget _loading() {
    return SizedBox(
      child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          strokeWidth: 2,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.black)),
      height: 15,
      width: 15,
    );
  }
}

class PageViewItem {
  String image;
  String title;
  String subTitle;

  PageViewItem(this.image, this.title, this.subTitle);
}

void autoSkipping() async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool('auto_skipping', true);
}
