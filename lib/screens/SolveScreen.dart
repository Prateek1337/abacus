import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:abacus/screens/ScoreScreen.dart';
import 'package:abacus/Variables.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'HomeScreen.dart';

// import 'package:validator/validator.dart';

// ----------------------------------------------------------------------------------
String currAns;
int finalScore = 0;
TextEditingController finalController;
int quesCount = 0;
String questionTts;
final FlutterTts flutterTts = FlutterTts();
var timerMap = {
  'Free': 1,
  '1': 60,
  '2': 120,
  '3': 180,
  '4': 240,
  '5': 300,
  '6': 360,
  '7': 420,
  '8': 480,
  '9': 540,
  '10': 600,
  '12': 720,
  '15': 900,
  '20': 1200,
  '25': 1500,
  '30': 1800
};
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
      timeInSecForIosWeb: 3,
      backgroundColor:
          identical(text, 'Correct Answer') ? Colors.green : Colors.red,
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
  int _upperNumMax = min(num1, maxMap[_range2.toString()]);
  int num2 =
      max(rng.nextInt(_upperNumMax - _upperNumMin + 1) + _upperNumMin, 2);
  double res = double.parse((num1 / num2).toStringAsFixed(2));
  //this string is for speaking
  questionTts = num1.toString() + ' divided by ' + num2.toString();
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
  questionTts = num1.toString() + ' multiplied by ' + num2.toString();

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
  questionTts = '';
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
  questionTts += res.toString();
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
            '\n' +
            Variables().minusCharacter +
            ' ' +
            _num.toString();
        questionTts += " minus " + _num.toString();
      } else {
        //when result is getting negative but it shouldn't
        res = res + _num;
        question = question + '\n+ ' + _num.toString();
        questionTts += " plus " + _num.toString();
      }
    } else {
      res = res + _num;
      question = question + '\n+ ' + _num.toString();
      questionTts += " plus " + _num.toString();
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

_speak(String text) async {
  flutterTts.stop();
  await flutterTts.speak(text);
  // await flutterTts.speak("1234567 plus 2837");
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
  bool _enabled;
  bool timerVisibility;
  String currQuestion;

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
    // score = finalScore;
    finalController = answerController;
    _playbackSpeed = double.parse(params['speed']);
    flutterTts.setSpeechRate(_playbackSpeed);
    flutterTts.setVolume(1.0);
    flutterTts.setVoice('en-in-x-ahp-local');
    _enabled = true;
    timerVisibility = timerMap[params['time']] != 1;
    currQuestion = callOper();
    _speak(questionTts);
  }

  //function to do generate the sum
  String callOper() {
    List finalres;
    if (oper == 0) {
      finalres = addString(params);
      // _speak(finalres[1]);
      // questionTts = finalres[1];
    } else if (oper == 1) {
      finalres = multiplyString(params);
      // _speak(questionTts);
    } else {
      finalres = divideString(params);
      // _speak(questionTts);
    }

    String result = finalres[0];
    currAns = result;

    return finalres[1];
  }

  String btnText(int noOfTimes) {
    if (noOfTimes >= quesCount) return 'Finish';
    return 'Next';
  }

  void btnFunction(int result) {
    //String answerString = answerController.text;
    // if (answerString == '') checkfornumber and give pop
    // int answer = int.parse(answerString);
    // if (answer == currRes) score++;
    if (noOfTimes >= quesCount) {
      // score = finalScore;
      // finalScore = 0;
      flutterTts.stop();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => (ScoreScreen(
                    user: user,
                    score: score,
                    quesCount: quesCount,
                  ))));
    }
    setState(() {
      // print('\n\nSet State1 Called score=$score , finalscore=$finalScore\n\n');
      finalController.clear();
      answerController.clear();
      noOfTimes++;
      _enabled = true;
      currQuestion = callOper();
      _speak(questionTts);
      score = score;
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Reset':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
        );
        break;
      case 'Finish':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => btnEnd(noOfTimes)),
        );
        break;
    }
  }

  Widget btnEnd(int totalQuestions) {
    // score = finalScore;
    // finalScore = 0;
    flutterTts.stop();
    return (ScoreScreen(
      user: user,
      score: score,
      quesCount: totalQuestions,
    ));
  }

  @override
  void dispose() {
    // score = finalScore;
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
    return WillPopScope(
      onWillPop: () {},
      child: new MaterialApp(
          home: new Scaffold(
              body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/1.jpg"), fit: BoxFit.cover))),
          Container(
            color: Color.fromRGBO(255, 255, 255, 0.6),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Score:" + score.toString(),
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.blue[700],
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                            shape: BoxShape.circle),
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert, color: Colors.blue),
                          onSelected: handleClick,
                          itemBuilder: (BuildContext context) {
                            return {'Reset', 'Finish'}.map((String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(choice),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    ],
                  ),
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
                      color: Color.fromRGBO(235, 235, 252, 0.8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  noOfTimes.toString() + ".",
                                  // textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.blue[700],
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Text(
                                    currQuestion,
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.only(right: 10),
                                  onPressed: () {
                                    _speak(questionTts);
                                  },
                                  icon: Icon(Icons.replay),
                                ),
                                Visibility(
                                  visible: timerVisibility,
                                  child: CircularCountDownTimer(
                                    // Countdown duration in Seconds
                                    duration: timerMap[params['time']],
                                    // Controller to control (i.e Pause, Resume, Restart) the Countdown
                                    controller: CountDownController(),

                                    // Width of the Countdown Widget
                                    width:
                                        MediaQuery.of(context).size.width / 7,

                                    // Height of the Countdown Widget
                                    height:
                                        MediaQuery.of(context).size.height / 7,

                                    // Default Color for Countdown Timer
                                    color: Color.fromRGBO(235, 235, 252, 0.8),

                                    // Filling Color for Countdown Timer
                                    fillColor: Colors.blue[200],

                                    // Background Color for Countdown Widget
                                    backgroundColor: Colors.blue[500],

                                    // Border Thickness of the Countdown Circle
                                    strokeWidth: 10.0,

                                    // Begin and end contours with a flat edge and no extension
                                    strokeCap: StrokeCap.round,

                                    // Text Style for Countdown Text
                                    textStyle: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),

                                    // true for reverse countdown (max to 0), false for forward countdown (0 to max)
                                    isReverse: true,

                                    // true for reverse animation, false for forward animation
                                    isReverseAnimation: true,

                                    // Optional [bool] to hide the [Text] in this widget.
                                    isTimerTextShown: true,

                                    // Function which will execute when the Countdown Ends
                                    onComplete: () {
                                      // Here, do whatever you wan
                                      print('\n\nCountdown Ended\n\n');
                                      if (timerVisibility) {
                                        // score = finalScore;
                                        // finalScore = 0;
                                        flutterTts.stop();
                                        showDialog<void>(
                                          context: context,
                                          barrierDismissible:
                                              false, // user must tap button!
                                          builder: (BuildContext context) {
                                            return WillPopScope(
                                              onWillPop: () async => false,
                                              child: AlertDialog(
                                                title: Text('Times Up!'),
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      Text(
                                                          'Press continue to see your score.'),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text('Continue'),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  (ScoreScreen(
                                                                    user: user,
                                                                    score:
                                                                        score,
                                                                    quesCount:
                                                                        quesCount,
                                                                  ))));
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
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
                            RaisedButton(
                              onPressed: !_enabled
                                  ? null
                                  : () {
                                      if (_enabled) {
                                        String toMatchRes =
                                            finalController.text;
                                        if (isNumeric(toMatchRes)) {
                                          if (toMatchRes == currAns) {
                                            score++;
                                            showtoast('Correct Answer');
                                            //_isButtonDisabled = true;
                                          } else {
                                            showtoast(
                                                'Wrong Answer \n Correct Answer is ' +
                                                    currAns);
                                            //_isButtonDisabled = true;
                                          }
                                          setState(() {
                                            print('\n\nsetState2 called\n\n');
                                            _enabled = !_enabled;
                                          });
                                        } else {
                                          showtoast('Enter a Valid Number');
                                        }
                                      } else {
                                        showtoast("disabled");
                                        return null;
                                      }
                                    },
                              child: Text(
                                'Check Answer',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                              color: Theme.of(context).accentColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: RawMaterialButton(
                    shape: CircleBorder(

                        // borderRadius: BorderRadius.circular(500.0),
                        // side: BorderSide(color: Colors.red)
                        ),
                    onPressed: () => btnFunction(score),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_forward_rounded,
                          color: Colors.blue, size: 40),
                    ),
                    // Text(
                    //   btnText(noOfTimes),
                    //   style: TextStyle(
                    //       fontSize: 20.0,
                    //       fontWeight: FontWeight.normal,
                    //       color: Colors.white),
                    // ),
                    fillColor: Color.fromRGBO(255, 255, 255, 0.8),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ))),
    );
  }
}

// class ButtonWidget extends StatefulWidget  {
//   @override
//   _OneClickDisabledButton createState() => _OneClickDisabledButton();
// }

// class _OneClickDisabledButton extends State<ButtonWidget> {
//   bool _enabled = true;
//   void showtoast(String text, bool isGreen) {
//     Fluttertoast.showToast(
//         msg: text,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.TOP,
//         timeInSecForIosWeb: 1,
//         backgroundColor: isGreen ? Colors.green : Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }

//   Function checkAnswer(String toMatchRes) {
//     if (isNumeric(toMatchRes)) {
//       if (toMatchRes == currAns) {
//         finalScore++;
//         showtoast('Correct Answer', true);
//         //_isButtonDisabled = true;
//       } else {
//         showtoast('Wrong Answer \n Correct Answer is ' + currAns, false);
//         //_isButtonDisabled = true;
//       }
//       setState(() => {_enabled = !_enabled});
//     } else {
//       showtoast('Enter a Valid Number', false);
//     }

//     // print('button value is  ' + _isButtonDisabled.toString());
//     // setState(() {});
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return RaisedButton(
//       onPressed: !_enabled
//           ? null
//           : () {
//               if (_enabled) {
//                 checkAnswer(finalController.text);
//               } else {
//                 showtoast("disabled", false);
//                 return null;
//               }
//             },
//       child: Text(
//         'Check Answer',
//         style: TextStyle(
//             fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.white),
//       ),
//       color: Theme.of(context).accentColor,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
//     );
//   }
// }
