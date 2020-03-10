import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiwi/ui/attendance.dart';
import 'package:fiwi/ui/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'global.dart';
import 'package:cached_network_image/cached_network_image.dart';

var a;

class GetAttendance extends StatefulWidget {
  final String title;
  GetAttendance({Key key, @required this.title}) : super(key: key);
  @override
  _MyGet createState() => new _MyGet(title: title);
}

class _MyGet extends State<GetAttendance> {
  final String title;
  _MyGet({Key key, @required this.title});

  //DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    //_getM();
  }

  @override
  Widget build(BuildContext context) {
    String datetime = title.substring(0, 26);
    // Stream<DocumentSnapshot> provideDocumentFieldStream() {
    //   return Firestore.instance
    //       .collection('attendance')
    //       .document(datetime)
    //       .collection('present')
    //       .document('present')
    //       .snapshots();
    // }

    return WillPopScope(
      child: Scaffold(
        body: Container(
          child: new StreamBuilder(
            stream: Firestore.instance
                .collection('attendance')
                .document(datetime)
                .collection('present')
                .where('datetime', isEqualTo: datetime)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                //Map<dynamic, dynamic> documentFields = snapshot.data;
                //return Text(snapshot.data.data.toString());
                // print(snapshot.data.documents.length);
                // return Text('dkfj');

                return new ListView.builder(
                  itemBuilder: (context, index) =>
                      buildItem(context, snapshot.data.documents[index]),
                  itemCount: snapshot.data.documents.length,
                );
              }
            },
          ),
        ),
      ),
      onWillPop: () {
        return Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => AdminAtt()));
      },
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    print(document['uid']);
    return new StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .where('uid', isEqualTo: document['uid'])
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          print(snapshot.data.documents[0]['name']);

          // return Container(child: Column(
          //   children: <Widget>[
          //     Text(snapshot.data.documents[0]['name']),
          //     Text(document['present'].toString()),
          //   ],
          // ));
          
        }
      },
    );
  }
}
