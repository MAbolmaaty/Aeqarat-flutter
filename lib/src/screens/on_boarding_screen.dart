import 'package:aeqarat/src/screens/bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20.0),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacement(BottomNavScreen.route());
                  },
                  child: Text(
                    AppLocalizations.of(context).skip,
                    style: TextStyle(
                      color: const Color(0xffCCCCCC),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                height: 500,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image(
                              image: AssetImage('assets/images/slide_1.png'),
                              height: 200,
                              width: 200,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                              child: Text(
                            'Manage Your Real Estates From One Place',
                            textAlign: TextAlign.center,
                          )),
                          SizedBox(
                            height: 15.0,
                          ),
                          Center(
                              child: Text(
                            'Aeqarat App enables you from managing your valuable real estate and having services for maintenance and leasehold from one app',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: const Color(0xffCCCCCC)),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image(
                              image: AssetImage('assets/images/slide_2.png'),
                              height: 200,
                              width: 200,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                              child: Text(
                            'Explore more provided services',
                            textAlign: TextAlign.center,
                          )),
                          SizedBox(
                            height: 15.0,
                          ),
                          Center(
                              child: Text(
                            'Aeqarat app provides you with more services like maintenance and leasehold',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: const Color(0xffCCCCCC)),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Image(
                              image: AssetImage('assets/images/slide_3.png'),
                              height: 200,
                              width: 200,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                              child: Text(
                            'Manage financial procedures',
                            textAlign: TextAlign.center,
                          )),
                          SizedBox(
                            height: 15.0,
                          ),
                          Center(
                              child: Text(
                            'Manage your real estate financial procedures, bills and profit',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: const Color(0xffCCCCCC)),
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator()),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                          onTap: () {
                            if (_currentPage != _numPages - 1) {
                              _pageController.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            } else {
                              Navigator.of(context).pushReplacement(BottomNavScreen.route());
                            }
                          },
                          child: _currentPage != _numPages - 1
                              ? Text('Next')
                              : Container(
                            padding: EdgeInsets.all(8.0),
                                  child: Text('Get Started'),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFDB27),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                )),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                          onTap: () {
                            if (_currentPage > 0) {
                              _pageController.previousPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            }
                          },
                          child:
                              _currentPage > 0 ? Text('Previous') : Text('')),
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: isActive ? 12.0 : 8.0,
      width: isActive ? 12.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFFDB27) : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
