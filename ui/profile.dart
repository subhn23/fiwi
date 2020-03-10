import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiwi/main.dart';
import 'package:fiwi/ui/editprofile.dart';
import 'package:fiwi/ui/global.dart';
import 'package:fiwi/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fiwi/utils/firebase_auth.dart';

var photoWidth;

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ProfileScreen(),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  SharedPreferences sharedPrefs;
  SharedPreferences prefs;
  String photo = '';
  String name = '';
  String rollno = '';
  String email = '';
  String dob = '';
  String gender = '';
  String sem = '';
  String guardian = '';
  String phone = '';
  String address = '';
  String designation = '';
  String qualification = '';
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
    });
    readLocal();
  }

  // void loginScreen() async {
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
  // }
  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    photo = prefs.getString('img') ?? '';
    name = prefs.getString('name') ?? '';
    rollno = prefs.getString('rollno') ?? '';
    email = prefs.getString('email') ?? '';
    dob = prefs.getString('dob') ?? '';
    gender = prefs.getString('gender') ?? '';
    sem = prefs.getString('semester') ?? '';
    guardian = prefs.getString('guardian') ?? '';
    phone = prefs.getString('phone') ?? '';
    address = prefs.getString('address') ?? '';
    designation = prefs.getString('designation') ?? '';
    qualification = prefs.getString('qualification') ?? '';

  }

  @override
  Widget build(BuildContext context) {
    photoWidth = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Color(0x666b6d6f),
        shape: const CircularNotchedRectangle(),
        child: Container(
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width*0.7,
              ),
              RaisedButton(elevation: 0,
                child: Text('Logout',style: TextStyle(color: textColorLight),),
                color: Color(0x006b6d6f),
                onPressed: () {
                  AuthProvider().logOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MainScreen()));
                },
              ),
            ],
          ),
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => Settings()));
        },
        tooltip: 'Increment Counter',
        child: Icon(Icons.edit),
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
              'Profile',
              style: TextStyle(
                fontSize: 26,
                color: textColorLight,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  // width: photoWidth,
                                  // height: photoWidth,
                                  alignment: Alignment.topCenter,
                                  child: InkWell(
                                    child: Container(
                                      // height: 130,
                                      // width: 130,
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
                                                blurRadius: 50),
                                          ]),
                                      child: Material(
                                        child: CachedNetworkImage(
                                          imageUrl: photo,
                                          width: 90.0,
                                          height: 90.0,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(120.0)),
                                        clipBehavior: Clip.hardEdge,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(children: <Widget>[
                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            color: textColorDeep,
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(20.0)),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.60,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0),
                                                child: Text(
                                                  name,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: accentColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    (isAdmin == true)?Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            color: textColorDeep,
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(20.0)),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.60,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0),
                                                child: Text(
                                                  designation,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: accentColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ):Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            color: textColorDeep,
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(20.0)),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.60,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0),
                                                child: Text(
                                                  rollno.toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: accentColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                  ]),
                                )
                              ],
                            ),
                          ),
                        ),
                        
                        (isAdmin == true)?Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: accentColor,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(20.0)),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Qualification',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: textColorDeep,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(20.0)),
                                      ),
                                      transform: Matrix4.translationValues(
                                          -30.0, 0.0, 0.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            child: Text(
                                              qualification,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: accentColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: accentColor,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(20.0)),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Email ID',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: textColorDeep,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(20.0)),
                                      ),
                                      transform: Matrix4.translationValues(
                                          -30.0, 0.0, 0.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            child: Text(
                                              email,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: accentColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 7,
                              ),
                              
                               Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: accentColor,
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(20.0)),
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Gender',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: textColorDeep,
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(20.0)),
                                    ),
                                    transform: Matrix4.translationValues(
                                        -30.0, 0.0, 0.0),
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Text(
                                            gender,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: accentColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              
                              
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: accentColor,
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(20.0)),
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Phone',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: textColorDeep,
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(20.0)),
                                    ),
                                    transform: Matrix4.translationValues(
                                        -30.0, 0.0, 0.0),
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Text(
                                            phone,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: accentColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              
                            ],
                          ),
                        ):Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: accentColor,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(20.0)),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Qualification',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: textColorDeep,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(20.0)),
                                      ),
                                      transform: Matrix4.translationValues(
                                          -30.0, 0.0, 0.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            child: Text(
                                              qualification,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: accentColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: accentColor,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(20.0)),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Email ID',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: textColorDeep,
                                        borderRadius: new BorderRadius.all(
                                            new Radius.circular(20.0)),
                                      ),
                                      transform: Matrix4.translationValues(
                                          -30.0, 0.0, 0.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            child: Text(
                                              email,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: accentColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 7,
                              ),
                              
                               Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: accentColor,
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(20.0)),
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Gender',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: textColorDeep,
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(20.0)),
                                    ),
                                    transform: Matrix4.translationValues(
                                        -30.0, 0.0, 0.0),
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Text(
                                            gender,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: accentColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              
                              
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: accentColor,
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(20.0)),
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Phone',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: textColorDeep,
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(20.0)),
                                    ),
                                    transform: Matrix4.translationValues(
                                        -30.0, 0.0, 0.0),
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Text(
                                            phone,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: accentColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
