import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'global.dart';
import 'package:intl/intl.dart'; // intl: ^0.16.1 --> include in dependencies

class TimeTableEdit extends StatefulWidget {
  @override
  _TimeTableEditState createState() => _TimeTableEditState();
}

class _TimeTableEditState extends State<TimeTableEdit> {
  bool startTimeSet = false;
  bool endTimeSet = false;
  bool isSemSelected = false;
  bool teacherSelected = false;

  String _periodStartString = "00:00";

  addPeriod(DateTime startTime, DateTime endTime, String sem, String teacher,
      int day, String color) async {
    Firestore.instance.collection('Timetable').add({
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'sem': sem,
      'teacher': teacher,
      'color': color
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Card(
                color: gAccentColor,
                elevation: 6,
                child: Column(children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Monday',
                          style: TextStyle(
                              color: textColorLight,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      )),
                  Container(
                    height: 150, //MediaQuery.of(context).size.height * 0.3,
                    child: StreamBuilder(
                      stream: Firestore.instance
                          .collection('Timetable')
                          .where('day', isEqualTo: 1)
                          .orderBy('startTime', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            padding: EdgeInsets.all(10.0),
                            itemBuilder: (context, index) => buildPeriod(
                                context, snapshot.data.documents[index]),
                            itemCount: snapshot.data.documents.length,
                            scrollDirection: Axis.horizontal,
                          );
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {
                      editPeriod(1);
                    },
                  ),
                ]),
              ),
              Card(
                color: gAccentColor,
                elevation: 6,
                child: Column(children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Tuesday',
                          style: TextStyle(
                              color: textColorLight,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      )),
                  Container(
                    height: 150, //MediaQuery.of(context).size.height * 0.3,
                    child: StreamBuilder(
                      stream: Firestore.instance
                          .collection('Timetable')
                          .where('day', isEqualTo: 2)
                          .orderBy('startTime', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            padding: EdgeInsets.all(10.0),
                            itemBuilder: (context, index) => buildPeriod(
                                context, snapshot.data.documents[index]),
                            itemCount: snapshot.data.documents.length,
                            scrollDirection: Axis.horizontal,
                          );
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {
                      editPeriod(2);
                    },
                  ),
                ]),
              ),
              Card(
                color: gAccentColor,
                elevation: 6,
                child: Column(children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Wednesday',
                          style: TextStyle(
                              color: textColorLight,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      )),
                  Container(
                    height: 150, //MediaQuery.of(context).size.height * 0.3,
                    child: StreamBuilder(
                      stream: Firestore.instance
                          .collection('Timetable')
                          .where('day', isEqualTo: 3)
                          .orderBy('startTime', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            padding: EdgeInsets.all(10.0),
                            itemBuilder: (context, index) => buildPeriod(
                                context, snapshot.data.documents[index]),
                            itemCount: snapshot.data.documents.length,
                            scrollDirection: Axis.horizontal,
                          );
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {
                      editPeriod(3);
                    },
                  ),
                ]),
              ),
              Card(
                color: gAccentColor,
                elevation: 6,
                child: Column(children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'thursday',
                          style: TextStyle(
                              color: textColorLight,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      )),
                  Container(
                    height: 150, //MediaQuery.of(context).size.height * 0.3,
                    child: StreamBuilder(
                      stream: Firestore.instance
                          .collection('Timetable')
                          .where('day', isEqualTo: 4)
                          .orderBy('startTime', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            padding: EdgeInsets.all(10.0),
                            itemBuilder: (context, index) => buildPeriod(
                                context, snapshot.data.documents[index]),
                            itemCount: snapshot.data.documents.length,
                            scrollDirection: Axis.horizontal,
                          );
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {
                      editPeriod(4);
                    },
                  ),
                ]),
              ),
              Card(
                color: gAccentColor,
                elevation: 6,
                child: Column(children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Friday',
                          style: TextStyle(
                              color: textColorLight,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      )),
                  Container(
                    height: 150, //MediaQuery.of(context).size.height * 0.3,
                    child: StreamBuilder(
                      stream: Firestore.instance
                          .collection('Timetable')
                          .where('day', isEqualTo: 5)
                          .orderBy('startTime', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            padding: EdgeInsets.all(10.0),
                            itemBuilder: (context, index) => buildPeriod(
                                context, snapshot.data.documents[index]),
                            itemCount: snapshot.data.documents.length,
                            scrollDirection: Axis.horizontal,
                          );
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {
                      editPeriod(5);
                    },
                  ),
                ]),
              ),
              Card(
                color: gAccentColor,
                elevation: 6,
                child: Column(children: <Widget>[
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Saturday',
                          style: TextStyle(
                              color: textColorLight,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      )),
                  Container(
                    height: 150, //MediaQuery.of(context).size.height * 0.3,
                    child: StreamBuilder(
                      stream: Firestore.instance
                          .collection('Timetable')
                          .where('day', isEqualTo: 6)
                          .orderBy('startTime', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            padding: EdgeInsets.all(10.0),
                            itemBuilder: (context, index) => buildPeriod(
                                context, snapshot.data.documents[index]),
                            itemCount: snapshot.data.documents.length,
                            scrollDirection: Axis.horizontal,
                          );
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    onPressed: () {
                      editPeriod(6);
                    },
                  ),
                ]),
              ),
            ],
          ),
        )),
      ),
    );
  }

  void editPeriod(int day) {
    int weekDay = day;
    TimeOfDay _thisTime = TimeOfDay.now();

    TimeOfDay _startTime;
    String _periodEndString = "00:00";
    TimeOfDay _endTime;

    String semSelected;
    String adminSelected;

    Future<Null> _selectStartTime() async {
      final TimeOfDay picked =
          await showTimePicker(context: context, initialTime: _thisTime);

      if (picked != null && picked != _thisTime) {
        setState(() {
          _startTime = picked;
          _periodStartString = _startTime.toString();
          startTimeSet = true;
        });
      } else {
        _startTime = _thisTime;
      }
      setState(() {
        _periodStartString =
            _startTime.hour.toString() + ':' + _startTime.minute.toString();
      });
      showModalBottomSheet(
          backgroundColor: Color(0x00ffffff),
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Center(
                  child: Text(
                'Selected Start Time: $_periodStartString',
                style: TextStyle(
                    color: textColorLight, fontWeight: FontWeight.bold),
              )),
            );
          });
    }

    Future<Null> _selectEndTime() async {
      final TimeOfDay picked =
          await showTimePicker(context: context, initialTime: _thisTime);
      if (picked != null && picked != _thisTime) {
        setState(() {
          _endTime = picked;
          _periodEndString = _endTime.toString();
          endTimeSet = true;
        });
      } else {
        _endTime = _thisTime;
      }
      setState(() {
        _periodEndString =
            _endTime.hour.toString() + ':' + _endTime.minute.toString();
      });
      showModalBottomSheet(
          backgroundColor: Color(0x00ffffff),
          context: context,
          builder: (context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Center(
                  child: Text(
                'Selected End Time: $_periodEndString',
                style: TextStyle(
                    color: textColorLight, fontWeight: FontWeight.bold),
              )),
            );
          });
    }

    DateTime _convertToDateTime(TimeOfDay time) {
      final now = new DateTime.now();
      return new DateTime(now.year, now.month, now.day, time.hour, time.minute);
    }

    showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              content: Builder(
                builder: (context) {
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return SingleChildScrollView(
                    child: Column(children: <Widget>[
                      InkWell(
                        onTap: () {
                          _selectStartTime();
                        },
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: eColorOrange,
                              borderRadius:
                                  BorderRadius.all(new Radius.circular(15.0))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              MyText(
                                tColor: textColorLight,
                                textValue: "Select Start time",
                              ),
                            ],
                          ),
                          width: 160.0,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _selectEndTime();
                        },
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: eColorOrange,
                              borderRadius:
                                  BorderRadius.all(new Radius.circular(15.0))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              MyText(
                                tColor: textColorLight,
                                textValue: "Select End time",
                              ),
                            ],
                          ),
                          width: 160.0,
                        ),
                      ),
                      DropdownButton<String>(
                        value: semSelected,
                        icon: Icon(Icons.arrow_drop_down_circle),
                        iconEnabledColor: textColorLight,
                        hint: Text('Select Sem',
                            style: TextStyle(color: textColorLight)),
                        iconSize: 24,
                        elevation: 16,
                        isExpanded: true,
                        style: TextStyle(color: textColorDeep),
                        underline: Container(height: 2, color: textColorLight),
                        onChanged: (String newValue) {
                          setState(() {
                            semSelected = newValue;
                          });
                          isSemSelected = true;
                          showModalBottomSheet(
                              backgroundColor: Color(0x00ffffff),
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Selected End Time: $semSelected',
                                    style: TextStyle(
                                        color: textColorLight,
                                        fontWeight: FontWeight.bold),
                                  )),
                                );
                              });
                          print(semSelected);
                        },
                        items: sems.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButton<String>(
                        value: adminSelected,
                        icon: Icon(Icons.arrow_drop_down_circle),
                        iconEnabledColor: textColorLight,
                        hint: Text('Select Teacher',
                            style: TextStyle(color: textColorLight)),
                        iconSize: 24,
                        elevation: 16,
                        isExpanded: true,
                        style: TextStyle(color: textColorDeep),
                        underline: Container(height: 2, color: textColorLight),
                        onChanged: (String newValue) {
                          setState(() {
                            adminSelected = newValue;
                          });
                          teacherSelected = true;
                          showModalBottomSheet(
                              backgroundColor: Color(0x00ffffff),
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Selected End Time: $adminSelected',
                                    style: TextStyle(
                                        color: textColorLight,
                                        fontWeight: FontWeight.bold),
                                  )),
                                );
                              });
                          print(adminSelected);
                        },
                        items: admins.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ]),
                  );
                },
              ),
              backgroundColor: gAccentColor,
              elevation: 8,
              title: Text(
                'Add a new period',
                style: TextStyle(color: textColorLight),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        startTimeSet = false;
                        endTimeSet = false;
                        teacherSelected = false;
                        isSemSelected = false;
                        _periodStartString = "00:00";
                        _periodEndString = "00:00";
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
                    SizedBox(
                      width: 20,
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (startTimeSet &&
                            endTimeSet &&
                            teacherSelected &&
                            isSemSelected) {
                          addPeriod(
                              _convertToDateTime(_startTime),
                              _convertToDateTime(_endTime),
                              semSelected,
                              adminSelected,
                              weekDay,
                              eColorBlue.toString());
                          startTimeSet = false;
                          endTimeSet = false;
                          teacherSelected = false;
                          isSemSelected = false;
                          _periodStartString = "00:00";
                          _periodEndString = "00:00";
                          Navigator.pop(context);
                        } else {
                          showModalBottomSheet(
                              backgroundColor: Color(0x00ffffff),
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Selected all elements',
                                    style: TextStyle(
                                        color: textColorLight,
                                        fontWeight: FontWeight.bold),
                                  )),
                                );
                              });
                        }
                      },
                      color: eColorGreen,
                      child: Text(
                        'Add Period',
                        style: TextStyle(color: textColorLight),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(68.0),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget buildPeriod(BuildContext context, DocumentSnapshot document) {
    var dId = document.documentID;
    DateTime showStartTime =
        DateTime.parse(document['startTime'].toDate().toString());
    DateTime showEndTime =
        DateTime.parse(document['endTime'].toDate().toString());
    return InkWell(
      onDoubleTap: () {
        Firestore.instance.collection('Timetable').document(dId).delete();
      },
      child: Container(
        decoration: BoxDecoration(
          color: textColorDeep,
          borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
        ),
        padding: EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 5),
        width: 220, //MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MyText(
                  tColor: textColorLight,
                  textValue: '${DateFormat.jm().format(showStartTime)}',
                ),
                MyText(
                  tColor: textColorLight,
                  textValue: '${DateFormat.jm().format(showEndTime)}',
                ),
              ],
            ),
            MyText(
              tColor: textColorLight,
              textValue: '${document['sem']}',
            ),
            MyText(
              tColor: textColorLight,
              textValue: '${document['teacher']}',
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
      ),
    );
  }
  
}

class MyText extends StatefulWidget {
  Color tColor;
  String textValue;
  var fontSize, fontWeight;

  MyText({this.tColor, this.textValue, this.fontSize, this.fontWeight});

  @override
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        widget.textValue,
        style: TextStyle(
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
            color: widget.tColor),
      ),
    );
  }
}
