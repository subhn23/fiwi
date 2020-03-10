import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiwi/ui/TimetableEdit.dart';
import 'package:fiwi/ui/home.dart';
import 'package:flutter/material.dart';
import 'global.dart';
import 'package:intl/intl.dart';

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Color(0x666b6d6f),
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: (isAdmin)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => TimeTableEdit()));
              },
              tooltip: 'Edit Timetable',
              child: Icon(Icons.edit),
              backgroundColor: gAccentColor,
            )
          : FloatingActionButton(
              onPressed: () {},
              tooltip: 'Info',
              child: Icon(Icons.info),
              backgroundColor: gAccentColor,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
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
              'Timetable',
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
                        'Thursday',
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
              ]),
            ),
          ],
        ),
      )),
    );
  }

  Widget buildPeriod(BuildContext context, DocumentSnapshot document) {
    var dId = document.documentID;
    DateTime showStartTime =
        DateTime.parse(document['startTime'].toDate().toString());
    DateTime showEndTime =
        DateTime.parse(document['endTime'].toDate().toString());
    return InkWell(
      onDoubleTap: () {
        //Firestore.instance.collection('Timetable').document(dId).delete();
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

class MyText extends StatelessWidget {
  Color tColor;
  String textValue;
  var fontSize, fontWeight;

  MyText({this.tColor, this.textValue, this.fontSize, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        textValue,
        style: TextStyle(
            fontSize: fontSize, fontWeight: fontWeight, color: tColor),
      ),
    );
  }
}
