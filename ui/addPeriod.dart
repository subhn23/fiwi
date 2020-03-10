import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'global.dart';

// class addPeriod extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

class EditPeriod extends StatefulWidget {
  final String dayOfWeek;
  EditPeriod({Key key, @required this.dayOfWeek}) : super(key: key);

  @override
  State createState() => _EditPeriodState(dayOfWeek: dayOfWeek);
}

class _EditPeriodState extends State<EditPeriod> {
  
  _EditPeriodState({Key key, @required this.dayOfWeek});

  bool startTimeSet = false;
  bool endTimeSet = false;

  String dayOfWeek;
  TimeOfDay _thisTime = TimeOfDay.now();
  String _periodStart = "Select Start Time";
  TimeOfDay _startTime;
  String _periodEnd = "Select End Time";
  TimeOfDay _endTime;

addPeriod(DateTime startTime, DateTime endTime, String sem, String teacher,
      String day, String color) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    Firestore.instance.collection('Timetable').add({
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'sem': sem,
      'teacher': teacher,
      'color': color
    });
  }



Future<Null> _selectStartTime() async {
      final TimeOfDay picked =
          await showTimePicker(context: context, initialTime: _thisTime);
      if (picked != null && picked != _thisTime) {
        setState(() {
          _startTime = picked;
          _periodStart = _startTime.toString();
          startTimeSet = true;
          print(_periodStart);
        });
      }
    }

    Future<Null> _selectEndTime() async {
      final TimeOfDay picked =
          await showTimePicker(context: context, initialTime: _thisTime);
      if (picked != null && picked != _thisTime) {
        setState(() {
          _endTime = picked;
          _periodEnd = _endTime.toString();
          startTimeSet = true;
          print(_endTime);
        });
      }
    }

    DateTime _convertToDateTime(TimeOfDay time) {
      final now = new DateTime.now();
      return new DateTime(now.year, now.month, now.day, time.hour, time.minute);
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Color(0x666b6d6f),
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Save Timetable',
        child: Icon(Icons.save),
        backgroundColor: eColorGreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: textColorLight,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'Edit Timetable',
              style: TextStyle(
                fontSize: 26,
                color: textColorLight,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
           child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                )),
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    //color: gAccentColor,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(20.0)),
                  ),
                  width: MediaQuery.of(context).size.width * 0.90,
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              _selectStartTime();
                            },
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: eColorOrange,
                                  borderRadius: BorderRadius.all(
                                      new Radius.circular(15.0))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  (startTimeSet)
                                      ? Text(_startTime.toString())
                                      : Container(height: 0, width: 0),
                                  Text(
                                    _periodStart,
                                  ),
                                ],
                              ),
                              width: 160.0,
                            ),

                            //  MyText(
                            //   tColor: textColorLight,
                            //   textValue: _periodStart,
                            // ),
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: new BorderRadius.circular(68.0),
                            // ),
                          ),
                          //(document['published'] == false )                             ?
                          RaisedButton(
                            onPressed: () {
                              _selectEndTime();
                            },
                            color: eColorOrange,
                            child: Text(
                              _periodEnd,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(68.0),
                            ),
                          ) //: Container(),
                        ],
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                    //color: gAccentColor,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(20.0)),
                  ),
                  width: MediaQuery.of(context).size.width * 0.90,
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: eColorPink,
                            child: Text(
                              'Discard',
                              style: TextStyle(color: textColorLight),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(68.0),
                            ),
                          ),
                          //(document['published'] == false )                             ?
                          RaisedButton(
                            onPressed: () {
                              addPeriod(
                                  _convertToDateTime(_startTime),
                                  _convertToDateTime(_endTime),
                                  'sem1',
                                  'Sasmita Mam',
                                  dayOfWeek,
                                  eColorBlue.toString());
                              Navigator.pop(context);
                            },
                            color: eColorGreen,
                            child: Text(
                              'Add Period',
                              style: TextStyle(color: textColorLight),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(68.0),
                            ),
                          ) //: Container(),
                        ],
                      )),
                ),
              ]),
            ),
          )
        
        ),
      ),
    );
  }
}
