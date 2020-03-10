import 'package:flutter/material.dart';
import 'package:fiwi/ui/attendance.dart';

//void main() => runApp(MyApp());

class AttendanceReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AttendanceReportScreen(),
    );
  }
}

class AttendanceReportScreen extends StatefulWidget {
  @override
  _AttendanceReportScreenState createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pushReplacement(
                       context,
                         MaterialPageRoute(
                               builder: (context) => AdminAtt()));
          },
          child: Icon(Icons.arrow_back,color: Colors.black,),
        ),
        centerTitle: true,
        title: Text('Today\'s Attendance Report', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomAppBar(
        //shape: const CircularNotchedRectangle(),
        child: Container(
          height: 80.0,

          child: Padding(
            padding: const EdgeInsets.only(left: 98, top: 20, right: 30, bottom: 10),
            child: RaisedButton(onPressed: (){}
            ,child: Text('Submit Attendance'),
         // padding: EdgeInsets.only(left: 50),
            color: Colors.white,

            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.black,
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => QrCodePage()));
      //   },
      //   tooltip: 'Increment Counter',
      //   child: Icon(
      //     Icons.add,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: WillPopScope(
              child: SafeArea(
            child: Container(
          //margin: EdgeInsets.only(top: 100, bottom: 100, left: 30, right: 30),
          child: ListView(
            children: <Widget>[
              MyFunction(
                title: 'Sunil',
              ),
              MyFunction(
                title: 'Dinesh',
              ),
              MyFunction(
                title: 'Subrat',
              ),
              MyFunction(
                title: 'Atirek',
              ),
              MyFunction(
                title: 'Dibya',
              ),
              MyFunction(
                title: 'Subhendra',
              ),
              MyFunction(
                title: 'Kiran',
              ),
              MyFunction(
                title: 'Janme',
              ),
            ],
          ),
        )), onWillPop: () {
          return Navigator.pushReplacement(
                       context,
                         MaterialPageRoute(
                               builder: (context) => AdminAtt()));
        },
      ),
    );
  }
}

class MyFunction extends StatelessWidget {
  MyFunction({this.title, this.icon, this.color});

  final String title;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text(title, style: TextStyle(fontSize: 18),), CheckBoxWidget()],
          ),
        ),
      ),
    );
  }
}

class CheckBoxWidget extends StatefulWidget {
  @override
  _CheckBoxWidgetState createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  bool checkValue = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      child: Checkbox(
       materialTapTargetSize: MaterialTapTargetSize.padded,
        activeColor: Colors.black,
          value: checkValue,
          onChanged: (bool value) {
            setState(() {
              checkValue = value;
            });
          }),
    );
  }
}
