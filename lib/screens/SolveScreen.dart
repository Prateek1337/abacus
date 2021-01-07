import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:abacus/screens/ScoreScreen.dart';
import 'package:abacus/Variables.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'HomeScreen.dart';

// import 'package:validator/validator.dart';

// ----------------------------------------------------------------------------------
String currAns;
int finalScore = 0;
TextEditingController finalController;
int quesCount = 0;
String questionTts;
// main logic
var maxMap = {
  '1': 9,
  '2': 99,
  '3': 999,
  '4': 9999,
  '5': 99999,
  '6': 999999,
  '7': 9999999,
};
var minMap = {
  '0': 0,
  '1': 0,
  '2': 10,
  '3': 100,
  '4': 1000,
  '5': 10000,
  '6': 100000,
  '7': 1000000
};
var rng = new Random();
void showtoast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

List divideString(var params) {
  int _range1 = params['range1'],
      _range2 = params['range2'],
      _numberOfQuestions = params['numberOfQuestions'];
  quesCount = _numberOfQuestions;

  int _lowerNumMin = minMap[_range1.toString()];
  int _lowerNumMax = maxMap[_range1.toString()];
  int num1 = rng.nextInt(_lowerNumMax - _lowerNumMin + 1) + _lowerNumMin;
  int _upperNumMin = minMap[_range2.toString()];
  int _upperNumMax = num1;
  int num2 = rng.nextInt(_upperNumMax - _upperNumMin + 1) + _upperNumMin;
  double res = double.parse((num1 / num2).toStringAsFixed(2));
  return [
    res.toString(),
    num1.toString() + Variables().divideCharacter + num2.toString()
  ];
}

List multiplyString(var params) {
  int _range1 = params['range1'],
      _range2 = params['range2'],
      _numberOfQuestions = params['numberOfQuestions'];
  print(_numberOfQuestions);
  quesCount = _numberOfQuestions;

  int _lowerNumMin = minMap[_range1.toString()];
  int _upperNumMin = minMap[_range2.toString()];
  int _lowerNumMax = maxMap[_range1.toString()];
  int _upperNumMax = maxMap[_range2.toString()];
  //generic algo to generate random number between min and max.
  int num1 = rng.nextInt(_lowerNumMax - _lowerNumMin + 1) + _lowerNumMin;
  int num2 = rng.nextInt(_upperNumMax - _upperNumMin + 1) + _upperNumMin;
  int res = num1 * num2;
  return [
    res.toString(),
    num1.toString() + Variables().multiplyCharacter + num2.toString()
  ];
}

/*
_numberOfValues = number of numbers in a sum
_range1 = min number of digits in the sum
_range2 = max number of digits in the sum
_valueIsPos = each number will be positive if it is 1
_ansIsPos = intermediate and final result will be positive if 1
*/
List addString(var params) {
  int _numberOfValues = params['numberOfValues'],
      _numberOfQuestions = params['numberOfQuestions'],
      _range1 = params['range1'],
      _range2 = params['range2'];
  quesCount = _numberOfQuestions;
  bool _valueIsPos = params['valIsPos'], _ansIsPos = params['ansIsPos'];
  int _lowerNum = minMap[_range1.toString()];
  int _upperNum = maxMap[_range2.toString()];

  int res = rng.nextInt(_upperNum - _lowerNum + 1) + _lowerNum;
  String question = res.toString();

  for (int i = 0; i < _numberOfValues - 1; i++) {
    int _num = rng.nextInt(_upperNum - _lowerNum + 1) + _lowerNum;
    int sign = rng.nextInt(2);
    // 0 for sub and 1 for add
    if (_valueIsPos == false && sign == 0) {
      //when subtraction is allowed
      if ((_ansIsPos == true && res - _num >= 0) || _ansIsPos == false) {
        //when result is positive or negative result is allowed
        res = res - _num;
        question = question +
            "\n" +
            Variables().minusCharacter +
            ' ' +
            _num.toString();
      } else {
        //when result is getting negative but it shouldn't
        res = res + _num;
        question = question + '\n+ ' + _num.toString();
      }
    } else {
      res = res + _num;
      question = question + '\n+ ' + _num.toString();
    }
  }

  return [res.toString(), question];
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

final FlutterTts flutterTts = FlutterTts();

_speak(String text) async {
  flutterTts.stop();
  await flutterTts.speak(text);
}

// ----------------------------------------------------------------------------------

class SolveApp extends StatefulWidget {
  final int numdig, oper, noOfTimes, score;
  final String user;
  var params;

  SolveApp({
    this.user,
    this.numdig,
    this.oper,
    this.noOfTimes,
    this.score,
    this.params,
  });
  @override
  _SolveAppState createState() => new _SolveAppState(
      user: user,
      numdig: numdig,
      oper: oper,
      noOfTimes: noOfTimes,
      score: score,
      params: params);
}

class _SolveAppState extends State<SolveApp> {
// class SolveApp extends StatelessWidget {
  int numdig, oper, noOfTimes, score;
  final String user;
  var params;
  double _playbackSpeed;

  // _isbutton
  TextEditingController answerController = TextEditingController();
  _SolveAppState({
    @required this.user,
    this.numdig,
    this.oper,
    this.noOfTimes,
    this.score,
    this.params,
  });
  String sumtext = '';

  @override
  void initState() {
    super.initState();
    score = finalScore;
    finalController = answerController;
    _playbackSpeed = double.parse(params['speed']);
    flutterTts.setSpeechRate(_playbackSpeed);
    flutterTts.setVolume(1.0);
  }

  //function to do generate the sum
  String callOper() {
    List finalres;
    if (oper == 0) {
      finalres = addString(params);
    } else if (oper == 1) {
      finalres = multiplyString(params);
    } else {
      finalres = divideString(params);
    }
    String result = finalres[0];
    questionTts = finalres[1];
    currAns = result;

    _speak(questionTts);
    return questionTts;
  }

  String btnText(int noOfTimes) {
    if (noOfTimes >= quesCount) return 'Finish';
    return 'Next';
  }

  Widget btnFunction(int noOfTimes, int result) {
    //String answerString = answerController.text;
    // if (answerString == '') checkfornumber and give pop
    // int answer = int.parse(answerString);
    // if (answer == currRes) score++;
    if (noOfTimes >= quesCount) {
      score = finalScore;
      finalScore = 0;
      flutterTts.stop();
      return (ScoreScreen(
        user: user,
        score: score,
        quesCount: quesCount,
      ));
    }

    return (SolveApp(
      user: user,
      numdig: numdig,
      oper: oper,
      noOfTimes: noOfTimes + 1,
      score: score,
      params: params,
    ));
  }

  @override
  void dispose() {
    score = finalScore;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Function testfun() {
    //   setState(() {
    //     _isButtonDisabled = true;
    //   });
    // }
    //var _enabled = true;
    // var _onpressed;
    // if (_isButtonDisabled) {
    //   _onpressed = () {
    //     testfun();
    //   };
    // }
    return new MaterialApp(
        home: new Scaffold(
            body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Question No:" + noOfTimes.toString(),
                textAlign: TextAlign.center,
                style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Score:" + score.toString(),
                textAlign: TextAlign.center,
                style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        new Container(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                color: Colors.blue[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              callOper(),
                              textAlign: TextAlign.center,
                              style: new TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                _speak(questionTts);
                              },
                              icon: Icon(Icons.replay),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: 300,
                        color: Colors.white,
                        child: TextField(
                            keyboardType: TextInputType.number,
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.allow(
                            //       RegExp(r'[0-9-]')),
                            //   //LengthLimitingTextInputFormatter(1),
                            // ],
                            controller: answerController,
                            decoration: InputDecoration(
                              labelText: "Enter Your Answer",
                              border: OutlineInputBorder(),
                            )),
                      ),
                      SizedBox(height: 24),
                      new ButtonWidget(),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RaisedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
              ),
              child: Text(
                'Reset',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
            RaisedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => btnFunction(noOfTimes, score)),
              ),
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
          ],
        ),
      ],
    )));
  }
}

class ButtonWidget extends StatefulWidget {
  @override
  _OneClickDisabledButton createState() => _OneClickDisabledButton();
}

class _OneClickDisabledButton extends State<ButtonWidget> {
  bool _enabled = true;
  void showtoast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Function checkAnswer(String toMatchRes) {
    if (isNumeric(toMatchRes)) {
      if (toMatchRes == currAns) {
        finalScore++;
        showtoast('correct Answer');
        //_isButtonDisabled = true;
      } else {
        showtoast('Wrong Answer');
        //_isButtonDisabled = true;
      }
      setState(() => {_enabled = !_enabled});
    } else {
      showtoast('Enter a Valid Number');
    }

    // print('button value is  ' + _isButtonDisabled.toString());
    // setState(() {});
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: !_enabled
          ? null
          : () {
              if (_enabled) {
                checkAnswer(finalController.text);
              } else {
                showtoast("disabled");
                return null;
              }
            },
      child: Text(
        'Check Answer',
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.white),
      ),
      color: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
