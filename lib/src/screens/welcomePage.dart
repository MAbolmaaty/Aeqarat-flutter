
import 'package:aeqarat/src/models/welcomModel.dart';
import 'package:aeqarat/src/utils/constant.dart';
import 'package:flutter/material.dart';

import 'bottom_nav_screen.dart';

List<WelcomeModel> sliderData = [
  WelcomeModel("assets/images/1.png", "Track your properties in one place" , "Keep track of all your properties owned by you and enjoy maintenance and leasing services in one place only"),
  WelcomeModel("assets/images/2.png", "Enjoy our various services", "Enjoy all the services provided by the application on your owned properties, such as maintenance and leasing"),
  WelcomeModel("assets/images/3.png", "Follow up on financial operations", "Follow up all financial transactions related to your real estate and its invoices, as well as withdraw profits"),

];
class WelcomePage extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => WelcomePage(),
  );
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int currentIndex = 0;
  bool isEnd = false;
  PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            child: PageView.builder(
                itemCount: sliderData.length,
                controller: _pageController,
                onPageChanged: (index){
                  if (index == (sliderData.length - 1)){
                    setState(() {
                      isEnd = true ;
                      currentIndex = index;
                    });
                  }else {
                    setState(() {
                      isEnd = false ;
                      currentIndex = index;
                    });

                  }

                },
                itemBuilder: (context ,index){
                  return Scaffold(
                    backgroundColor: Constant.whiteColor,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      //Create Skip  Text Button
                      actions: [
                        RaisedButton(onPressed: (){
                          Navigator.of(context).pushReplacement(BottomNavScreen.route());
                        },color: Colors.transparent,elevation: 0,child: isEnd ? Text("Go Home" , style: TextStyle(color: Colors.grey , fontSize: 18),):Text("Skip" , style: TextStyle(color: Colors.grey , fontSize: 18),))
                      ],
                    ),
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _slider(),
                        Column(
                          children: [
                            _nameTitle(),
                            _nameDescription(),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: _PageController(sliderData.length),
                              ),
                              Row(
                                children: [
                                  RaisedButton(onPressed: (){
                                    if (isEnd) {
                                      print("end");
                                    }else{
                                      _pageController.animateToPage(currentIndex + 1,
                                        duration: Duration(milliseconds: 100),
                                        curve: Curves.easeIn,
                                      );
                                    }
                                  } ,color: Colors.transparent,elevation: 0, child: Text("Next" , style: TextStyle(color: Colors.grey , fontSize: 18),),),
                                ],
                              )

                            ],
                          ),
                        ),



                      ],
                    ),
                  );
                }
            )
        )
      ],
    );
  }
  Widget _slider(){
    return Container(
      width: 850,
      height: 350,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          image: DecorationImage(
              image: ExactAssetImage(sliderData[currentIndex].image),
              fit: BoxFit.scaleDown
          )
      ),
    );
  }
  Widget _nameTitle(){
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Text(
        sliderData[currentIndex].title , style: TextStyle(color: Colors.black , fontSize: 18 , fontWeight: FontWeight.bold),
      ),
    );
  }
  Widget _nameDescription(){
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Text(
        sliderData[currentIndex].description , style: TextStyle(color: Colors.grey , fontSize: 15 , fontWeight: FontWeight.normal),
        textAlign: TextAlign.center,
      ),
    );
  }
  // ignore: non_constant_identifier_names
  List <Widget> _PageController (int length){
    List<Widget> listlength =[];
    for (int index = 0 ; index < length ; index++){
      listlength.add(
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: (index == currentIndex)? Colors.orange : Colors.grey),
          ),
        ),
      );
    }
    return listlength;
  }
}



