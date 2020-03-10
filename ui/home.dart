import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fiwi/ui/attendance.dart';
import 'package:fiwi/ui/feedback.dart';
import 'package:fiwi/ui/getAttendance.dart';
import 'package:fiwi/ui/profile.dart';
import 'package:fiwi/ui/stud_active.dart';
import 'package:fiwi/ui/stud_attendance.dart';
import 'package:fiwi/ui/timetable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fiwi/ui/global.dart';
import 'package:intl/intl.dart';

var photoWidth;

class HomePage extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;
  SharedPreferences sharedPref;
  SharedPreferences pref;
  String photo = '';
  String name = '';
  String rollno = '';
  String email = '';

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {});
    return null;
  }

  @override
  void initState() {
    todayAsDay = DateTime.now().weekday;
    print(todayAsDay);
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPref = pref);
    });
    adminList().then((adm) {
      admins = [];
      for (var i = 0; i < adm.documents.length; i++) {
        print(adm.documents[i]['name']);
        admins.add(adm.documents[i]['name']);
      }
    });
    readLocal();
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
        print(data);
        _saveDeviceToken();
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    } else {
      _saveDeviceToken();
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // final snackbar = SnackBar(
        //   content: Text(message['notification']['title']),
        //   action: SnackBarAction(
        //     label: 'Go',
        //     onPressed: () => null,
        //   ),
        // );

        // Scaffold.of(context).showSnackBar(snackbar);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.amber,
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  void dispose() {
    if (iosSubscription != null) iosSubscription.cancel();
    super.dispose();
  }

  adminList() {
    return Firestore.instance
        .collection('users')
        .where('role', isEqualTo: 'admin')
        .getDocuments();
  }

  _saveDeviceToken() async {
    // Get the current user
    FirebaseUser user = await auth.currentUser();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();
    print(fcmToken);
    // Save it to Firestore
    if (fcmToken != null) {
      var tokens = _db.collection('users').document(user.uid);

      await tokens.updateData(
          {'fcmtoken': fcmToken, 'platform': Platform.operatingSystem});
    }
  }

  int todayAsDay;

  // void loginScreen() async {
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
  // }
  void readLocal() async {
    pref = await SharedPreferences.getInstance();
    photo = pref.getString('img') ?? '';
    name = pref.getString('name') ?? '';
    rollno = pref.getString('rollno') ?? '';
    email = pref.getString('email') ?? '';
  }

  Widget build(BuildContext context) {
    photoWidth = MediaQuery.of(context).size.width * 0.25;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Color(0x666b6d6f),
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {}),
        tooltip: 'Increment Counter',
        child: Icon(Icons.format_shapes),
        backgroundColor: gAccentColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: bgColor,
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Dashboard' + isAdmin.toString(),
                          style: TextStyle(fontSize: 26, color: textColorLight),
                        ),
                      )),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Profile()));
                    },
                    splashColor: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: photoWidth,
                            width: MediaQuery.of(context).size.width * 0.25,
                            decoration: new BoxDecoration(boxShadow: [
                              new BoxShadow(
                                  color: Color(0xFF48c5e8), blurRadius: 40)
                            ]),
                            child: Material(
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                  ),
                                  width: 90.0,
                                  height: 90.0,
                                  padding: EdgeInsets.all(20.0),
                                ),
                                imageUrl: photo,
                                width: 90.0,
                                height: 90.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(photoWidth * 0.25)),
                              clipBehavior: Clip.hardEdge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(20.0)),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '$name',
                                        style: TextStyle(
                                            fontSize: 28,
                                            color: accentColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(20.0)),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${rollno.toUpperCase()}',
                                        style: TextStyle(
                                            fontSize: 20, color: accentColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Card(
                    color: gAccentColor,
                    elevation: 6,
                    child: Column(children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TimeTable()));
                        },
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                child: Text(
                                  'Today\'s Time Table',
                                  style: TextStyle(
                                      color: textColorLight,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ),
                            )),
                      ),
                      (todayAsDay == 7)
                          ? Card(
                              color: gAccentColor,
                              elevation: 0,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    150, //MediaQuery.of(context).size.height * 0.3,
                                child: Center(
                                  child: Text('Sunday is fun day',
                                      style: TextStyle(
                                          color: textColorLight,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            )
                          : Card(
                              color: gAccentColor,
                              elevation: 6,
                              child: Column(children: <Widget>[
                                Container(
                                  height:
                                      150, //MediaQuery.of(context).size.height * 0.3,
                                  child: StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('Timetable')
                                        .where('day', isEqualTo: todayAsDay)
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
                                          itemBuilder: (context, index) =>
                                              showPeriod(
                                                  context,
                                                  snapshot
                                                      .data.documents[index]),
                                          itemCount:
                                              snapshot.data.documents.length,
                                          scrollDirection: Axis.horizontal,
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ]),
                            ),
                    ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            if(isAdmin == true) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AdminAtt()));
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        StudentAtt()));
                            }
                            
                          },
                          color: eColorBlue,
                          child: Text('Attendance'),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(68.0),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        GetAttendance(title:null)));},
                          color: eColorOrange,
                          child: Text('Broadcast'),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(68.0),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ShowFeedbacks()));
                          },
                          color: eColorPink,
                          child: Text('Feedback'),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(68.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .25,
                      color: eColorOrange,
                      child: Center(
                        child: Text('Animation'),
                      ),
                    ),
                  ),
                  isAdmin
                      ? RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        StudentActivation()));
                          },
                          color: eColorPink,
                          child: Text('Activation'),
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(68.0),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showPeriod(BuildContext context, DocumentSnapshot document) {
    var dId = document.documentID;
    DateTime showStartTime =
        DateTime.parse(document['startTime'].toDate().toString());
    DateTime showEndTime =
        DateTime.parse(document['endTime'].toDate().toString());
    return Container(
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
