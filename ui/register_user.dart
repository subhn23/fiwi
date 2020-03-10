import 'package:fiwi/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fiwi/utils/firebase_auth.dart';

import 'information.dart';

class CreateUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserData(),
    );
  }
}

class UserData extends StatefulWidget {
  UserData({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<UserData> {
  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();
  TextEditingController rollno = new TextEditingController();
  TextEditingController key = new TextEditingController();

  String error = '';

  void _showSnakBarMsg(String msg) {
    _scaffoldState.currentState.showSnackBar(new SnackBar(
      content: new Text(msg),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 100,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.wifi,
                        size: 90,
                        color: Colors.black,
                      ),
                      Text(
                        'Regiser on fiwi',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      _buildRole(),
                      SizedBox(height: 20),
                      _buildRollno(),
                      SizedBox(
                        height: 30,
                      ),
                      _buildRegBtn(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildRole() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       SizedBox(
  //         height: 10,
  //       ),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         height: 60,
  //         child: TextField(
  //           controller: role,
  //           keyboardType: TextInputType.text,
  //           style: TextStyle(
  //             color: Colors.black,
  //           ),
  //           decoration: InputDecoration(
  //             border: OutlineInputBorder(
  //               borderRadius: BorderRadius.all(
  //                 Radius.circular(0.0),
  //               ),
  //             ),
  //             contentPadding: EdgeInsets.only(
  //               top: 14,
  //             ),
  //             prefixIcon: Icon(
  //               Icons.account_circle,
  //               color: Colors.black,
  //             ),
  //             hintText: 'enter your email or roll no.',
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  String dropdownValue;
  List<String> items = ['Student', 'Admin'];
  Widget _buildRole() {
    return new DropdownButton<String>(
      hint: new Text('Pickup your role'),
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.blueGrey),
      underline: Container(
        height: 2,
        color: Colors.blueGrey,
      ),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          this.dropdownValue = newValue;
        });
      },
    );
  }

  

  Widget _buildRollno() {
    if (dropdownValue == "Student") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 60,
            child: TextField(
              controller: rollno,
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
                hintText: 'Your Rollno',
              ),
            ),
          ),
        ],
      );
    } else if(dropdownValue == "Admin"){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 60,
            child: TextField(
              controller: key,
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
                hintText: 'Your Secret key',
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
        ],
      );
    }
  }

  Widget _buildRegBtn() {
    // return GestureDetector(
    //   onTap:() {
    //     //Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));
    //     AuthProvider().createRecord(role);
    //   },
    //   child: RichText(
    //     text: TextSpan(
    //       children:[
    //         TextSpan(
    //           text:'Don\'t have an account?',
    //           style: TextStyle(
    //             color: Colors.black,
    //             fontSize: 15,
    //             fontWeight: FontWeight.w500,
    //           ),
    //         ),
    //         TextSpan(text:'Signup',
    //           style: TextStyle(
    //             color: Colors.black,
    //             fontSize: 18,
    //             fontWeight: FontWeight.bold,
    //           ),

    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 30,
      ),
      width: double.infinity,
      child: RaisedButton(
        onPressed: () {
          if(dropdownValue == "Student") {
            AuthProvider().createRecord(rollno);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Information()));
          } else if(dropdownValue == "Admin") {
            if(key.text =="ADMin@CsC") {
              AuthProvider().createAdminRecord();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
            } else {
              _showSnakBarMsg('You have entered the wrong key');
            }
          }
        },
        padding: EdgeInsets.all(
          15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        color: Colors.black,
        child: Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
