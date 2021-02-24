import 'dart:ui';

import 'package:aeqarat/src/utils/constant.dart';
import 'package:flutter/material.dart';

class SubmittedRequestRentScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => SubmittedRequestRentScreen(),
  );
  @override
  _SubmittedRequestRentScreenState createState() => _SubmittedRequestRentScreenState();
}

class _SubmittedRequestRentScreenState extends State<SubmittedRequestRentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.whiteColor,
      appBar: AppBar(
        title: Center(child: Text(" طلب الايجار")),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.98,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Constant.cardWite,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left:8.0 ,right: 8.0,top:20.0 ,bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("220 ", style: TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),),
                            Text("ريال ", style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Text("المبلغ الشهري", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.normal),),

                      ],
                    ),
                    Container(
                      height: 70,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text(" تم التفاوض", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right:8.0,left: 8.0),
                      child: Icon(Icons.ac_unit , color: Colors.amber,),
                    ),
                    Text("تاريخ الطلب ", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),),
                  ],
                ),
                Text("01/04/2019", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right:8.0,left: 8.0),
                      child: Icon(Icons.ac_unit , color: Colors.amber,),
                    ),
                    Text("تاريخ الدخول", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),),
                  ],
                ),
                Text("01/04/2019", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right:8.0,left: 8.0),
                      child: Icon(Icons.ac_unit , color: Colors.amber,),
                    ),
                    Text("مبلغ التامين", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),),
                  ],
                ),
                Text("982019", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right:8.0,left: 8.0),
                      child: Icon(Icons.ac_unit , color: Colors.amber,),
                    ),
                    Text("المدة", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),),
                  ],
                ),
                Text("2019", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right:8.0,left: 8.0),
                      child: Icon(Icons.ac_unit , color: Colors.amber,),
                    ),
                    Text("طريقة الدفع", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),),
                  ],
                ),
                Text("VISA", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal),),

              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(" وثائق العقار", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.98,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black,
                  ),

                  child: Center(child: Text("  عقد الإيجار", style: TextStyle(color: Colors.amber, fontSize: 14, fontWeight: FontWeight.normal),)),

                ),
                Positioned(
                    left: 20.0,
                    child: Padding(
                      padding: const EdgeInsets.only(top:14.0),
                      child: Icon(Icons.assignment_returned,color: Colors.amber,),
                    )
                ),

              ],

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.98,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black,
                  ),

                  child: Center(child: Text("الهوية الشخصية", style: TextStyle(color: Colors.amber, fontSize: 14, fontWeight: FontWeight.normal),)),

                ),
                Positioned(
                    left: 20.0,
                    child: Padding(
                      padding: const EdgeInsets.only(top:14.0),
                      child: Icon(Icons.assignment_returned,color: Colors.amber,),
                    )
                ),

              ],

            ),
          ),

        ],
      ),
    );
  }
}