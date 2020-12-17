import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:abacus/screens/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:abacus/Variables.dart';

class LoginScreen extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 36,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.grey[200])),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Phone Number"),
                    controller: _phoneController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      child: Text("Login"),
                      textColor: Colors.white,
                      padding: EdgeInsets.all(16),
                      onPressed: () {
                        print('Started');
                        final phone = _phoneController.text.trim();

                        verifyPhoneNumber(phone, context);

                        //loginUser(phone, context);
                      },
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void verifyPhoneNumber(String phone, BuildContext context) async {
    try {
      if (Platform.isAndroid) {
        await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: phone,
            verificationCompleted: (PhoneAuthCredential credential) async {
              // ANDROID ONLY!

              // Sign the user in (or link) with the auto-generated credential
              await FirebaseAuth.instance.signInWithCredential(credential);
            },
            verificationFailed: (FirebaseAuthException e) {
              if (e.code == 'invalid-phone-number') {
                print('The provided phone number is not valid.');
              }

              // Handle other errors
            },
            codeSent: (String verificationId, int resendToken) async {
              // Update the UI - wait for the user to enter the SMS code
              //String smsCode = 'xxxx';
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return MaterialApp(
                      home: AlertDialog(
                        title: Text("Enter the code"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _codeController,
                            )
                          ],
                        ),
                        actions: [
                          FlatButton(
                            child: Text('Confirm'),
                            textColor: Colors.white,
                            color: Colors.blue,
                            onPressed: () async {
                              final code = _codeController.text.trim();
                              AuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationId,
                                      smsCode: code);

                              UserCredential result = await FirebaseAuth
                                  .instance
                                  .signInWithCredential(credential);

                              User user = result.user;

                              if (user != null) {
                                saveUser(user.phoneNumber);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen(
                                              user: user.phoneNumber,
                                            )));
                              } else {
                                print('Error');
                              }
                            },
                          )
                        ],
                      ),
                    );
                  });
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              // Auto-resolution timed out...
            });
      }
    } catch (e) {
      print(e.toString());
      FirebaseAuth auth = FirebaseAuth.instance;
      ConfirmationResult confirmationResult =
          await auth.signInWithPhoneNumber(phone);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return MaterialApp(
              home: AlertDialog(
                title: Text("Enter the code"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _codeController,
                    )
                  ],
                ),
                actions: [
                  FlatButton(
                    child: Text('Confirm'),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async {
                      final code = _codeController.text.trim();
                      UserCredential userCredential =
                          await confirmationResult.confirm(code);

                      User user = userCredential.user;

                      if (user != null) {
                        saveUser(user.phoneNumber);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                      user: user.phoneNumber,
                                    )));
                      } else {
                        print('Error');
                      }
                    },
                  )
                ],
              ),
            );
          });
    }
  }

  void saveUser(String phoneNumber) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(Variables().isLoggedIn, true);
    pref.setString(Variables().phoneNumber, phoneNumber);
  }
}
