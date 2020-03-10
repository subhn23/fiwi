import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences pref;

  // Future<bool> signInWithEmail(String email, String password) async{
  //   try {
  //     AuthResult result = await _auth.signInWithEmailAndPassword(email: email,password: password);
  //     FirebaseUser user = result.user;
  //     print("hello");
  //     if(user != null) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
      
    } catch (e) {
      print("error logging out");
    }
  }

  Future<bool> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if(account == null )
        return false;
      AuthResult res = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      if(res.user == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print("Error logging with google");
      return false;
    }
  }  
  void createRecord(TextEditingController rollno) async {
    final FirebaseUser user = await _auth.currentUser();
    final databaseReference = Firestore.instance;
    
    await databaseReference.collection("users").document(user.uid)
        .setData({
          'uid': user.uid,
          'name': user.displayName,
          'email': user.email,
          'image': user.photoUrl,
          'semester': '',
          'rollno': rollno.text,
          'role': 'student',
          'status': 'inactive',
          'phone': user.phoneNumber,
          'fcmtoken': ''
        });
    pref = await SharedPreferences.getInstance();
    await pref.setString('uid', user.uid);
    await pref.setString('img', user.photoUrl);
    await pref.setString('name', user.displayName);
    await pref.setString('email', user.email);
    await pref.setString('rollno', rollno.text);
  }
  void createAdminRecord() async {
    final FirebaseUser user = await _auth.currentUser();
    final databaseReference = Firestore.instance;
    await databaseReference.collection("users").document(user.uid)
      .setData({
        'uid': user.uid,
        'name': user.displayName,
        'email': user.email,
        'image': user.photoUrl,
        'role': 'admin',
        'status': 'active',
        'phone': user.phoneNumber,
        'fcmtoken': '',
        'designation': '',
        'qualification': ''
      });
    pref = await SharedPreferences.getInstance();
    await pref.setString('uid', user.uid);
    await pref.setString('img', user.photoUrl);
    await pref.setString('name', user.displayName);
    await pref.setString('email', user.email);
  }
  Future exists() async {
    final FirebaseUser user = await _auth.currentUser();
    return await Firestore.instance.collection('users').where('uid', isEqualTo: user.uid).getDocuments();
  }
}