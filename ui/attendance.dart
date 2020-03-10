import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiwi/ui/att_report.dart';
import 'package:fiwi/ui/createBatch.dart';
import 'package:fiwi/ui/getAttendance.dart';
import 'package:fiwi/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'global.dart';
import 'indicator.dart';

class AdminAtt extends StatefulWidget {
  @override
  _AdminAttState createState() => _AdminAttState();
}

class _AdminAttState extends State<AdminAtt> {
  List u = new List();
  int touchedIndex;

  List<String> batch = [];
  SharedPreferences pref;
  String uid;
  getBatch() {
    return Firestore.instance
        .collection('batch')
        .where('status', isEqualTo: 'active')
        .getDocuments();
  }

  @override
  void initState() {
    super.initState();
    getBatch().then((bat) {
      for (var k = 0; k < bat.documents.length; k++) {
        print(bat.documents[k]['batchName']);
        batch.add(bat.documents[k]['batchName']);
      }
    });
    readLocal();
  }

  readLocal() async {
    pref = await SharedPreferences.getInstance();
    uid = pref.getString('uid') ?? '';
  }

  Map<String, double> dataMap = new Map();
// dataMap.putIfAbsent("Flutter", () => 5);
// dataMap.putIfAbsent("React", () => 3);
// dataMap.putIfAbsent("Xamarin", () => 2);
// dataMap.putIfAbsent("Ionic", () => 2);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _createButton,
        tooltip: 'Edit Timetable',
        child: Icon(Icons.touch_app),
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
      bottomNavigationBar: BottomAppBar(
        color: Color(0x666b6d6f),
        shape: const CircularNotchedRectangle(),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RaisedButton(
                color: Color(0x006b6d6f),
                elevation: 0,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => CreateBatch()));
                },
                child: Text(
                  'Create Batch',
                  style: TextStyle(color: textColorLight),
                ),
              ),
              RaisedButton(
                elevation: 0,
                child: Text(
                  'Check Attendance',
                  style: TextStyle(color: textColorLight),
                ),
                color: Color(0x006b6d6f),
                onPressed: () {
                  // AuthProvider().logOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AttendanceReportPage()));
                },
              ),
            ],
          ),
          height: 50.0,
        ),
      ),
      body: WillPopScope(
        child: SafeArea(
            child: SingleChildScrollView(
          child: Container(
              height: screenHeight,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      PieChart(
                        PieChartData(
                            pieTouchData:
                                PieTouchData(touchCallback: (pieTouchResponse) {
                              setState(() {
                                if (pieTouchResponse.touchInput
                                        is FlLongPressEnd ||
                                    pieTouchResponse.touchInput is FlPanEnd) {
                                  touchedIndex = -1;
                                } else {
                                  touchedIndex =
                                      pieTouchResponse.touchedSectionIndex;
                                }
                              });
                            }),
                            borderData: FlBorderData(
                              show: true,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 50,
                            sections: showingSections()),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Indicator(
                            color: Color(0xff0293ee),
                            text: 'First',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Color(0xfff8b250),
                            text: 'Second',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Color(0xff845bef),
                            text: 'Third',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Color(0xff13d38e),
                            text: 'Fourth',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                        ],
                      ),
                    ],
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

  var da;
  final now = new DateTime.now();
  String batchValue;
  List<String> semesterItems;
  String periodValue;
  List<String> periodItems = ['peroid1', 'period2', 'peroid3', 'period4'];
  void _createButton() {
    showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              contentPadding: EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              content: Builder(
                builder: (context) {
                  var height = MediaQuery.of(context).size.height;
                  var screenWidth = MediaQuery.of(context).size.width;

                  return SingleChildScrollView(
                    child: Container(
                      width: screenWidth,
                      child: Column(
                        children: <Widget>[
                          DropdownButton<String>(
                            iconEnabledColor: textColorLight,
                            hint: new Text(
                              'Select Batch',
                              style: TextStyle(
                                  color: textColorLight,
                                  fontWeight: FontWeight.w400),
                            ),
                            value: batchValue,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.blueGrey),
                            underline: Container(
                              height: 2,
                              color: Colors.blueGrey,
                            ),
                            items: batch
                                .map<DropdownMenuItem<String>>((String abc) {
                              return DropdownMenuItem<String>(
                                value: abc,
                                child: Text(abc),
                              );
                            }).toList(),
                            onChanged: (String newbValue) {
                              setState(() {
                                batchValue = newbValue;
                              });
                              showModalBottomSheet(
                                  backgroundColor: Color(0x00ffffff),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      decoration: BoxDecoration(
                                        color: bgColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50),
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Selected Batch: $newbValue',
                                        style: TextStyle(
                                            color: textColorLight,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    );
                                  });
                            },
                          ),
                          DropdownButton<String>(
                            iconEnabledColor: textColorLight,
                            hint: new Text(
                              'Pickup Period',
                              style: TextStyle(
                                  color: textColorLight,
                                  fontWeight: FontWeight.w400),
                            ),
                            value: periodValue,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.blueGrey),
                            underline: Container(
                              height: 2,
                              color: Colors.blueGrey,
                            ),
                            items: periodItems
                                .map<DropdownMenuItem<String>>((String value1) {
                              return DropdownMenuItem<String>(
                                value: value1,
                                child: Text(value1),
                              );
                            }).toList(),
                            onChanged: (String newpValue) {
                              setState(() {
                                periodValue = newpValue;
                              });
                              showModalBottomSheet(
                                  backgroundColor: Color(0x00ffffff),
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      decoration: BoxDecoration(
                                        color: bgColor,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(50),
                                          topRight: Radius.circular(50),
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        'Selected Period: $newpValue',
                                        style: TextStyle(
                                            color: textColorLight,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              backgroundColor: gAccentColor,
              elevation: 8,
              title: Text(
                'Set Class details to take attendance',
                style: TextStyle(color: textColorLight),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        // batchValue = '';
                        // periodValue = '';
                        Navigator.pop(context);
                      },
                      color: eColorPink,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          'Discard',
                          style: TextStyle(color: textColorLight),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(68.0),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        Position position = await Geolocator()
                            .getCurrentPosition(
                                desiredAccuracy:
                                    LocationAccuracy.bestForNavigation);
                        DateTime now = DateTime.now();
                        String formattedDate = now.toString();
                        print(formattedDate);
                        // DateFormat('kkmmssEEEdMM').format(now);
                        if (batchValue != null && periodValue != null) {
                          var dr = Firestore.instance
                              .collection('batch')
                              .where('batchName', isEqualTo: batchValue)
                              .getDocuments()
                              .then((var ds) {
                            return ds.documents[0]['semester'];
                          });
                          var useruids = Firestore.instance
                              .collection('batch')
                              .where('batchName', isEqualTo: batchValue)
                              .getDocuments()
                              .then((var ds) async {
                            List b = ds.documents[0]['uids'];
                            Map<String, dynamic> map = new Map.fromIterable(b,
                                key: (k) => k.toString(), value: (v) => null);
                            // map.addAll({'datetime': formattedDate});

                            DocumentReference attendance = Firestore.instance
                                .collection('attendance')
                                .document(formattedDate);
                            await attendance.setData({
                              'adminUid': uid,
                              'datetime': formattedDate,
                              'batch': batchValue,
                              'peroid': periodValue,
                              'semester': await dr,
                            });
                            for (int i = 0; i < b.length; i++) {
                              Firestore.instance
                                  .collection('attendance')
                                  .document(formattedDate)
                                  .collection('present')
                                  .document(b[i])
                                  .setData({'present':null,'datetime':formattedDate, 'uid':b[i]});
                            }
                          });

                          print(position);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QrCodeScreen(
                                        title:
                                            formattedDate + position.toString(),
                                      )));
                        } else {
                          showModalBottomSheet(
                              backgroundColor: Color(0x00ffffff),
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Select all values to take attendance',
                                    style: TextStyle(
                                        color: textColorLight,
                                        fontWeight: FontWeight.bold),
                                  )),
                                );
                              });
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(68.0),
                      ),
                      color: eColorGreen,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: textColorLight),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

List<PieChartSectionData> showingSections() {
  return List.generate(4, (i) {
    int touchedIndex;
    final isTouched = i == touchedIndex;
    final double fontSize = isTouched ? 25 : 16;
    final double radius = isTouched ? 60 : 50;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: const Color(0xff0293ee),
          value: 40,
          title: '40%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 1:
        return PieChartSectionData(
          color: const Color(0xfff8b250),
          value: 30,
          title: '30%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 2:
        return PieChartSectionData(
          color: const Color(0xff845bef),
          value: 15,
          title: '15%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      case 3:
        return PieChartSectionData(
          color: const Color(0xff13d38e),
          value: 15,
          title: '15%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      default:
        return null;
    }
  });
}

class QrCodeScreen extends StatelessWidget {
  final String title;
  QrCodeScreen({Key key, @required this.title}) : super(key: key);
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
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GetAttendance(
                        title: title,
                      )));
        },
        tooltip: 'See attendance',
        child: Icon(Icons.remove_red_eye),
        backgroundColor: gAccentColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: bgColor,
        leading: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => AdminAtt()));
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
              'Take Attendance',
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
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(3),
        child: Center(
          child: Container(
            color: Colors.white,
            child: QrImage(
              data: title,
            ),
          ),
        ),
      )),
    );
  }
}
