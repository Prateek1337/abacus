import 'package:abacus/screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:abacus/screens/ScoreScreen.dart';

// ----------------------------------------------------------------------------------
// main logic
var randmap = {'1': 9, '2': 90, '3': 900, '4': 9000};
var addmap = {'1': 0, '2': 10, '3': 100, '4': 1000};
var rng = new Random();

List multiplyString(String digcount) {
  int num1 = rng.nextInt(randmap[digcount]) + addmap[digcount];
  int num2 = rng.nextInt(randmap[digcount]) + addmap[digcount];
  int res = num1 * num2;
  return [res.toString(), num1.toString() + '*' + num2.toString()];
}

List addString(String digcount) {
  // int num1 = rng.nextInt(randmap[digcount]) + addmap[digcount];
  // int num2 = rng.nextInt(randmap[digcount]) + addmap[digcount];

  int res = rng.nextInt(randmap[digcount]) + addmap[digcount];
  String question = res.toString();

  for (int i = 0; i < 4; i++) {
    int _num = rng.nextInt(randmap[digcount]) + addmap[digcount];
    int sign = rng.nextInt(2);
    // 0 for sub and 1 for add
    if (sign == 0 && res - _num >= 0) {
      res = res - _num;
      question = question + '-' + _num.toString();
    } else {
      res = res + _num;
      question = question + '+' + _num.toString();
    }
  }
  return [res.toString(), question];
}

final FlutterTts flutterTts = FlutterTts();

_speak(String text) async {
  // await flutterTts.setLanguage(language)
  // await flutterTts.setPitch(pitch)

  await flutterTts.speak(text);
  // textEditingController.text = '';
}

// ----------------------------------------------------------------------------------

class SolveApp extends StatelessWidget {
  int numdig, oper, noOfTimes, score;
  int currRes;
  final String user;
  TextEditingController answerController = TextEditingController();

  SolveApp({
    Key key,
    @required this.user,
    this.numdig,
    this.oper,
    this.noOfTimes,
    this.score,
  }) : super(key: key);
  String sumtext = '';

  //function to do generate the sum
  String callOper() {
    List finalres;
    if (oper == 0) {
      finalres = addString(numdig.toString());
    } else {
      finalres = multiplyString(numdig.toString());
    }
    String result = finalres[0];
    String question_tts = finalres[1];
    currRes = int.parse(result);

    // _speak(result);
    return question_tts;
  }

  String btnText(int noOfTimes) {
    if (noOfTimes >= 10) return 'Finish';
    return 'Next';
  }

  Widget btnFunction(int noOfTimes, int result) {
    String answerString = answerController.text;
    // if (answerString == '') checkfornumber and give pop
    int answer = int.parse(answerString);
    if (answer == currRes) score++;
    if (noOfTimes >= 10) return (ScoreScreen(user: user, score: score));

    return (SolveApp(
        user: user,
        numdig: numdig,
        oper: oper,
        noOfTimes: noOfTimes + 1,
        score: score));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            body: new Container(
                padding: EdgeInsets.all(8.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      callOper(),
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      "Question No " + noOfTimes.toString(),
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    Text(
                      "Score is " + score.toString(),
                      style: new TextStyle(fontSize: 16.0),
                    ),

                    TextField(
                      controller: answerController,
                      decoration:
                          new InputDecoration(hintText: "Enter Your Answer"),
                    ),
                    SizedBox(height: 50),
                    RaisedButton(
                      onPressed: () => runApp(btnFunction(noOfTimes, score)),
                      child: Text(
                        btnText(noOfTimes),
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                      color: Theme.of(context).accentColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),

                    // Container(
                    //   width: 120,
                    //   child: FlatButton(
                    //     child: Text("Logout"),
                    //     textColor: Colors.white,
                    //     padding: EdgeInsets.all(16),
                    //     onPressed: () async {
                    //       SharedPreferences prefs =
                    //           await SharedPreferences.getInstance();
                    //       prefs.clear();
                    //       FirebaseAuth.instance.signOut();
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => LoginScreen()));
                    //     },
                    //     color: Colors.blue,
                    //     shape: new RoundedRectangleBorder(
                    //         borderRadius: new BorderRadius.circular(5.0)),
                    //   ),
                    // )
                  ],
                ))));
  }
}
