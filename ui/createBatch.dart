import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiwi/ui/attendance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'global.dart';

class CreateBatch extends StatefulWidget {
  @override
  _AssignSem createState() => _AssignSem();
}

class _AssignSem extends State<CreateBatch> {
  String semesterValue;
  List<String> items = ['sem1', 'sem2', 'sem3', 'sem4', 'sem5', 'sem6'];

  var hello;
  TextEditingController batchName = new TextEditingController();

  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 40),
                child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('users')
                      .where('semester', isEqualTo: '')
                      .snapshots(),
                  builder: (context, snapshot) {
                    //print(snapshot.data.documents[0]['title']);
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemBuilder: (context, index) {
                          hello = snapshot.data.documents;
                          return buildItem(
                              context, snapshot.data.documents[index]);
                        },
                        itemCount: snapshot.data.documents.length,
                      );
                    }
                  },
                ),
              ),
              RaisedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Column(
                            children: <Widget>[
                              TextField(
                                controller: batchName,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0.0),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.only(
                                    top: 14,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.account_circle,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Batch Name',
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                alignment: Alignment.topCenter,
                                child: DropdownButton<String>(
                                  hint: new Text('Pickup Semester'),
                                  value: semesterValue,
                                  icon: Icon(Icons.arrow_downward),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: TextStyle(color: Colors.blueGrey),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blueGrey,
                                  ),
                                  items: items.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String newValue) {
                                    setState(() {
                                      this.semesterValue = newValue;
                                    });
                                  },
                                ),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  var now = new DateTime.now();
                                  var formatter = new DateFormat('yyyy');
                                  String year = formatter.format(now);
                                  List uids = [];
                                  for (int j = 0; j < hello.length; j++) {
                                    Firestore.instance
                                        .collection('users')
                                        .document(hello[j]['uid'])
                                        .updateData(
                                            {'semester': this.semesterValue});
                                    uids.add(hello[j]['uid']);
                                  }
                                  Firestore.instance.collection('batch').add({
                                    'batchName': batchName.text,
                                    'status': 'active',
                                    'semester': this.semesterValue,
                                    'uids': uids
                                  });
                                },
                                child: Text('Submit'),
                              ),
                            ],
                          );
                        });
                  },
                  child: Text('Assign')),
            ],
          ),
        ),
      ),
      onWillPop: () {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminAtt()));
      },
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    print(document['name']);
    bool check = false;
    return Container(
      decoration: BoxDecoration(
        color: gAccentColor,
        borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
      ),
      padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
      width: MediaQuery.of(context).size.width,
      child: Row(children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          child: Container(
              decoration: new BoxDecoration(
                  borderRadius:
                      new BorderRadius.all(new Radius.circular(120.0)),
                  border: new Border.all(
                      color: Color(0xff48c5e8),
                      width: 8.0,
                      style: BorderStyle.solid),
                  boxShadow: [
                    new BoxShadow(color: Color(0xff48c5e8), blurRadius: 10),
                  ]),
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(120.0)),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: document['image'],
                  width: 60.0,
                  height: 60.0,
                  fit: BoxFit.cover,
                ),
              )),
        ),
        Container(
          margin: EdgeInsets.only(left: 18),
          decoration: BoxDecoration(
            color: gAccentColor,
            borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
          ),
          width: MediaQuery.of(context).size.width * 0.50,
          alignment: Alignment.centerLeft,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${document['name']}',
                            style: TextStyle(
                                fontSize: 18,
                                color: accentColor,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${document['rollno']}',
                            style: TextStyle(
                                fontSize: 16,
                                color: accentColor,
                                fontWeight: FontWeight.w400),
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
        Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.padded,
            activeColor: Colors.white,
            value: check,
            onChanged: (bool val) {
              setState(() {
                check = val;
                if (check == true) {
                  print('hello');
                }
              });
            }),
      ]),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
    );
  }
}
