import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import './profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './global.dart';

class Settings extends StatelessWidget {
  final primaryColor = Color(0xff203152);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Profile()));
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
              'Edit Profile',
              style: TextStyle(
                fontSize: 26,
                color: textColorLight,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: bgColor,
      body: new SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  State createState() => new SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  TextEditingController controllerName;
  TextEditingController controllerRollno;
  TextEditingController controllerEmail;
  TextEditingController controllerPhone;
  TextEditingController controllerDOB;
  TextEditingController controllerGender;
  TextEditingController controllerSemester;
  TextEditingController controllerGuardian;
  TextEditingController controllerAddress;
  TextEditingController controllerDesignation;
  TextEditingController controllerQualification;

  SharedPreferences prefs;

  String uid = '';
  String name = '';
  String photo = '';
  String phone = '';
  String rollno = '';
  String email = '';
  String dob = '';
  String gender = '';
  String semester = '';
  String guardian = '';
  String address = '';
  String designation = '';
  String qualification = '';

  bool isLoading = false;
  File avatarImageFile;

  final FocusNode focusNodeName = new FocusNode();
  final FocusNode focusNodeRollno = new FocusNode();
  final FocusNode focusNodeEmail = new FocusNode();
  final FocusNode focusNodePhone = new FocusNode();
  final FocusNode focusNodeDOB = new FocusNode();
  final FocusNode focusNodeGender = new FocusNode();
  final FocusNode focusNodeSemester = new FocusNode();
  final FocusNode focusNodeGuardian = new FocusNode();
  final FocusNode focusNodeAddress = new FocusNode();
  final FocusNode focusDesignation = new FocusNode();
  final FocusNode focusQualification = new FocusNode();

  final themeColor = Color(0xfff5a623);
  final primaryColor = Color(0xff203152);
  final greyColor = Color(0xffaeaeae);
  final greyColor2 = Color(0xffE8E8E8);
  @override
  void initState() {
    super.initState();
    readLocal();
  }

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid') ?? '';
    photo = prefs.getString('img') ?? '';
    name = prefs.getString('name') ?? '';
    rollno = prefs.getString('rollno') ?? '';
    email = prefs.getString('email') ?? '';
    phone = prefs.getString('phone') ?? '';
    dob = prefs.getString('dob') ?? '';
    gender = prefs.getString('gender') ?? '';
    semester = prefs.getString('semester') ?? '';
    guardian = prefs.getString('guardian') ?? '';
    address = prefs.getString('address') ?? '';
    designation = prefs.getString('designation') ?? '';
    qualification = prefs.getString('qualification') ?? '';

    controllerName = new TextEditingController(text: name);
    controllerRollno = new TextEditingController(text: rollno);
    controllerEmail = new TextEditingController(text: email);
    controllerPhone = new TextEditingController(text: phone);
    controllerDOB = new TextEditingController(text: dob);
    controllerGender = new TextEditingController(text: gender);
    controllerSemester = new TextEditingController(text: semester);
    controllerGuardian = new TextEditingController(text: guardian);
    controllerAddress = new TextEditingController(text: address);
    controllerDesignation = new TextEditingController(text: designation);
    controllerQualification = new TextEditingController(text: qualification);
    // Force refresh input
    setState(() {});
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        avatarImageFile = image;
        isLoading = true;
      });
    }
    uploadFile();
  }

  Future uploadFile() async {
    String fileName = uid;
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(avatarImageFile);
    StorageTaskSnapshot storageTaskSnapshot;
    uploadTask.onComplete.then((value) {
      if (value.error == null) {
        storageTaskSnapshot = value;
        storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
          photo = downloadUrl;
          Firestore.instance
              .collection('users')
              .document(uid)
              .updateData({'image': photo}).then((data) async {
            await prefs.setString('img', photo);
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: "Photo update successful");
          }).catchError((err) {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: err.toString());
          });
        }, onError: (err) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: 'This file is not an image');
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: 'This file is not an image');
      }
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: err.toString());
    });
  }

  void handleUpdateData() {
    focusNodeName.unfocus();
    focusNodePhone.unfocus();
    focusNodeAddress.unfocus();
    focusNodeDOB.unfocus();
    focusNodeEmail.unfocus();
    focusNodeGender.unfocus();
    focusNodeRollno.unfocus();
    focusNodeSemester.unfocus();
    focusNodeGuardian.unfocus();

    setState(() {
      isLoading = true;
    });

    Firestore.instance.collection('users').document(uid).updateData(
        {'name': name, 'phone': phone, 'image': photo, 'rollno': rollno, 'email': email, 'dob': dob, 'gender': gender, 'semester': semester, 'guardian': guardian,'address': address}).then((data) async {
      await prefs.setString('name', name);
      await prefs.setString('img', photo);
      await prefs.setString('phone', phone);
      await prefs.setString('dob', dob);
      await prefs.setString('email', email);
      await prefs.setString('rollno', rollno);
      await prefs.setString('gender', gender);
      await prefs.setString('semester', semester);
      await prefs.setString('guardian', guardian);
      await prefs.setString('address', address);

      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(msg: "Update success");
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(msg: err.toString());
    });
  }
  void handleUpdateAdmin() {
    focusDesignation.unfocus();
    focusDesignation.unfocus();
    focusNodeName.unfocus();
    focusNodeEmail.unfocus();
    focusNodeGender.unfocus();
    focusNodePhone.unfocus();
    

    setState(() {
      isLoading = true;
    });

    Firestore.instance.collection('users').document(uid).updateData(
        {'name': name, 'image': photo, 'email': email, 'gender': gender, 'designation': designation, 'qualification': qualification, 'phone': phone}).then((data) async {
      await prefs.setString('name', name);
      await prefs.setString('img', photo);
      await prefs.setString('phone', phone);
      await prefs.setString('designation', designation);
      await prefs.setString('qualification', qualification);

      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(msg: "Update success");
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(msg: err.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: (isAdmin == true)?Column(
            children: <Widget>[
              // Avatar
              Container(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      (avatarImageFile == null)
                          ? (photo != ''
                              ? Center(
                                  child: Container(
                                    decoration: new BoxDecoration(
                                        // borderRadius: new BorderRadius.all(
                                        //     new Radius.circular(120.0)),
                                        // border: new Border.all(
                                        //     color: Color(0xff48c5e8),
                                        //     width: 8.0,
                                        //     style: BorderStyle.solid),
                                        boxShadow: [
                                          new BoxShadow(
                                              color: Color(0xff48c5e8),
                                              blurRadius: 50),
                                        ]),
                                    child: Material(
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Container(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    themeColor),
                                          ),
                                          width: photoWidth * 0.7,
                                          height: photoWidth * 0.7,
                                          padding: EdgeInsets.all(20.0),
                                        ),
                                        imageUrl: photo,
                                        width: photoWidth * 0.7,
                                        height: photoWidth * 0.7,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(photoWidth * 0.25)),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Icon(
                                    Icons.account_circle,
                                    size: photoWidth * 0.3,
                                    color: greyColor,
                                  ),
                                ))
                          : Material(
                              child: Image.file(
                                avatarImageFile,
                                width: photoWidth * 0.7,
                                height: photoWidth * 0.7,
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(45.0)),
                              clipBehavior: Clip.hardEdge,
                            ),
                      Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: primaryColor.withOpacity(0.8),
                          ),
                          onPressed: getImage,
                          padding:
                              EdgeInsets.symmetric(vertical: photoWidth * 0.25),
                          splashColor: Colors.transparent,
                          highlightColor: greyColor,
                          iconSize: photoWidth * 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                width: double.infinity,
                margin: EdgeInsets.all(20.0),
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      'Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: eColorBlue),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: primaryColor),
                      child: TextField(
                        style: new TextStyle(
                            color: textColorLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Your name',
                          contentPadding: new EdgeInsets.only(
                              left: 0.0, bottom: 5.0, top: 0.0),
                          hintStyle: TextStyle(
                              color: textColorLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: controllerName,
                        onChanged: (value) {
                          name = value;
                        },
                        focusNode: focusNodeName,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  
                  
                  Container(
                    child: Text(
                      'Email',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: eColorBlue),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: primaryColor),
                      child: TextField(
                        style: new TextStyle(
                            color: textColorLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Your Email',
                          contentPadding: new EdgeInsets.only(
                              left: 0.0, bottom: 5.0, top: 0.0),
                          hintStyle: TextStyle(
                              color: textColorLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: controllerEmail,
                        onChanged: (value) {
                          email = value;
                        },
                        focusNode: focusNodeEmail,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Text(
                      'Designation',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: eColorBlue),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: primaryColor),
                      child: TextField(
                        style: new TextStyle(
                            color: textColorLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Your Designation',
                          contentPadding: new EdgeInsets.only(
                              left: 0.0, bottom: 5.0, top: 0.0),
                          hintStyle: TextStyle(
                              color: textColorLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: controllerDesignation,
                        onChanged: (value) {
                          designation= value;
                        },
                        focusNode: focusDesignation,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Text(
                      'Qualification',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: eColorBlue),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: primaryColor),
                      child: TextField(
                        style: new TextStyle(
                            color: textColorLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Your Qualification',
                          contentPadding: new EdgeInsets.only(
                              left: 0.0, bottom: 5.0, top: 0.0),
                          hintStyle: TextStyle(
                              color: textColorLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: controllerQualification,
                        onChanged: (value) {
                          qualification = value;
                        },
                        focusNode: focusQualification,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Text(
                      'Gender',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: eColorBlue),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: primaryColor),
                      child: TextField(
                        style: new TextStyle(
                            color: textColorLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Your Gender',
                          contentPadding: new EdgeInsets.only(
                              left: 0.0, bottom: 5.0, top: 0.0),
                          hintStyle: TextStyle(
                              color: textColorLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: controllerGender,
                        onChanged: (value) {
                          gender = value;
                        },
                        focusNode: focusNodeGender,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  
                  
                  
                  Container(
                    child: Text(
                      'Phone',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: eColorBlue),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: primaryColor),
                      child: TextField(
                        style: new TextStyle(
                            color: textColorLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Your Phone Number',
                          contentPadding: new EdgeInsets.only(
                              left: 0.0, bottom: 5.0, top: 0.0),
                          hintStyle: TextStyle(
                              color: textColorLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: controllerPhone,
                        onChanged: (value) {
                          phone = value;
                        },
                        focusNode: focusNodePhone,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),

              // Button
              Container(
                decoration: new BoxDecoration(
                    // borderRadius: new BorderRadius.all(
                    //     new Radius.circular(120.0)),
                    // border: new Border.all(
                    //     color: Color(0xff48c5e8),
                    //     width: 8.0,
                    //     style: BorderStyle.solid),
                    boxShadow: [
                      new BoxShadow(color: eColorGreen, blurRadius: 30),
                    ]),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(68.0),
                  ),
                  onPressed: handleUpdateAdmin,
                  child: Text(
                    'UPDATE',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  color: eColorGreen,
                  highlightColor: new Color(0xff8d93a0),
                  splashColor: Colors.transparent,
                  textColor: textColorDeep,
                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                ),
                margin: EdgeInsets.only(top: 50.0, bottom: 50.0),
              ),
            ],
          ):Column(
            children: <Widget>[
              // Avatar
              Container(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      (avatarImageFile == null)
                          ? (photo != ''
                              ? Center(
                                  child: Container(
                                    decoration: new BoxDecoration(
                                        // borderRadius: new BorderRadius.all(
                                        //     new Radius.circular(120.0)),
                                        // border: new Border.all(
                                        //     color: Color(0xff48c5e8),
                                        //     width: 8.0,
                                        //     style: BorderStyle.solid),
                                        boxShadow: [
                                          new BoxShadow(
                                              color: Color(0xff48c5e8),
                                              blurRadius: 50),
                                        ]),
                                    child: Material(
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Container(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    themeColor),
                                          ),
                                          width: photoWidth * 0.7,
                                          height: photoWidth * 0.7,
                                          padding: EdgeInsets.all(20.0),
                                        ),
                                        imageUrl: photo,
                                        width: photoWidth * 0.7,
                                        height: photoWidth * 0.7,
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(photoWidth * 0.25)),
                                      clipBehavior: Clip.hardEdge,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Icon(
                                    Icons.account_circle,
                                    size: photoWidth * 0.3,
                                    color: greyColor,
                                  ),
                                ))
                          : Material(
                              child: Image.file(
                                avatarImageFile,
                                width: photoWidth * 0.7,
                                height: photoWidth * 0.7,
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(45.0)),
                              clipBehavior: Clip.hardEdge,
                            ),
                      Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: primaryColor.withOpacity(0.8),
                          ),
                          onPressed: getImage,
                          padding:
                              EdgeInsets.symmetric(vertical: photoWidth * 0.25),
                          splashColor: Colors.transparent,
                          highlightColor: greyColor,
                          iconSize: photoWidth * 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                width: double.infinity,
                margin: EdgeInsets.all(20.0),
              ),
              Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      'Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: eColorBlue),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: primaryColor),
                      child: TextField(
                        style: new TextStyle(
                            color: textColorLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Your name',
                          contentPadding: new EdgeInsets.only(
                              left: 0.0, bottom: 5.0, top: 0.0),
                          hintStyle: TextStyle(
                              color: textColorLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: controllerName,
                        onChanged: (value) {
                          name = value;
                        },
                        focusNode: focusNodeName,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Text(
                      'Rollno',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: eColorBlue),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: primaryColor),
                      child: TextField(
                        style: new TextStyle(
                            color: textColorLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Your Rollno',
                          contentPadding: new EdgeInsets.only(
                              left: 0.0, bottom: 5.0, top: 0.0),
                          hintStyle: TextStyle(
                              color: textColorLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: controllerRollno,
                        onChanged: (value) {
                          rollno = value;
                        },
                        focusNode: focusNodeRollno,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Text(
                      'Email',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: eColorBlue),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: primaryColor),
                      child: TextField(
                        style: new TextStyle(
                            color: textColorLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Your Email',
                          contentPadding: new EdgeInsets.only(
                              left: 0.0, bottom: 5.0, top: 0.0),
                          hintStyle: TextStyle(
                              color: textColorLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: controllerEmail,
                        onChanged: (value) {
                          email = value;
                        },
                        focusNode: focusNodeEmail,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Text(
                      'Date of Birth',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: eColorBlue),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: primaryColor),
                      child: TextField(
                        style: new TextStyle(
                            color: textColorLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Your Date of Birth',
                          contentPadding: new EdgeInsets.only(
                              left: 0.0, bottom: 5.0, top: 0.0),
                          hintStyle: TextStyle(
                              color: textColorLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: controllerDOB,
                        onChanged: (value) {
                          dob = value;
                        },
                        focusNode: focusNodeDOB,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Text(
                      'Gender',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: eColorBlue),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: primaryColor),
                      child: TextField(
                        style: new TextStyle(
                            color: textColorLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Your Gender',
                          contentPadding: new EdgeInsets.only(
                              left: 0.0, bottom: 5.0, top: 0.0),
                          hintStyle: TextStyle(
                              color: textColorLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: controllerGender,
                        onChanged: (value) {
                          gender = value;
                        },
                        focusNode: focusNodeGender,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Text(
                      'Semester',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: eColorBlue),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: primaryColor),
                      child: TextField(
                        style: new TextStyle(
                            color: textColorLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Your Semester',
                          contentPadding: new EdgeInsets.only(
                              left: 0.0, bottom: 5.0, top: 0.0),
                          hintStyle: TextStyle(
                              color: textColorLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: controllerSemester,
                        onChanged: (value) {
                          semester = value;
                        },
                        focusNode: focusNodeSemester,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Text(
                      'Guardian',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: eColorBlue),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: primaryColor),
                      child: TextField(
                        style: new TextStyle(
                            color: textColorLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Your Guardian',
                          contentPadding: new EdgeInsets.only(
                              left: 0.0, bottom: 5.0, top: 0.0),
                          hintStyle: TextStyle(
                              color: textColorLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: controllerGuardian,
                        onChanged: (value) {
                          guardian = value;
                        },
                        focusNode: focusNodeGuardian,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Text(
                      'Phone',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: eColorBlue),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: primaryColor),
                      child: TextField(
                        style: new TextStyle(
                            color: textColorLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Your Phone Number',
                          contentPadding: new EdgeInsets.only(
                              left: 0.0, bottom: 5.0, top: 0.0),
                          hintStyle: TextStyle(
                              color: textColorLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: controllerPhone,
                        onChanged: (value) {
                          phone = value;
                        },
                        focusNode: focusNodePhone,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Text(
                      'Address',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: eColorBlue),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                  Container(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: primaryColor),
                      child: TextField(
                        style: new TextStyle(
                            color: textColorLight,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: 'Your Address',
                          contentPadding: new EdgeInsets.only(
                              left: 0.0, bottom: 5.0, top: 0.0),
                          hintStyle: TextStyle(
                              color: textColorLight,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        controller: controllerAddress,
                        onChanged: (value) {
                          address = value;
                        },
                        focusNode: focusNodeAddress,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 0.0, bottom: 5.0, top: 0.0),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),

              // Button
              Container(
                decoration: new BoxDecoration(
                    // borderRadius: new BorderRadius.all(
                    //     new Radius.circular(120.0)),
                    // border: new Border.all(
                    //     color: Color(0xff48c5e8),
                    //     width: 8.0,
                    //     style: BorderStyle.solid),
                    boxShadow: [
                      new BoxShadow(color: eColorGreen, blurRadius: 30),
                    ]),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(68.0),
                  ),
                  onPressed: handleUpdateData,
                  child: Text(
                    'UPDATE',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  color: eColorGreen,
                  highlightColor: new Color(0xff8d93a0),
                  splashColor: Colors.transparent,
                  textColor: textColorDeep,
                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                ),
                margin: EdgeInsets.only(top: 50.0, bottom: 50.0),
              ),
            ],
          ),
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
        ),

        // Loading
        Positioned(
          child: isLoading
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
                  ),
                  color: Colors.white.withOpacity(0.8),
                )
              : Container(),
        ),
      ],
    );
  }
}
