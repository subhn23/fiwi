import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiwi/ui/global.dart';
import 'package:fiwi/ui/information.dart';
import 'package:fiwi/ui/register_user.dart';
import 'package:fiwi/utils/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fiwi/ui/home.dart';
import 'package:fiwi/ui/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}


class MainScreen extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  SharedPreferences prefs;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context,AsyncSnapshot<FirebaseUser> snapshot) {
        if(!snapshot.hasData || snapshot.data == null) {
          return LoginPage();
        } else {
          AuthProvider().exists().then((val) async {
            if(val.documents.length == 1) {
              prefs = await SharedPreferences.getInstance();
              await prefs.setString('uid', val.documents[0]['uid']);
              await prefs.setString('img', val.documents[0]['image']);
              await prefs.setString('role', val.documents[0]['role']);
              await prefs.setString('name', val.documents[0]['name']);
              await prefs.setString('email', val.documents[0]['email']);
              await prefs.setString('rollno', val.documents[0]['rollno']);
              await prefs.setString('dob', val.documents[0]['dob']);
              await prefs.setString('gender', val.documents[0]['gender']);
              await prefs.setString('semester', val.documents[0]['semester']);
              await prefs.setString('guardian', val.documents[0]['guardian']);
              await prefs.setString('phone', val.documents[0]['phone']);
              await prefs.setString('address', val.documents[0]['address']);
              if(val.documents[0]['role'] == 'admin') {
                isAdmin = true;
              } else {
                isAdmin = false;
              }
              if(val.documents[0]['status'] == 'active') {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
              } else {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Information()));
              }
            } else {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => CreateUser()));
            }
          });
          return Scaffold();
        }
      },
    );
  }
}