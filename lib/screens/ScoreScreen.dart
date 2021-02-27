// import 'package:abacus/screens/LoginScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:abacus/Variables.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:math';
import 'package:abacus/screens/HomeScreen.dart';
import 'package:abacus/screens/SolveScreen.dart';

import 'package:abacus/screens/ad_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:abacus/widgets/drawer.dart';
import 'package:share/share.dart';

import 'SolveScreen.dart';

const String testDevice = 'Abacus';

// BannerAd createBannerAd() {
//   return BannerAd(
//     adUnitId: BannerAd.testAdUnitId,
//     size: AdSize.banner,
//     listener: (MobileAdEvent event) {
//       print("BannerAd event $event");
//     },
//   );
// }

Future _stop() async {
  if (flutterTts != null) await flutterTts.stop();
}

class ScoreScreen extends StatefulWidget {
  final int score, quesCount, milliseconds;
  final String user;
  ScoreScreen(
      {Key key,
      @required this.user,
      this.score,
      this.quesCount,
      this.milliseconds})
      : super(key: key);

  @override
  _ScoreScreenState createState() => _ScoreScreenState(
      user: user,
      score: score,
      quesCount: quesCount,
      milliseconds: milliseconds);
}

class _ScoreScreenState extends State<ScoreScreen> {
  final int score, quesCount, milliseconds;
  final String user;
  _ScoreScreenState(
      {@required this.user, this.score, this.quesCount, this.milliseconds});
  @override
  void initState() {
    super.initState();
    _initAdMob();
    _bannerAd = BannerAd(
      adUnitId: AdManager.ScoreScreenbannerAdUnitId,
      size: AdSize.banner,
    );
    _loadBannerAd();
    _stop();
    if (milliseconds != null) formatTime(milliseconds);
  }

  @override
  void dispose() {
    try {
      _bannerAd?.dispose();
      _bannerAd = null;
    } catch (ex) {
      print("banner dispose error");
    }

    super.dispose();
  }

  Future<void> _initAdMob() {
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }

  BannerAd _bannerAd;
  void _loadBannerAd() async {
    await _bannerAd.load();
    _bannerAd.show(anchorType: AnchorType.bottom);
  }

  var secs, hours, minutes, seconds;
  String formatTime(int milliseconds) {
    secs = milliseconds ~/ 1000;
    hours = (secs ~/ 3600).toString().padLeft(2, '0');
    minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: new Scaffold(
              drawer: AppDrawer(user: user),
              body: Stack(
                children: [
                  // Container(
                  //     decoration: BoxDecoration(
                  //         image: DecorationImage(
                  //             image: AssetImage("images/1.jpg"),
                  //             fit: BoxFit.cover))),
                  // Container(
                  //   color: Color.fromRGBO(255, 255, 255, 0.6),
                  // ),
                  new Container(
                      padding: EdgeInsets.all(8.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                            elevation: 10,
                            color: Color.fromRGBO(235, 235, 252, 0.8),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ListTile(
                                title: Column(
                                  children: [
                                    Text(
                                      'You solved ' +
                                          score.toString() +
                                          '\n' +
                                          'out of ' +
                                          quesCount.toString() +
                                          ' questions correctly' +
                                          (minutes == null
                                              ? ''
                                              : ' in $minutes minutes $seconds seconds.'),
                                      style: new TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                    // Text(
                                    //   "${getEmoji(score, quesCount)}",
                                    //   style: new TextStyle(
                                    //       fontSize: 24.0,
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.blue),
                                    // ),
                                    Image.asset(
                                      "images/${getEmoji(score, quesCount)}",
                                      height: 125.0,
                                      width: 125.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () => {
                                      _bannerAd?.dispose(),
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(user: user)),
                                          (r) => false)
                                    },
                                    child: Text(
                                      "Done",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white),
                                    ),
                                    color: Theme.of(context).accentColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  child: RaisedButton(
                                    onPressed: () => {
                                      Share.share('I solved ' +
                                          score.toString() +
                                          '\n' +
                                          'out of ' +
                                          quesCount.toString() +
                                          ' questions correctly' +
                                          (minutes == null
                                              ? ''
                                              : 'in $minutes minutes $seconds seconds.'))
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.share),
                                        Text(
                                          "Share Result",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    color: Theme.of(context).accentColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ))),
    );
  }
}

// class ScoreScreen extends StatelessWidget {
//   final int score, quesCount;
//   final String user;

//   ScoreScreen({Key key, @required this.user, this.score, this.quesCount})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//         home: new Scaffold(
//             body: new Container(
//                 padding: EdgeInsets.all(8.0),
//                 child: new Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         side: BorderSide(
//                           color: Colors.blue,
//                           width: 2.0,
//                         ),
//                       ),
//                       elevation: 10,
//                       color: Colors.blue[50],
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: ListTile(
//                           title: Column(
//                             children: [
//                               Text(
//                                 'Your Final Score is ' + score.toString(),
//                                 style: new TextStyle(
//                                     fontSize: 24.0,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.blue),
//                               ),
//                               Text(
//                                 "${getEmoji(score, quesCount)}",
//                                 style: new TextStyle(
//                                     fontSize: 24.0,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.blue),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 16,
//                     ),
//                     RaisedButton(
//                       onPressed: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => HomeScreen(user: user)),
//                       ),
//                       child: Text(
//                         "Done",
//                         style: TextStyle(
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.normal,
//                             color: Colors.white),
//                       ),
//                       color: Theme.of(context).accentColor,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5.0)),
//                     ),
//                   ],
//                 ))));
//   }
//   // @override
//   // _scoreScreenState createState() => new _scoreScreenState(res,user);
// }

getEmoji(int score, int maxScore) {
  double percentage = (score.toDouble() / maxScore) * 100;
  if (percentage < 20) {
    return '1.webp';
  } else if (percentage < 40) {
    return '2.webp';
  } else if (percentage < 60) {
    return '3.webp';
  } else if (percentage < 80) {
    return '4.webp';
  } else {
    return '5.webp';
  }
}

// class _scoreScreenState extends State<ScoreScreen> {
//   int res;
//   final String user;

//   _scoreScreenState({
//     Key key,
//     @required this.res, this.user,
//   }) : super(key: key);

// }
