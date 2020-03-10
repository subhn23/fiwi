import 'package:flutter/material.dart';
import 'package:fiwi/utils/firebase_auth.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextEditingController _emailController;
  // TextEditingController _passwordController;

  @override
  void initState() { 
    super.initState();
    // _emailController = TextEditingController(text: "");
    // _passwordController = TextEditingController(text: "");
  }

  // @override
  // Widget build(BuildContext context){
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             const SizedBox(height: 100.0),
  //             Text("Login", style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               fontSize: 20.0
  //             ),),
  //             const SizedBox(height: 20.0),
  //             RaisedButton(
  //               child: Text("Login with Google"),
  //               onPressed: () async {
  //                 bool res = await AuthProvider().loginWithGoogle();
  //                 if(!res)
  //                   print("error logging in with google");
  //               },
  //             ),
  //             TextField(
  //               controller: _emailController,
  //               decoration: InputDecoration(
  //                 hintText: "Enter email"
  //               ),
  //             ),
  //             const SizedBox(height: 10.0),
  //             TextField(
  //               controller: _passwordController,
  //               obscureText: true,
  //               decoration: InputDecoration(
  //                 hintText: "Enter password"
  //               ),
  //             ),
  //             const SizedBox(height: 10.0),
  //             RaisedButton(
  //               child: Text("Login"),
  //               onPressed: ()async {
  //                 if(_emailController.text.isEmpty || _passwordController.text.isEmpty) {
  //                   print("Email and password cannot be empty");
  //                   return;
  //                 }
  //                 bool res = await AuthProvider().signInWithEmail(_emailController.text, _passwordController.text);
  //                 if(!res) {
  //                   print("Login failed");
  //                 }
  //               },
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'login to fiwi',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      // _buildEmailTf(),
                      SizedBox(
                        height: 30,
                      ),
                      // _buildPasswordTf(),
                      // _buildForgotPasswordBtn(),
                      _buildLoginBtn(),
                      //_buildSignupBtn(),
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

  // Widget _buildEmailTf() {
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
            
  //           keyboardType: TextInputType.emailAddress,
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

  // Widget _buildPasswordTf() {
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
           
  //           obscureText: true ,
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
  //               Icons.lock,
  //               color: Colors.black,
  //             ),
  //             hintText: 'enter your password',
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  // Widget _buildForgotPasswordBtn() {
  //   return Container(
  //     alignment: Alignment.centerRight,
  //     child: FlatButton(
  //       onPressed: () {
          
  //       },
  //       padding: EdgeInsets.only(right: 0.0),
  //       child: Text(
  //         'Forgot Password???',
  //       ),
  //       ),
  //   );
  // }
  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30,),
      width: double.infinity,
      child: RaisedButton(
        onPressed: ()async {
          bool res = await AuthProvider().loginWithGoogle();
          print(res);
          if(!res) {
            print("error logging in with google");
          }
        },
        padding: EdgeInsets.all(15,),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        color: Colors.black,
        child: Text('Login With Google',
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
  // Widget _buildSignupBtn() {
  //   return GestureDetector(
  //     onTap:() {
        
  //     },
  //     child: RichText(
  //       text: TextSpan(
  //         children:[
  //           TextSpan(
  //             text:'Don\'t have an account?',
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontSize: 15,
  //               fontWeight: FontWeight.w500,
  //             ),
  //           ),
  //           TextSpan(text:'Signup',
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontSize: 18,
  //               fontWeight: FontWeight.bold,
  //             ),

  //           ),
  //         ], 
  //       ),
  //     ),
  //   );
  // }
}