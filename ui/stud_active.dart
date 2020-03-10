import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiwi/ui/global.dart';
import 'package:fiwi/ui/home.dart';
import 'package:flutter/material.dart';

class StudentActivation extends StatefulWidget {
  @override
  _ShowFeedbacksState createState() => _ShowFeedbacksState();
}

class _ShowFeedbacksState extends State<StudentActivation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              'Student Activation',
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
        child: Stack(
          children: <Widget>[
            Bar(),
            Container(
              padding: EdgeInsets.only(top: 40),
              child: StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .where('status', isEqualTo: 'inactive')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return (snapshot.data.documents.length != 0)
                        ? ListView.builder(
                            padding: EdgeInsets.all(10.0),
                            itemBuilder: (context, index) => buildItem(
                                context, snapshot.data.documents[index]),
                            itemCount: snapshot.data.documents.length,
                          )
                        : Center(
                            child: Text('No record found',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: textColorLight,
                                )));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Color(0x00ffffff),
            context: context,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(photoWidth * 0.3),
                      topRight: Radius.circular(photoWidth * 0.3),
                    )),
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: photoWidth * 0.8,
                              height: photoWidth * 0.8,
                              alignment: Alignment.topCenter,
                              child: Container(
                                  decoration: new BoxDecoration(
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(120.0)),
                                      border: new Border.all(
                                          color: Color(0xff48c5e8),
                                          width: 8.0,
                                          style: BorderStyle.solid),
                                      boxShadow: [
                                        new BoxShadow(
                                            color: Color(0xff48c5e8),
                                            blurRadius: 10),
                                      ]),
                                  child: Material(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(120.0)),
                                    clipBehavior: Clip.hardEdge,
                                    child: Material(
                                      child: CachedNetworkImage(
                                        imageUrl: document['image'],
                                        width: 90.0,
                                        height: 90.0,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(120.0)),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 18),
                              decoration: BoxDecoration(
                                //color: gAccentColor,
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(20.0)),
                              ),
                              width: MediaQuery.of(context).size.width * 0.60,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${document['name']}',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: accentColor,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              //    Column(
                              //     children: <Widget>[
                              //       Padding(
                              //         padding: const EdgeInsets.all(10.0),
                              //         child: Column(
                              //           // mainAxisAlignment: MainAxisAlignment.center,
                              //           // crossAxisAlignment: CrossAxisAlignment.center,
                              //           children: <Widget>[
                              //             Container(
                              //               child: Padding(
                              //                 padding:
                              //                     const EdgeInsets.only(top: 0.0),
                              //                 child: Align(
                              //                   alignment: Alignment.centerLeft,
                              //                   child: Text(
                              //                     '${document['uname']}',
                              //                     style: TextStyle(
                              //                         fontSize: 22,
                              //                         color: accentColor,
                              //                         fontWeight: FontWeight.w800),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //             Container(
                              //               child: Padding(
                              //                 padding:
                              //                     const EdgeInsets.only(top: 5.0),
                              //                 child: Align(
                              //                   alignment: Alignment.centerLeft,
                              //                   child: Text(
                              //                     '${document['title']}',
                              //                     style: TextStyle(
                              //                         fontSize: 16,
                              //                         color: accentColor,
                              //                         fontWeight: FontWeight.w400),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                            ),
                          ]),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: gAccentColor,
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(20.0)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.90,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${document['rollno']}',
                            style: TextStyle(
                                fontSize: 20,
                                color: accentColor,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      //margin: EdgeInsets.only(left: 18),
                      decoration: BoxDecoration(
                        color: gAccentColor,
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(20.0)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.90,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${document['email']}',
                            style: TextStyle(
                                fontSize: 16,
                                color: accentColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                              onPressed: () {},
                              color: eColorPink,
                              child: Text('Reject'),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(68.0),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {
                                Firestore.instance
                                    .collection('users')
                                    .document(document['uid'])
                                    .updateData({'status': 'active'});
                              },
                              color: eColorGreen,
                              child: Text('Active'),
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(68.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
          color: gAccentColor,
          borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
        ),
        padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
        width: MediaQuery.of(context).size.width,
        child: Row(children: <Widget>[
          Container(
            width: photoWidth * 0.8,
            height: photoWidth * 0.8,
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
                  width: 90.0,
                  height: 90.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 18),
            decoration: BoxDecoration(
              color: gAccentColor,
              borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
            ),
            width: MediaQuery.of(context).size.width * 0.60,
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
                                  fontSize: 22,
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
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius:
                      //         new BorderRadius.all(new Radius.circular(20.0)),
                      //   ),
                      //   width: MediaQuery.of(context).size.width * 0.40,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Align(
                      //       alignment: Alignment.centerLeft,
                      //       child: Text(
                      //         '${document['title']}',
                      //         style: TextStyle(fontSize: 16, color: accentColor),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 5.0),
      ),
    );
  }
}

class Bar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClip(),
      child: Container(
        color: textColorLight,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}

class MyClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.lineTo(0.0, size.height);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.2, size.height - 10, size.width * 0.2,
        size.height - 140);
    path.lineTo(size.width * 0.2, size.height * 0.2);
    path.quadraticBezierTo(
        size.width * 0.2, size.height * 0.02, size.width * 0.02, 0.0);
    path.lineTo(size.width * 0.2, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
