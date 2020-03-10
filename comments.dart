// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: FeedbackPage(),
//     );
//   }
// }

// class FeedbackPage extends StatefulWidget {
//   @override
//   _FeedbackPageState createState() => _FeedbackPageState();
// }

// class _FeedbackPageState extends State<FeedbackPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Align(alignment: Alignment.centerRight,child: Text('Profile',style: TextStyle(color: Colors.black), )),backgroundColor: Colors.white,),
//       backgroundColor: Colors.white,
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             children: <Widget>[
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height*0.2,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.18,
//                       width: MediaQuery.of(context).size.width * 0.35,
//                       decoration: new BoxDecoration(boxShadow: [
//                         new BoxShadow(color: Colors.orange, blurRadius: 30)
//                       ]),
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         elevation: 8,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             //color: const Color(0xff7c94b6),
//                             image: const DecorationImage(
//                               image: NetworkImage(
//                                   'https://image.shutterstock.com/image-photo/casually-handsome-confident-young-man-260nw-439433326.jpg'),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         color: Colors.yellow,
//                       ),
//                     ),
//                     Container(
//                       height: MediaQuery.of(context).size.height * 0.12,
//                       width: MediaQuery.of(context).size.width * 0.47,
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20.0),
//                         ),
//                         elevation: 8,
//                         color: Colors.orangeAccent,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.61,
//                 width: MediaQuery.of(context).size.width,

//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   elevation: 8,
//                   color: Colors.orangeAccent,
//                   child: Stack(
//                     children: <Widget>[
//                       Align(
//                         alignment: Alignment.topCenter,
//                         child: Container(
//                           height: MediaQuery.of(context).size.height * 0.10,
//                           width: MediaQuery.of(context).size.width * 0.81,
//                           padding: EdgeInsets.all(10),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30.0),
//                             ),
//                             elevation: 12,
//                             color: Colors.white,
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: Text(
//                                     'Title',
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                 )),
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.center,
//                         child: Container(
//                           //height: 340,
//                           height: MediaQuery.of(context).size.height * 0.43,
//                           width: MediaQuery.of(context).size.width * 0.8,
//                           padding: EdgeInsets.all(10),
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30.0),
//                             ),
//                             elevation: 12,
//                             color: Colors.white,
//                             child: Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: Text(
//                                     'Description',
//                                     style: TextStyle(fontSize: 20),
//                                   ),
//                                 )),
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomCenter,
//                         child: Container(
//                           height: 70,

//                           //height: MediaQuery.of(context).size.height * 0.1,
//                           width: MediaQuery.of(context).size.width * 0.4,
//                           padding: EdgeInsets.all(12),
//                           child: RaisedButton(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: new BorderRadius.circular(68.0),
//                               ),
//                               //padding: EdgeInsets.all(20),
//                               elevation: 9,
//                               color: Colors.white,
//                               onPressed: () {
//                                 // Navigator.push(
//                                 //     context,
//                                 //     MaterialPageRoute(
//                                 //         builder: (context) =>
//                                 //             DetailsEntry(color: darkYellow)));
//                               },
//                               child: Text(
//                                 'Publish',
//                                 style: TextStyle(fontSize: 26),
//                               )),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: GiveFeed(),
//     );
//   }
// }

// class GiveFeed extends StatefulWidget {
//   @override
//   _GiveFeedState createState() => _GiveFeedState();
// }

// class _GiveFeedState extends State<GiveFeed> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.orange,
//           title:
//               Align(alignment: Alignment.centerRight, child: Text('Feedback')),
//         ),
//         backgroundColor: Colors.orange,
//         body: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.all(30),
//                   height: MediaQuery.of(context).size.height * 0.7,
//                   width: MediaQuery.of(context).size.width,
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                     elevation: 12,
//                     color: Colors.white,
//                     child: Stack(
//                       children: <Widget>[
//                         SingleChildScrollView(
//                           child: Container(
//                             padding: EdgeInsets.all(20),
//                             child: Column(
//                               children: <Widget>[
//                                 Card(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30.0),
//                                   ),
//                                   elevation: 12,
//                                   color: Colors.white,
//                                   child: Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(15.0),
//                                         child: Text(
//                                           'Title',
//                                           style: TextStyle(fontSize: 20),
//                                         ),
//                                       )),
//                                 ),
//                                 Card(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30.0),
//                                   ),
//                                   elevation: 12,
//                                   color: Colors.white,
//                                   child: Container(
//                                     height: MediaQuery.of(context).size.height *
//                                         0.38,
//                                     child: Align(
//                                         alignment: Alignment.topLeft,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(15.0),
//                                           child: Text(
//                                             'Description',
//                                             style: TextStyle(fontSize: 20),
//                                           ),
//                                         )),
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 Align(
//                                   alignment: Alignment.bottomCenter,
//                                   child: RaisedButton(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             new BorderRadius.circular(68.0),
//                                       ),
//                                       //padding: EdgeInsets.all(20),
//                                       elevation: 9,
//                                       color: Colors.orange,
//                                       onPressed: () {
//                                         // Navigator.push(
//                                         //     context,
//                                         //     MaterialPageRoute(
//                                         //         builder: (context) =>
//                                         //             DetailsEntry(color: darkYellow)));
//                                       },
//                                       child: Text(
//                                         'Cancel',
//                                         style: TextStyle(fontSize: 24),
//                                       )),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(34.0),
//                           child: Align(
//                             alignment: Alignment.bottomRight,
//                             child: RaisedButton(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: new BorderRadius.circular(68.0),
//                                 ),
//                                 //padding: EdgeInsets.all(20),
//                                 elevation: 9,
//                                 color: Colors.white,
//                                 onPressed: () {
//                                   // Navigator.push(
//                                   //     context,
//                                   //     MaterialPageRoute(
//                                   //         builder: (context) =>
//                                   //             DetailsEntry(color: darkYellow)));
//                                 },
//                                 child: Text(
//                                   'Submit',
//                                   style: TextStyle(fontSize: 24),
//                                 )),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(38.0),
//                   child: Align(
//                     alignment: Alignment.bottomRight,
//                     child: RaisedButton(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: new BorderRadius.circular(68.0),
//                         ),
//                         //padding: EdgeInsets.all(20),
//                         elevation: 9,
//                         color: Colors.white,
//                         onPressed: () {
//                           // Navigator.push(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //         builder: (context) =>
//                           //             DetailsEntry(color: darkYellow)));
//                         },
//                         child: Text(
//                           'View Feedbacks',
//                           style: TextStyle(fontSize: 20),
//                         )),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
// Card(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(30.0),
                    //   ),
                    //   elevation: 12,
                    //   color: Colors.white,
                    //   child: Container(
                    //       height: MediaQuery.of(context).size.height * 0.15,
                    //       width: MediaQuery.of(context).size.width,
                    //       child: Row(
                    //         children: <Widget>[
                    //           Stack(
                    //             children: <Widget>[
                    //               Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Card(
                    //                   shape: RoundedRectangleBorder(
                    //                     borderRadius:
                    //                         BorderRadius.circular(30.0),
                    //                   ),
                    //                   elevation: 10,
                    //                   child: Container(
                    //                     width: MediaQuery.of(context)
                    //                             .size
                    //                             .width *
                    //                         0.2,
                    //                     decoration: BoxDecoration(
                    //                       borderRadius:
                    //                           BorderRadius.circular(30),
                    //                       //color: const Color(0xff7c94b6),
                    //                       image: const DecorationImage(
                    //                         image: NetworkImage(
                    //                             'https://image.shutterstock.com/image-photo/casually-handsome-confident-young-man-260nw-439433326.jpg'),
                    //                         fit: BoxFit.cover,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   color: Colors.yellow,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //           Container(
                    //             padding: EdgeInsets.all(20),
                    //             child: Column(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceEvenly,
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: <Widget>[
                    //                 Text(
                    //                   'Title:',
                    //                   style: TextStyle(fontSize: 23),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 4,
                    //                 ),
                    //                 Text(
                    //                   'Name:',
                    //                   style: TextStyle(fontSize: 20),
                    //                 )
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       )),
                    // ),
                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(30.0),
                    //   ),
                    //   elevation: 12,
                    //   color: Colors.white,
                    //   child: Container(
                    //       height: MediaQuery.of(context).size.height * 0.15,
                    //       width: MediaQuery.of(context).size.width,
                    //       child: Row(
                    //         children: <Widget>[
                    //           Stack(
                    //             children: <Widget>[
                    //               Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Card(
                    //                   shape: RoundedRectangleBorder(
                    //                     borderRadius:
                    //                         BorderRadius.circular(30.0),
                    //                   ),
                    //                   elevation: 10,
                    //                   child: Container(
                    //                     width: MediaQuery.of(context)
                    //                             .size
                    //                             .width *
                    //                         0.2,
                    //                     decoration: BoxDecoration(
                    //                       borderRadius:
                    //                           BorderRadius.circular(30),
                    //                       //color: const Color(0xff7c94b6),
                    //                       image: const DecorationImage(
                    //                         image: NetworkImage(
                    //                             'https://image.shutterstock.com/image-photo/casually-handsome-confident-young-man-260nw-439433326.jpg'),
                    //                         fit: BoxFit.cover,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   color: Colors.yellow,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //           Container(
                    //             padding: EdgeInsets.all(20),
                    //             child: Column(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceEvenly,
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: <Widget>[
                    //                 Text(
                    //                   'Title:',
                    //                   style: TextStyle(fontSize: 23),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 4,
                    //                 ),
                    //                 Text(
                    //                   'Name:',
                    //                   style: TextStyle(fontSize: 20),
                    //                 )
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       )),
                    // ),
                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(30.0),
                    //   ),
                    //   elevation: 12,
                    //   color: Colors.white,
                    //   child: Container(
                    //       height: MediaQuery.of(context).size.height * 0.15,
                    //       width: MediaQuery.of(context).size.width,
                    //       child: Row(
                    //         children: <Widget>[
                    //           Stack(
                    //             children: <Widget>[
                    //               Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Card(
                    //                   shape: RoundedRectangleBorder(
                    //                     borderRadius:
                    //                         BorderRadius.circular(30.0),
                    //                   ),
                    //                   elevation: 10,
                    //                   child: Container(
                    //                     width: MediaQuery.of(context)
                    //                             .size
                    //                             .width *
                    //                         0.2,
                    //                     decoration: BoxDecoration(
                    //                       borderRadius:
                    //                           BorderRadius.circular(30),
                    //                       //color: const Color(0xff7c94b6),
                    //                       image: const DecorationImage(
                    //                         image: NetworkImage(
                    //                             'https://image.shutterstock.com/image-photo/casually-handsome-confident-young-man-260nw-439433326.jpg'),
                    //                         fit: BoxFit.cover,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   color: Colors.yellow,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //           Container(
                    //             padding: EdgeInsets.all(20),
                    //             child: Column(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceEvenly,
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: <Widget>[
                    //                 Text(
                    //                   'Title:',
                    //                   style: TextStyle(fontSize: 23),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 4,
                    //                 ),
                    //                 Text(
                    //                   'Name:',
                    //                   style: TextStyle(fontSize: 20),
                    //                 )
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       )),
                    // ),
                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(30.0),
                    //   ),
                    //   elevation: 12,
                    //   color: Colors.white,
                    //   child: Container(
                    //       height: MediaQuery.of(context).size.height * 0.15,
                    //       width: MediaQuery.of(context).size.width,
                    //       child: Row(
                    //         children: <Widget>[
                    //           Stack(
                    //             children: <Widget>[
                    //               Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Card(
                    //                   shape: RoundedRectangleBorder(
                    //                     borderRadius:
                    //                         BorderRadius.circular(30.0),
                    //                   ),
                    //                   elevation: 10,
                    //                   child: Container(
                    //                     width: MediaQuery.of(context)
                    //                             .size
                    //                             .width *
                    //                         0.2,
                    //                     decoration: BoxDecoration(
                    //                       borderRadius:
                    //                           BorderRadius.circular(30),
                    //                       //color: const Color(0xff7c94b6),
                    //                       image: const DecorationImage(
                    //                         image: NetworkImage(
                    //                             'https://image.shutterstock.com/image-photo/casually-handsome-confident-young-man-260nw-439433326.jpg'),
                    //                         fit: BoxFit.cover,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   color: Colors.yellow,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //           Container(
                    //             padding: EdgeInsets.all(20),
                    //             child: Column(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceEvenly,
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: <Widget>[
                    //                 Text(
                    //                   'Title:',
                    //                   style: TextStyle(fontSize: 23),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 4,
                    //                 ),
                    //                 Text(
                    //                   'Name:',
                    //                   style: TextStyle(fontSize: 20),
                    //                 )
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       )),
                    // ),
                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(30.0),
                    //   ),
                    //   elevation: 12,
                    //   color: Colors.white,
                    //   child: Container(
                    //       height: MediaQuery.of(context).size.height * 0.15,
                    //       width: MediaQuery.of(context).size.width,
                    //       child: Row(
                    //         children: <Widget>[
                    //           Stack(
                    //             children: <Widget>[
                    //               Padding(
                    //                 padding: const EdgeInsets.all(8.0),
                    //                 child: Card(
                    //                   shape: RoundedRectangleBorder(
                    //                     borderRadius:
                    //                         BorderRadius.circular(30.0),
                    //                   ),
                    //                   elevation: 10,
                    //                   child: Container(
                    //                     width: MediaQuery.of(context)
                    //                             .size
                    //                             .width *
                    //                         0.2,
                    //                     decoration: BoxDecoration(
                    //                       borderRadius:
                    //                           BorderRadius.circular(30),
                    //                       //color: const Color(0xff7c94b6),
                    //                       image: const DecorationImage(
                    //                         image: NetworkImage(
                    //                             'https://image.shutterstock.com/image-photo/casually-handsome-confident-young-man-260nw-439433326.jpg'),
                    //                         fit: BoxFit.cover,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   color: Colors.yellow,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //           Container(
                    //             padding: EdgeInsets.all(20),
                    //             child: Column(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceEvenly,
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: <Widget>[
                    //                 Text(
                    //                   'Title:',
                    //                   style: TextStyle(fontSize: 23),
                    //                 ),
                    //                 SizedBox(
                    //                   height: 4,
                    //                 ),
                    //                 Text(
                    //                   'Name:',
                    //                   style: TextStyle(fontSize: 20),
                    //                 )
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       )),
                    // ),