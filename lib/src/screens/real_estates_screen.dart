import 'package:aeqarat/src/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RealEstatesScreen extends StatefulWidget{

  @override
  _RealEstatesScreenState createState() => _RealEstatesScreenState();

}

class _RealEstatesScreenState extends State<RealEstatesScreen> with SingleTickerProviderStateMixin{
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller =  TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.whiteColor,

      appBar:  AppBar(
        title:  Center(child: Text(AppLocalizations.of(context).realStates,)),
      ),
      body:  ListView(
        children: <Widget>[
           Container(
            decoration:  BoxDecoration(color: Theme.of(context).primaryColor),
            child:  TabBar(
              controller: _controller,
              unselectedLabelColor: Colors.grey,
              labelColor: const Color(0xFFFFDB27),
              indicatorColor: const Color(0xFFFFDB27),
              tabs: [
                 Tab(
                  text: AppLocalizations.of(context).rentRealStates,
                ),
                 Tab(
                  text: AppLocalizations.of(context).myproperties,
                ),
              ],
            ),
          ),
           Padding(
             padding: const EdgeInsets.all(10.0),
             child: Container(
              height:  MediaQuery.of(context).size.height * 0.40 ,
               decoration: BoxDecoration(
                   border: Border.all(
                       color: Colors.white
                   ),
                   borderRadius: BorderRadius.all(Radius.circular(15)),
                 color: Colors.white
               ),
              child:  TabBarView(
                controller: _controller,
                children: <Widget>[
                  _cardDesign(),
                  _cardDesign()

                ],
              ),
          ),
           ),

        ],
      ),
    );
  }
  Widget _cardDesign(){
    return   Column(
      children: [
        Stack(
          children: [
            Container(
              height: 180,

              // child: ClipRRect(
              //   borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              //   child: Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,
              //     loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
              //       if (loadingProgress == null) return child;
              //       return Center(
              //         child: CircularProgressIndicator(
              //           value: loadingProgress.expectedTotalBytes != null ?
              //           loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
              //               : null,
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 25,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.black12,
                        ),
                        child:  Align(
                            alignment: Alignment.center,
                            child: Text("جاهزة للبيع" , style: TextStyle(color: Colors.white , fontSize: 14 , fontWeight: FontWeight.normal),)),

                      ) ,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 25,
                          width: 140,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.black12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right:8.0),
                                    child: Text("بواسطة عقاراتي " , style: TextStyle(color: Colors.white , fontSize: 14 , fontWeight: FontWeight.normal),),
                                  )),                                            Container(
                                width: 25,
                                height: 25 ,
                                decoration: BoxDecoration(
                                  // color: Colors.black12,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: ExactAssetImage("assets/images/9.png"),
                                        fit: BoxFit.scaleDown
                                    )
                                ),
                              )
                            ],
                          ),
                        ) ,
                      )

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.favorite, size: 36.0, color: const Color.fromRGBO(218, 165, 32, 1.0)),
                ),
              ],
            ),
            Positioned(
              bottom: 0.0,
              left: 10.0,
              child: Container(
                child: FloatingActionButton(
                  hoverColor: Colors.black,
                  elevation: 10,
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  child: Icon(Icons.send,color: Colors.amber,),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("758.7" , style: TextStyle(color: Colors.black , fontSize: 18 , fontWeight: FontWeight.bold),),
                ),
                Text("ريال سعودي" , style: TextStyle(color: Colors.black , fontSize: 14 , fontWeight: FontWeight.normal),),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(" العنوان بالتفصيل " , style: TextStyle(color: Colors.grey , fontSize: 14 , fontWeight: FontWeight.normal),),
            ),
          ],
        ) ,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(" اسم العقار بالكامل  " , style: TextStyle(color: Colors.grey , fontSize: 14 , fontWeight: FontWeight.normal),),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Row(
              children: [
                Text(" جراج  " , style: TextStyle(color: Colors.grey , fontSize: 14 , fontWeight: FontWeight.normal),),
                Container(
                  width: 30,
                  height: 30 ,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: ExactAssetImage("assets/images/6.png"),
                          fit: BoxFit.scaleDown
                      )
                  ),
                )
              ],
            ) ,
            Row(
              children: [
                Text(" 2 حمام  " , style: TextStyle(color: Colors.grey , fontSize: 14 , fontWeight: FontWeight.normal),),
                Container(
                  width: 30,
                  height: 30 ,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: ExactAssetImage("assets/images/7.png"),
                          fit: BoxFit.scaleDown
                      )
                  ),
                )
              ],
            ) ,
            Row(
              children: [
                Text(" 3 غرفة نوم  " , style: TextStyle(color: Colors.grey , fontSize: 14 , fontWeight: FontWeight.normal),),
                Container(
                  width: 30,
                  height: 30 ,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: ExactAssetImage("assets/images/8.png"),
                          fit: BoxFit.scaleDown
                      )
                  ),
                )
              ],
            ) ,
          ],
        )
      ],
    );
  }
}