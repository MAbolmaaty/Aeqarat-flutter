import 'package:aeqarat/src/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountDetails extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => AccountDetails(),
  );
  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  DateTime _selectedFromDate;
  DateTime _selectedToDate;

  void _frompickDateDialog() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //which date will display when user open the picker
        firstDate: DateTime(1950),
        //what will be the previous supported year in picker
        lastDate: DateTime
            .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedFromDate = pickedDate;
      });
    });
  }
  void _topickDateDialog() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //which date will display when user open the picker
        firstDate: DateTime(1950),
        //what will be the previous supported year in picker
        lastDate: DateTime
            .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui
        _selectedToDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.whiteColor,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment:  CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                )
              ),
              height: 50.0,
              child: Row(
                mainAxisAlignment:  MainAxisAlignment.spaceAround,
                children: [
                  InkWell(onTap: _frompickDateDialog,
                      child: Text(_selectedFromDate == null ? "From" : ' ${DateFormat.yMMMd().format(_selectedFromDate)}', style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.normal),) ),
                  Icon(Icons.arrow_back_ios_rounded,color:Colors.grey ,),
                  InkWell(onTap: _topickDateDialog,
                      child: Text(_selectedToDate == null ? "To" : ' ${DateFormat.yMMMd().format(_selectedToDate)}', style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.normal),) ),
                ],
              ),
            ),
          ) ,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment:  CrossAxisAlignment.start,
            children: [
              Container(
                width: 150.0,
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber,
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Colors.transparent,
                      width: 1,
                    )
                ),
                child: Center(child: Text("Search")),
              ),
              Container(
                width: 100.0,
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Colors.transparent,
                      width: 1,
                    )
                ),
                child: Center(child: Text("Default")),
              ),
            ],
          ) ,
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: (){
                _showDialog();
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.9,
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
                          Text("220", style: TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),),
                          Text("12-03-2019", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.normal),),

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
                          color: Colors.amber,
                        ),
                        child: Center(
                          child: Text("تاكيد التحصيل", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget _showDialog(){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            // height: MediaQuery.of(context).size.height * 0.2,
            // width: MediaQuery.of(context).size.width * 0.2,
            // color: Colors.red,
            child: AlertDialog(
              scrollable: true,
              title: Center(child: Text('تفاصيل الحساب')),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("220", style: TextStyle(color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),),
                        Text("12-03-2019", style: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.normal),),

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
                        color: Colors.amber,
                      ),
                      child: Center(
                        child: Text("تاكيد التحصيل", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),),
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                RaisedButton(
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            ),
          );
        });
  }
}
