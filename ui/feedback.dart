import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiwi/ui/global.dart';
import 'package:fiwi/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

DateTime sysTime = DateTime.now();

class ShowFeedbacks extends StatefulWidget {
  @override
  _ShowFeedbacksState createState() => _ShowFeedbacksState();
}

class _ShowFeedbacksState extends State<ShowFeedbacks> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences pref;
  String photo = '';
  String name = '';
  String rollno = '';
  String email = '';
  String role = '';
  void initState() {
    super.initState();
    // Global().check().then((value) async {
    //   await pref.setString('role', value.documents[0]['role']);
    //   print( value.documents[0]['role']);
    // });
    readLocal();
  }

  Future<void> readLocal() async {
    pref = await SharedPreferences.getInstance();
    photo = pref.getString('img') ?? '';
    name = pref.getString('name') ?? '';
    rollno = pref.getString('rollno') ?? '';
    email = pref.getString('email') ?? '';
    role = pref.getString('role') ?? '';
    if (role == 'student') {
      print(role);
    }
  }

  TextEditingController title = new TextEditingController();
  TextEditingController description = new TextEditingController();

  addFeedback() async {
    final FirebaseUser user = await _auth.currentUser();
    Firestore.instance.collection('feedback').add({
      'title': title.text,
      'description': description.text,
      'datetime': sysTime,
      'uid': user.uid,
      'uphoto': photo,
      'uname': name,
      'published': false
    });
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
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    content: Builder(
                      builder: (context) {
// Get available height and width of the build area of this widget. Make a choice depending on the size.
                        var height = MediaQuery.of(context).size.height;
                        var width = MediaQuery.of(context).size.width;

                        return Container(
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: title,
                                  decoration:
                                      InputDecoration(labelText: 'Title'),
                                ),
                                // TextField(

                                //   //controller: _textFieldController,
                                //   decoration: InputDecoration(
                                //       hintText: "Title"),
                                // ),
                                TextFormField(
                                  minLines: 1,
                                  maxLines: 10,
                                  controller: description,
                                  decoration:
                                      InputDecoration(labelText: 'Description'),
                                ),
                              ],
                            ),
                          ),
                          height: height * 0.35,
                          width: width * 0.7,
                        );
                      },
                    ),
                    backgroundColor: bgColor,
                    elevation: 8,
                    title: Text('Give your feedback'),
                    // content: TextField(
                    //   //controller: _textFieldController,
                    //   decoration:
                    //       InputDecoration(hintText: "TextField in Dialog"),
                    // ),
                    actions: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new RaisedButton(
                            padding: EdgeInsets.all(17),
                            color: eColorPink,
                            child: new Text(
                              'Cancel',
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(68.0),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          new RaisedButton(
                            padding: EdgeInsets.all(17),
                            color: eColorGreen,
                            child: new Text(
                              'Publish',
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(68.0),
                            ),
                            onPressed: () {
                              addFeedback();
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
        tooltip: 'Give your feedback',
        child: Icon(Icons.add),
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
              'Feedback',
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
                stream: (isAdmin == true)
                    ? Firestore.instance
                        .collection('feedback')
                        .orderBy('published', descending: false)
                        .snapshots()
                    : Firestore.instance
                        .collection('feedback')
                        .where('published', isEqualTo: true)
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
                      itemBuilder: (context, index) =>
                          buildItem(context, snapshot.data.documents[index]),
                      itemCount: snapshot.data.documents.length,
                    );
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
    print(document['title']);
    var dId = document.documentID;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Color(0x00ffffff),
            context: context,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.4,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(120.0)),
                                  clipBehavior: Clip.hardEdge,
                                  child: CachedNetworkImage(
                                    imageUrl: document['uphoto'],
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
                                    '${document['uname']}',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: accentColor,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
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
                            '${document['title']}',
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
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${document['description']}',
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
                        child: (isAdmin == true)?  Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  RaisedButton(
                                    onPressed: () {
                                      Firestore.instance
                                          .collection('feedback')
                                          .document(dId)
                                          .delete();
                                          Navigator.pop(context);
                                    },
                                    color: eColorPink,
                                    child: Text('Delete', style: TextStyle(color: textColorLight),),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(68.0),
                                    ),
                                  ),(document['published'] == false ) 
                            ?
                                  RaisedButton(
                                    onPressed: () {
                                      Firestore.instance
                                          .collection('feedback')
                                          .document(dId)
                                          .updateData({'published': true});
                                          Navigator.pop(context);
                                    },
                                    color: eColorGreen,
                                    child: Text('Publish', style: TextStyle(color: textColorLight),),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(68.0),
                                    ),
                                  ): Container(),
                                ],
                              )
                            : Container(),
                      ),
                    ),
                  ]),
                ),
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
          color: (document['published'] == true) ? gAccentColor : eColorPink,
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
                    imageUrl: document['uphoto'],
                    width: 90.0,
                    height: 90.0,
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 18),
            decoration: BoxDecoration(
              color:
                  (document['published'] == true) ? gAccentColor : eColorPink,
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
                              '${document['uname']}',
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
                              '${document['title']}',
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

  _onFeedbackView() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(children: <Widget>[
            ListTile(
              leading: Icon(Icons.ac_unit),
              title: Text('cooling'),
              onTap: () {
                //Navigator.pop(context);
              },
            )
          ]);
        });
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
