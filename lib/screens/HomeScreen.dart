// import 'package:abacus/screens/LoginScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:abacus/screens/AdditionSettingScreen.dart';
import 'package:abacus/screens/MultiplicationSettingScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'LoginScreen.dart';
import 'SolveScreen.dart';

class IsAllowedScreen extends StatelessWidget {
  final String user;

  IsAllowedScreen({this.user});
  @override
  Widget build(BuildContext context) {
    //CollectionReference users = FirebaseFirestore.instance.collection('users');
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    //   return FutureBuilder<DocumentSnapshot>(
    //     future: users.doc("phoneNumberAccess").get(),
    //     builder:
    //         (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //       if (snapshot.hasError) {
    //         return Text("Something went wrong");
    //       }

    //       if (snapshot.connectionState == ConnectionState.done) {
    //         Map<String, dynamic> data = snapshot.data.data();
    //         if (data[user] != null && data[user] == true) {
    //           return HomeScreen(user: user);
    //         }
    //         //users.doc("phoneNumberAcccess").set({'$user': false});
    //         addUser(user);
    //         return Center(
    //           child: Wrap(children: <Widget>[
    //             Card(
    //               shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(10.0),
    //                 side: BorderSide(
    //                   color: Colors.blue,
    //                   width: 2.0,
    //                 ),
    //               ),
    //               elevation: 10,
    //               color: Colors.blue[50],
    //               child: Padding(
    //                 padding: const EdgeInsets.all(16.0),
    //                 child: ListTile(
    //                   title: Column(
    //                     children: [
    //                       Text(
    //                         "The Phone Number $user is not allowed.\nPlease get your phone number validated. ",
    //                         style: new TextStyle(
    //                             fontSize: 24.0,
    //                             fontWeight: FontWeight.bold,
    //                             color: Colors.blue),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ]),
    //         );

    //         //   return Text(
    //         //       "The Phone Number $user is not allowed or invalid. Please get your phone number validated ");
    //       }

    //       return Center(
    //         child: Wrap(children: <Widget>[
    //           Card(
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(10.0),
    //               side: BorderSide(
    //                 color: Colors.blue,
    //                 width: 2.0,
    //               ),
    //             ),
    //             elevation: 10,
    //             color: Colors.blue[50],
    //             child: Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: ListTile(
    //                 title: Column(
    //                   children: [
    //                     Text(
    //                       "LOADING...",
    //                       style: new TextStyle(
    //                           fontSize: 24.0,
    //                           fontWeight: FontWeight.bold,
    //                           color: Colors.blue),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ]),
    //       );
    //     },
    //   );
    //
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc("accessControl").get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          //return Text(data[user]['loggedIn'].toString());
          if (data[user] != null) {
            // if (data[user]['isAllowed'] != null &&
            //     data[user]['isAllowed'] == true &&
            //     data[user]['registered'] == false) {
            //   return RegistrationScreen(user: user);
            //   //return RegisterScreen(user: user);
            // } else if (data[user]['isAllowed'] != null &&
            //     data[user]['isAllowed'] == true &&
            //     data[user]['registered'] == true) {
            //   return HomeScreen(user: user);
            // }
            return HomeScreen(user: user);
          }else{
            addUser(user);
            return HomeScreen(user: user);
          }
          //users.doc("phoneNumberAcccess").set({'$user': false});
          addUser(user);
          return WillPopScope(
            onWillPop: () {},
            child: Center(
              child: Wrap(children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  elevation: 10,
                  color: Colors.blue[50],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      title: Column(
                        children: [
                          Text(
                            "The Phone Number $user is not allowed.\nPlease get your phone number validated. ",
                            style: new TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        }

        return Container(
          color: Colors.white,
          child: Center(
            child: SpinKitFadingCircle(
              color: Colors.blue,
              size: 50.0,
            ),
          ),
        );
      },
    );
  }
}

addUser(String phNo) {
  // FirebaseFirestore.instance.collection("users").doc('phoneNumberAccess').set({
  //   '$phNo': false,
  // }, SetOptions(merge: true));
  FirebaseFirestore.instance.collection("user").doc('accessControl').set({
    '$phNo': {'isAllowed': true, 'registered': false},
  }, SetOptions(merge: true));
}

void LogPrint(Object object) async {
  int defaultPrintLength = 1020;
  if (object == null || object.toString().length <= defaultPrintLength) {
    print(object);
  } else {
    String log = object.toString();
    int start = 0;
    int endIndex = defaultPrintLength;
    int logLength = log.length;
    int tmpLogLength = log.length;
    while (endIndex < logLength) {
      print(log.substring(start, endIndex));
      endIndex += defaultPrintLength;
      start += defaultPrintLength;
      tmpLogLength -= defaultPrintLength;
    }
    if (tmpLogLength > 0) {
      print(log.substring(start, logLength));
    }
  }
}

Future _stop() async {
  if (flutterTts != null) await flutterTts.stop();
}

class RegistrationScreen extends StatefulWidget {
  final String user;

  RegistrationScreen({this.user});

  @override
  _RegistrationScreenState createState() =>
      new _RegistrationScreenState(user: user);
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final String user;
  TextEditingController sNameController,
      fNameController,
      addressController,
      emailController,
      dobController;
  @override
  void initState() {
    super.initState();
    sNameController = TextEditingController();
    fNameController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();
    dobController = TextEditingController();
  }

  _RegistrationScreenState({
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Submit Details"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: new TextFormField(
                      // keyboardType: TextInputType.number,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.digitsOnly,
                      //   LengthLimitingTextInputFormatter(1),
                      //   CustomRangeTextInputFormatter3(),
                      // ],
                      controller: sNameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          labelText: "Student's Name",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: new TextFormField(
                      // keyboardType: TextInputType.number,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.digitsOnly,
                      //   LengthLimitingTextInputFormatter(1),
                      //   CustomRangeTextInputFormatter3(),
                      // ],
                      controller: fNameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          labelText: "Father's Name",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: new TextFormField(
                      //keyboardType: TextInputType.number,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.digitsOnly,
                      //   LengthLimitingTextInputFormatter(1),
                      //   CustomRangeTextInputFormatter3(),
                      // ],
                      controller: addressController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          labelText: "Address", border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: new TextFormField(
                      // keyboardType: TextInputType.number,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.digitsOnly,
                      //   LengthLimitingTextInputFormatter(1),
                      //   CustomRangeTextInputFormatter3(),
                      // ],
                      controller: emailController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          labelText: "Email ID", border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: new TextField(
                      keyboardType: TextInputType.number,
                      // inputFormatters: [
                      //   FilteringTextInputFormatter.digitsOnly,
                      //   LengthLimitingTextInputFormatter(1),
                      //   CustomRangeTextInputFormatter3(),
                      // ],
                      controller: dobController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          labelText: "Date Of Birth",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    color: Colors.white,
                    width: double.infinity,
                    child: new RaisedButton(
                      onPressed: () => {
                        if (sNameController.text != null &&
                            fNameController.text != null &&
                            addressController.text != null &&
                            dobController.text != null &&
                            emailController.text != null &&
                            sNameController.text != "" &&
                            fNameController.text != "" &&
                            addressController.text != "" &&
                            dobController.text != "" &&
                            emailController.text != "")
                          {
                            registerUser(
                                user,
                                sNameController.text,
                                fNameController.text,
                                addressController.text,
                                emailController.text,
                                dobController.text),
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                        user: user,
                                      )),
                            ),
                          }
                        else
                          {
                            showToast("Fields cannot be empty", false),
                          }
                      },
                      child: new Text(
                        'SUBMIT',
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                      color: Theme.of(context).accentColor,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//showToast(String s, bool bool) {}
void showToast(String text, bool isGreen) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: isGreen ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

registerUser(String phone, String sName, String fName, String address,
    String email, String dob) {
  // FirebaseFirestore.instance.collection("users").doc('phoneNumberAccess').set({
  //   '$phNo': false,
  // }, SetOptions(merge: true));
  FirebaseFirestore.instance.collection("user").doc('registrations').set({
    '$phone': {
      'phone': phone,
      'sName': sName,
      'fName': fName,
      'address': address,
      'email': email,
      'dob': dob,
    }
  }, SetOptions(merge: true)).whenComplete(
    () => {
      FirebaseFirestore.instance.collection("user").doc('accessControl').set({
        '$phone': {'registered': true},
      }, SetOptions(merge: true))
    },
  );
}

class HomeScreen extends StatefulWidget {
  final String user;

  HomeScreen({this.user});

  @override
  _HomeScreenState createState() => new _HomeScreenState(user: user);
}

class _HomeScreenState extends State<HomeScreen> {
  int tempzero = 0;

  final String user;
  _HomeScreenState({
    @required this.user,
  });

  void initState() {
    super.initState();
    _stop();
  }

  @override
  Widget build(BuildContext context) {
    // Future _speak(String text) async {
    // final FlutterTts flutterTts = FlutterTts();
    // LogPrint(await flutterTts.getVoices);
    // await flutterTts.setLanguage('en-US');
    // await flutterTts.setVoice('en-in-x-ahp-local');
    // List<String> sentences = [
    //   'Hello',
    //   'World',
    //   'Hello World',
    //   'How are you?',
    //   'The',
    //   'quick'
    // ];
    // int i = 0;

    // await flutterTts.speak(sentences[i]);

    // flutterTts.setCompletionHandler(() async {
    //   if (i < sentences.length - 1) {
    //     i++;
    //     await flutterTts.speak(sentences[i]);
    //   }
    // });

    // await flutterTts.speak(text);
    // }

    // _speak('hey there, how are you guys, welcome to our app');
    // _speak('1234567 plus 3300 minus 21 multiplied by 5 divided by 12312');
    // _speak('');

    // print('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n');

    return WillPopScope(
      onWillPop: () {},
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/1.jpg"), fit: BoxFit.cover))),
            Container(
              color: Color.fromRGBO(255, 255, 255, 0.6),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 15,
                    color: Colors.blue,
                    child: ListTile(
                      leading: Icon(Icons.add),
                      title: Text("Add & Subtract",
                          style: TextStyle(color: Colors.white)),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdditionScreen(
                                    user: user,
                                  )),
                        ),
                        // runApp(AdditionScreen(
                        //   user: user,
                        // ))
                      },
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Card(
                    elevation: 15,
                    color: Colors.blue,
                    child: ListTile(
                      leading: Icon(Icons.star),
                      title: Text("Multiply & Divide",
                          style: TextStyle(color: Colors.white)),
                      onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MultiplicationScreen(
                                    user: user,
                                  )),
                        ),
                      },
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Card(
                          elevation: 10,
                          child: FlatButton(
                            child: Text("Logout"),
                            textColor: Colors.blue,
                            padding: EdgeInsets.all(16),
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.clear();
                              FirebaseAuth.instance.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            color: Colors.white,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                      //   SizedBox(
                      //     width: 36,
                      //   ),
                      //   Container(
                      //     child: Card(
                      //       color: Colors.white,
                      //       elevation: 10,
                      //       child: FlatButton(
                      //         child: Text("Edit Details"),
                      //         textColor: Colors.blue,
                      //         padding: EdgeInsets.all(16),
                      //         onPressed: () {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) =>
                      //                       RegistrationScreen()));
                      //         },
                      //         color: Colors.white,
                      //         shape: new RoundedRectangleBorder(
                      //             borderRadius: new BorderRadius.circular(5.0)),
                      //       ),
                      //     ),
                      //   ),
                      //
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
