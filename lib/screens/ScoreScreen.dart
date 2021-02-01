// import 'package:abacus/screens/LoginScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:abacus/Variables.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:math';
import 'package:abacus/screens/HomeScreen.dart';
import 'package:abacus/screens/ad_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_admob/firebase_admob.dart';

import 'SolveScreen.dart';

const String testDevice = 'Abacus';

BannerAd createBannerAd() {
  return BannerAd(
    adUnitId: BannerAd.testAdUnitId,
    size: AdSize.banner,
    listener: (MobileAdEvent event) {
      print("BannerAd event $event");
    },
  );
}

Future _stop() async {
  if (flutterTts != null) await flutterTts.stop();
}

class ScoreScreen extends StatefulWidget {
  final int score, quesCount;
  final String user;
  ScoreScreen({Key key, @required this.user, this.score, this.quesCount})
      : super(key: key);

  @override
  _ScoreScreenState createState() =>
      _ScoreScreenState(user: user, score: score, quesCount: quesCount);
}

class _ScoreScreenState extends State<ScoreScreen> {
  final int score, quesCount;
  final String user;
  _ScoreScreenState({@required this.user, this.score, this.quesCount});
  @override
  void initState() {
    super.initState();
    _initAdMob();
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
    );
    _loadBannerAd();
    _stop();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();

    super.dispose();
  }

  Future<void> _initAdMob() {
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }

  BannerAd _bannerAd;
  void _loadBannerAd() async {
    await _bannerAd.load();
    _bannerAd.show(anchorType: AnchorType.top);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          home: new Scaffold(
              body: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/1.jpg"),
                          fit: BoxFit.cover))),
              Container(
                color: Color.fromRGBO(255, 255, 255, 0.6),
              ),
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
                                  'Your Final Score is ' +
                                      score.toString() +
                                      '\n' +
                                      'out of ' +
                                      quesCount.toString(),
                                  style: new TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                Text(
                                  "${getEmoji(score, quesCount)}",
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
                      SizedBox(
                        height: 16,
                      ),
                      RaisedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(user: user)),
                        ),
                        child: Text(
                          "Done",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                        color: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
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
    return Variables().score0;
  } else if (percentage < 40) {
    return Variables().score1;
  } else if (percentage < 60) {
    return Variables().score2;
  } else if (percentage < 80) {
    return Variables().score3;
  } else {
    return Variables().score4;
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
