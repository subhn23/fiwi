import 'package:barcode_scan/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiwi/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';

import 'global.dart';

class StudentAtt extends StatefulWidget {
  @override
  _StudentAttState createState() => _StudentAttState();
}

class _StudentAttState extends State<StudentAtt> {
  List<String> batch = [];
  SharedPreferences pref;
  String uid;
  // getBatch() {
  //   return Firestore.instance
  //       .collection('batch')
  //       .where('status', isEqualTo: 'active')
  //       .getDocuments();
  // }

  @override
  void initState() {
    super.initState();
    // getBatch().then((bat) {
    //   for (var k = 0; k < bat.documents.length; k++) {
    //     print(bat.documents[k]['batchName']);
    //     batch.add(bat.documents[k]['batchName']);
    //   }
    // });
    //readLocal();
  }

  // readLocal() async {
  //   pref = await SharedPreferences.getInstance();
  //   uid = pref.getString('uid') ?? '';
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
              'Attendance',
              style: TextStyle(
                fontSize: 26,
                color: textColorLight,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: bgColor,
      body: WillPopScope(
        child: SafeArea(
            child: SingleChildScrollView(
          child: Container(
              height: screenHeight,
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      return Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => QrScanner()));
                      
                    },
                    child: Text('add attendance'),
                  ),
                  Center(
                    child: Text("Welcome to attendance Portal"),
                  ),
                ],
              )),
        )),
        onWillPop: () {
          return Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => HomePage()));
        },
      ),
    );
  }
}

class QrScanner extends StatefulWidget {
  @override
  QrScannerState createState() {
    return new QrScannerState();
  }
}

class QrScannerState extends State<QrScanner> {
  String result = "Hey there !";
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      String datetime = qrResult.substring(0, 26);
      DateTime parsedDate = DateTime.parse(datetime);
      DateTime now = DateTime.now();
      final difference = now.difference(parsedDate).inMinutes;

      print(parsedDate);
      String adminPosition = qrResult.substring(26, qrResult.length);
      String startLatitude =
          adminPosition.substring(0, adminPosition.indexOf(','));
      String startLa = startLatitude.substring(5,startLatitude.length);
      double startLat = double.parse(startLa);
      String startLongitude = adminPosition.substring(
          adminPosition.indexOf(',') + 1, adminPosition.length);
      String startLo = startLongitude.substring(6,startLongitude.length);
      double startLong = double.parse(startLo);

      Position position = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      String myPosition = position.toString();
      String endLatitude = myPosition.substring(0, myPosition.indexOf(','));
      String endLa = endLatitude.substring(5,endLatitude.length);
      double endLat = double.tryParse(endLa);
      String endLongitude =
          myPosition.substring(myPosition.indexOf(',') + 1, myPosition.length);
      String endLo = endLongitude.substring(6,endLongitude.length);
      double endLong = double.tryParse(endLo);
      final double distance = await Geolocator().distanceBetween(
          startLat, startLong, endLat, endLong);
      int dist = distance.toInt();
      if(difference.toInt()<5) {
        if(dist<300) {
          final FirebaseUser user = await auth.currentUser();
          final uid = user.uid;
          Firestore.instance
              .collection('attendance')
              .document(datetime).collection('present').document(uid).updateData({'present': 1});
          
          setState(() {
            result = 'You attendance is successfully taken';
            result +=  dist.toString()+'&'+parsedDate.toString()+adminPosition+myPosition+startLa+startLo+endLa+endLo+distance.toString() +'&'+difference.toString();
          });
          print(uid);
        } else {
          setState(() {
            
            result='Attendance register is closed';
            result +=  dist.toString()+'&'+parsedDate.toString()+adminPosition+myPosition+startLa+startLo+endLa+endLo+distance.toString() +'&'+difference.toString();
        });
        }
      } else {
        setState(() {
          result='Time limit exceed';
        });
      }
    } catch (ex) {
      print(ex);
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Center(
        child: Text(
          result,
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
