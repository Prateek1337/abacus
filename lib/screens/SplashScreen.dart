import 'dart:ui';
import 'package:abacus/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenWidget extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 0,
      navigateAfterSeconds: new HomeScreen(
        user: 'user',
      ),
      title: new Text(
        '\tPRACTICE ABACUS\nListen & Solve',
        textAlign: TextAlign.center,
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            fontStyle: FontStyle.italic),
      ),
      image: new Image.asset('launcher/foreground2.png'),
      photoSize: 150,
      backgroundColor: Colors.white,
      //gradientBackground: Gradient(colors: [Colors.blue,Colors.lightBlue]),
      loaderColor: Colors.red,
    );
  }
}
