import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:abacus/screens/ScoreScreen.dart';
import 'package:abacus/Variables.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'HomeScreen.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:abacus/screens/ad_manager.dart';
import 'package:abacus/widgets/drawer.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';
import 'package:abacus/screens/LevelsLogic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

// import 'package:validator/validator.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart';

// ----------------------------------------------------------------------------------
String currAns;
int finalScore = 0;
int quesCount = 10;
// String questionTts;
List<String> questionTtsList;
final FlutterTts flutterTts = FlutterTts();
var timerMap = {
  '0': 1,
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
  '1': 1,
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
  // questionTts = num1.toString() + ' divided by ' + num2.toString();
  questionTtsList.addAll([num1.toString(), 'divided by', num2.toString()]);
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
  // questionTts = num1.toString() + ' multiplied by ' + num2.toString();
  questionTtsList.addAll([num1.toString(), 'multiplied by', num2.toString()]);

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
// List addString(var params) {
//   // questionTts = '';
//   int _numberOfValues = params['numberOfValues'],
//       _numberOfQuestions = params['numberOfQuestions'],
//       _range1 = params['range1'],
//       _range2 = params['range2'];
//   quesCount = _numberOfQuestions;
//   bool _valueIsPos = params['valIsPos'], _ansIsPos = params['ansIsPos'];
//   int _lowerNum = minMap[_range1.toString()];
//   int _upperNum = maxMap[_range2.toString()];

//   int res = rng.nextInt(_upperNum - _lowerNum + 1) + _lowerNum;
//   String question = res.toString();
//   // questionTts += res.toString();
//   questionTtsList.add(res.toString());
//   for (int i = 0; i < _numberOfValues - 1; i++) {
//     int _num = rng.nextInt(_upperNum - _lowerNum + 1) + _lowerNum;
//     int sign = rng.nextInt(2);
//     // 0 for sub and 1 for add
//     if (_valueIsPos == false && sign == 0) {
//       //when subtraction is allowed
//       if ((_ansIsPos == true && res - _num >= 0) || _ansIsPos == false) {
//         //when result is positive or negative result is allowed
//         res = res - _num;
//         question = question +
//             '\n' +
//             Variables().minusCharacter +
//             ' ' +
//             _num.toString();
//         // questionTts += " minus " + _num.toString();
//         questionTtsList.addAll([
//           "minus",
//           _num.toString(),
//         ]);
//       } else {
//         //when result is getting negative but it shouldn't
//         res = res + _num;
//         question = question + '\n ' + _num.toString();
//         // questionTts += " plus " + _num.toString();
//         questionTtsList.addAll([
//           // "plus",
//           _num.toString(),
//         ]);
//       }
//     } else {
//       res = res + _num;
//       question = question + '\n ' + _num.toString();
//       // questionTts += " plus " + _num.toString();
//       questionTtsList.addAll([
//         // "plus",
//         _num.toString(),
//       ]);
//     }
//   }

//   return [res.toString(), question];
// }

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

// speaks each word sequentially
_speakList(List<String> texts) async {
  int i = 0;
  await flutterTts.speak(texts[i]);
  // print("\n\n\n\n\n\n" + texts.length.toString());
  flutterTts.setCompletionHandler(() async {
    if (i < texts.length - 1) {
      i++;

      await flutterTts.speak(texts[i]);
    }
  });
}

// ----------------------------------------------------------------------------------

Future _stop() async {
  if (flutterTts != null) await flutterTts.stop();
}

class SolveApp extends StatefulWidget {
  final int numdig, oper, noOfTimes, score, level;
  final String user;
  var params;

  SolveApp({
    this.user,
    this.numdig,
    this.oper,
    this.noOfTimes,
    this.score,
    this.params,
    this.level,
  });
  @override
  _SolveAppState createState() => new _SolveAppState(
      user: user,
      numdig: numdig,
      oper: oper,
      noOfTimes: noOfTimes,
      score: score,
      level: level,
      params: params);
}

class _SolveAppState extends State<SolveApp> {
// class SolveApp extends StatelessWidget {
  int numdig, oper, noOfTimes, score, level;
  final String user;
  final _finalController = TextEditingController();

  var params;
  double _playbackSpeed;
  bool _enabled, _valueIsPos, _isautoCorrect;
  bool timerVisibility, isDataLoaded = false;
  String currQuestion, _time;

  // _isbutton
  _SolveAppState({
    @required this.user,
    this.numdig,
    this.oper,
    this.noOfTimes,
    this.score,
    this.level,
    this.params,
  });
  String sumtext = '';

  /*
  CODE FOR SPEECH TO TEXT
  --------------------------------------------------------------------------------------------------------
  */

  // stt.SpeechToText _speech;
  // bool _isListening = false;
  // String _text = 'Press the button and start speaking';
  // bool speakingBoolBtnGlow = false;
  IconData speakingBtnIcon = Icons.mic_none;
  // void setMicButtonState() {
  //   setState(() {
  //     _isListening = false;
  //     speakingBoolBtnGlow = false;
  //     speakingBtnIcon = Icons.mic_none;
  //   });
  // }

  // void _listen() async {
  //   if (_isListening == false) {
  //     bool available = await _speech.initialize(
  //       onStatus: (val) => {
  //         if (val == "notListening")
  //           {
  //             setMicButtonState(),
  //           },
  //         // print('onStatus: $val'),
  //       },
  //       onError: (val) => print('onError: $val'),
  //     );
  //     if (available) {
  //       setState(() => _isListening = true);
  //       _speech.listen(
  //         listenFor: Duration(seconds: 10),
  //         onResult: (val) => setState(() {
  //           _text = val.recognizedWords;
  //           _text = _text.replaceAll(new RegExp(r"\s+"), "");
  //           _finalController.text = _text;
  //         }),
  //       );
  //     }
  //   } else {
  //     setState(() => _isListening = false);
  //     _speech.stop();
  //     setMicButtonState();
  //   }
  // }

  // void stopListening() {
  //   _speech.stop();
  // }
  bool _hasSpeech = false;
  double levelSpeech = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastWords = '';
  String lastError = '';
  String lastStatus = '';
  String _currentLocaleId = '';
  // int resultListened = 0;
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  Future<void> initSpeechState() async {
    // print('init state getting called');
    var hasSpeech = await speech.initialize(
        onError: errorListener, onStatus: statusListener, debugLogging: true);
    // if (hasSpeech) {
    //   _localeNames = await speech.locales();
    //   var systemLocale = await speech.systemLocale();
    //   _currentLocaleId = systemLocale.localeId;
    // }
    // print('value of haspeech after initilization' + hasSpeech.toString());
    if (!mounted) return;

    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    // print("Received error status: $error, listening: ${speech.isListening}");
    cancelListening();
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    // print(
    //     'Received listener status: $status, listening: ${speech.isListening}');
    setState(() {
      lastStatus = '$status';
    });

    // print('calling status listener');
    // if (speech.isListening == false || lastStatus == "notListening") {
    //   setState(() {
    //     speakingBtnIcon = Icons.mic_none;
    //   });
    // }
    // if (lastStatus == "notListening" && speech.isListening) {
    //   print('stopping');
    //   stopListening();
    // }
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      levelSpeech = 0.0;
    });
  }

  void stopListening() {
    speech.stop();
    setState(() {
      levelSpeech = 0.0;
    });
  }

  void startListening() {
    // print('this is being called');
    lastWords = '';
    lastError = '';
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 5),
        // pauseFor: Duration(seconds: 5),
        partialResults: false,
        // localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void resultListener(SpeechRecognitionResult result) {
    // ++resultListened;
    // print('Result listener $resultListened');
    // print('long statement resultlistener');
    setState(() {
      lastWords = '${result.recognizedWords}';
      lastWords = lastWords.replaceAll(new RegExp(r"\s+"), "");
      _finalController.text = lastWords;
      // print('last words are ' + lastWords);
      if (speech.isListening == false) {
        speakingBtnIcon = Icons.mic_none;
      }
    });
  }

  void soundLevelListener(double levelSpeech) {
    minSoundLevel = min(minSoundLevel, levelSpeech);
    maxSoundLevel = max(maxSoundLevel, levelSpeech);
    // print("sound level $level: $minSoundLevel - $maxSoundLevel ");
    setState(() {
      this.levelSpeech = levelSpeech;
    });
  }

  /*
  CODE FOR SPEECH TO TEXT END
  --------------------------------------------------------------------------------------------------------
  */
  Future _loadShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _playbackSpeed = (prefs.getDouble("speed") ?? 1.0);
      _time = (prefs.getInt("time") ?? 1).toString();
      _valueIsPos = (prefs.getBool("onlyPositive") ?? false);
      _isautoCorrect = (prefs.getBool("autoCorrect") ?? false);
      print("\n\n\n Shared : $_playbackSpeed,$_time,$_valueIsPos\n\n\n");
    });
    print(" solve screen Shared loaded");
    timerVisibility = timerMap[_time] != 1;
    print('_time:$_time');
    isDataLoaded = true;
  }

  void checkAnswer() {
    // stopListening();
    String toMatchRes = _finalController.text;
    if (isNumeric(toMatchRes)) {
      if (double.parse(toMatchRes) == double.parse(currAns)) {
        score++;
        showtoast('Correct Answer');
        // playSound(1);
        Timer(Duration(milliseconds: 300), () {
          btnFunction(score);
        });

        //_isButtonDisabled = true;
      } else {
        showtoast('Wrong Answer \n Correct Answer is ' + currAns.toString());
        // playSound(0);
        Timer(Duration(milliseconds: 300), () {
          btnFunction(score);
        });
        //_isButtonDisabled = true;
      }
    } else {
      showtoast('Enter a Valid Number');
      _finalController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadShared();

    // _playbackSpeed = 1.0;
    // _time = "1";
    // _valueIsPos = true;
    // questionTtsList = [];
    // score = finalScore;
    _finalController.clear();
    _finalController.addListener(() {
      String text = _finalController.text;
      if (text.isNotEmpty && isNumeric(text) && _isautoCorrect) {
        print("Text=$text");
        if (text.length == currAns.length) {
          checkAnswer();
        }
      } else if (text.isNotEmpty && _isautoCorrect) {
        showtoast('Enter a Valid Number');
        _finalController.clear();
      }
    });
    if (params != null) {
      quesCount = params['numberOfQuestions'];
    }
    // _playbackSpeed = double.parse(params['speed']);
    flutterTts.setSpeechRate(_playbackSpeed);
    flutterTts.setVolume(1.0);
    flutterTts.setVoice('en-in-x-ahp-local');
    _enabled = true;
    print('time:$_time');
    currQuestion = callOper(_valueIsPos);
    // print("\n\n\n\n question: $questionTtsList\n\n");
    _speakList(questionTtsList);
    _initAdMob();
    _bannerAd = BannerAd(
      adUnitId: AdManager.SolveScreenbannerAdUnitId,
      size: AdSize.banner,
    );
    _loadBannerAd();
    // _stop();
    // if (!_hasSpeech) initSpeechState();
    // speech = new SpeechToText();
    if (_hasSpeech == false) initSpeechState();
  }

  //function to do generate the sum
  String callOper(bool _valueIsPos) {
    List finalres;
    questionTtsList = [];
    LevelsLogic levelinfo = LevelsLogic(_valueIsPos);
    if (oper == 0) {
      if (level != null) {
        finalres = levelinfo.addStringLevel(level);
      } else {
        finalres = levelinfo.addStringCustom(params);
      }
      // finalres = addString(params);
      questionTtsList = finalres[2];
      // _speak(finalres[1]);
      // questionTts = finalres[1];
    } else if (oper == 1) {
      if (level != null) {
        finalres = levelinfo.multiplyStringLevel(level);
      } else {
        finalres = levelinfo.multiplyStringCustom(params);
      }
      // finalres = multiplyString(params);
      questionTtsList = finalres[2];
      // _speak(questionTts);
    } else if (oper == 2) {
      if (level != null) {
        finalres = levelinfo.divideStringLevel(level);
      } else {
        finalres = levelinfo.divideStringCustom(params);
      }
      // finalres = multiplyString(params);
      questionTtsList = finalres[2];
      // _speak(questionTts);
    } else {
      finalres = levelinfo.speedRunLevel(level);
      questionTtsList = finalres[2];
    }

    currAns = finalres[0];

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
      // _bannerAd?.dispose();
      try {
        _bannerAd?.dispose();
        _bannerAd = null;
      } catch (ex) {
        print("banner dispose error");
      }
      flutterTts.stop();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => (ScoreScreen(
                    user: user,
                    score: score,
                    quesCount: quesCount,
                  ))));
    } else {
      setState(() {
        // _bannerAd?.dispose();
        // try {
        //   _bannerAd?.dispose();
        //   _bannerAd = null;
        // } catch (ex) {
        //   print("banner dispose error");
        // }
        // print('\n\nSet State1 Called score=$score , finalscore=$finalScore\n\n');
        _finalController.clear();
        _finalController.removeListener(() {});
        noOfTimes++;
        _enabled = true;
        currQuestion = callOper(_valueIsPos);
        _speakList(questionTtsList);
        score = score;
      });
    }
  }

  void handleClick(String value) {
    switch (value) {
      case 'Reset':
        // _bannerAd?.dispose();
        try {
          _bannerAd?.dispose();
          _bannerAd = null;
        } catch (ex) {
          print("banner dispose error");
        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
        );
        break;
      case 'Finish':
        // _bannerAd?.dispose();
        try {
          _bannerAd?.dispose();
          _bannerAd = null;
        } catch (ex) {
          print("banner dispose error");
        }
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
    // _bannerAd?.dispose();
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

  Widget _builder(BuildContext context, VirtualKeyboardKey key) {
    Widget keyWidget;
    print("key pressed");
    switch (key.keyType) {
      case VirtualKeyboardKeyType.String:
        // Draw String key.
        keyWidget = _keyWidget(key);
        break;
      case VirtualKeyboardKeyType.Action:
        // Draw action key.
        keyWidget = _keyWidget(key);
        break;
    }
    setState(() {});

    return null;
  }

  Widget _keyWidget(key) {
    print("key pressed");
    return Card(
      child: Text(key.text),
      elevation: 20,
      color: Colors.red,
    );
  }

  void addKey(String key) {
    _finalController.text += key;
  }

  void _onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      addKey(key.text);
      setState(() {});
    } else if (VirtualKeyboardKeyAction.Backspace == key.action) {
      if (_finalController.text.length == 0) return;
      _finalController.text =
          _finalController.text.substring(0, _finalController.text.length - 1);
    }
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
    void playSound(int i) {
      //create a new player
      var assetsAudioPlayer = AssetsAudioPlayer();
      if (i == 1) {
        assetsAudioPlayer.open(
          Audio("audios/rightAnswer.mp3"),
        );
      } else {
        assetsAudioPlayer.open(
          Audio("audios/wrongAnswer.mp3"),
        );
      }
      assetsAudioPlayer.play();
    }

    if (isDataLoaded == false) {
      return WillPopScope(
          child: new MaterialApp(
              home: new Scaffold(
            body: Container(
              color: Colors.lightBlue,
              child: Center(
                child: Loading(
                    indicator: BallPulseIndicator(),
                    size: 100.0,
                    color: Colors.black),
              ),
            ),
          )),
          onWillPop: () {});
    } else {
      return WillPopScope(
        onWillPop: () {},
        child: new MaterialApp(
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
                    SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 30.0, left: 12, right: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.7),
                                          shape: BoxShape.circle),
                                      child: PopupMenuButton<String>(
                                        icon: Icon(Icons.more_vert,
                                            color: Colors.blue),
                                        onSelected: handleClick,
                                        itemBuilder: (BuildContext context) {
                                          return {'Reset', 'Finish'}
                                              .map((String choice) {
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                noOfTimes.toString() + ".",
                                                // textAlign: TextAlign.center,
                                                style: new TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.blue[700],
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  currQuestion,
                                                  textAlign: TextAlign.center,
                                                  style: new TextStyle(
                                                      fontSize: 16.0),
                                                ),
                                              ),
                                              IconButton(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                onPressed: () {
                                                  _speakList(questionTtsList);
                                                },
                                                icon: Icon(Icons.replay),
                                              ),
                                              Visibility(
                                                visible: timerVisibility,
                                                child: CircularCountDownTimer(
                                                  // Countdown duration in Seconds
                                                  duration: timerMap[_time],
                                                  // Controller to control (i.e Pause, Resume, Restart) the Countdown
                                                  controller:
                                                      CountDownController(),

                                                  // Width of the Countdown Widget
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      7,

                                                  // Height of the Countdown Widget
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      7,

                                                  // Default Color for Countdown Timer
                                                  color: Color.fromRGBO(
                                                      235, 235, 252, 0.8),

                                                  // Filling Color for Countdown Timer
                                                  fillColor: Colors.blue[200],

                                                  // Background Color for Countdown Widget
                                                  backgroundColor:
                                                      Colors.blue[500],

                                                  // Border Thickness of the Countdown Circle
                                                  strokeWidth: 10.0,

                                                  // Begin and end contours with a flat edge and no extension
                                                  strokeCap: StrokeCap.round,

                                                  // Text Style for Countdown Text
                                                  textStyle: TextStyle(
                                                      fontSize: 10.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),

                                                  // true for reverse countdown (max to 0), false for forward countdown (0 to max)
                                                  isReverse: true,

                                                  // true for reverse animation, false for forward animation
                                                  isReverseAnimation: true,

                                                  // Optional [bool] to hide the [Text] in this widget.
                                                  isTimerTextShown: true,

                                                  // Function which will execute when the Countdown Ends
                                                  onComplete: () {
                                                    // Here, do whatever you wan
                                                    print(
                                                        '\n\nCountdown Ended\n\n');
                                                    if (timerVisibility) {
                                                      // score = finalScore;
                                                      // finalScore = 0;
                                                      flutterTts.stop();
                                                      showDialog<void>(
                                                        context: context,
                                                        barrierDismissible:
                                                            false, // user must tap button!
                                                        builder: (BuildContext
                                                            context) {
                                                          return WillPopScope(
                                                            onWillPop:
                                                                () async =>
                                                                    false,
                                                            child: AlertDialog(
                                                              title: Text(
                                                                  'Times Up!'),
                                                              content:
                                                                  SingleChildScrollView(
                                                                child: ListBody(
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                        'Press continue to see your score.'),
                                                                  ],
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: Text(
                                                                      'Continue'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => (ScoreScreen(
                                                                                  user: user,
                                                                                  score: score,
                                                                                  quesCount: quesCount,
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
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 5,
                                                child: Container(
                                                  // width: 400,
                                                  height: 50,
                                                  color: Colors.white,
                                                  child: TextField(
                                                      onChanged: (text) {
                                                        print("Text=$text");
                                                        if (text.length ==
                                                            currAns
                                                                .toString()
                                                                .length) {
                                                          checkAnswer();
                                                        }
                                                      },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      readOnly: true,
                                                      // inputFormatters: [
                                                      //   FilteringTextInp utFormatter.allow(
                                                      //       RegExp(r'[0-9-]')),
                                                      //   //LengthLimitingTextInputFormatter(1),
                                                      // ],
                                                      controller:
                                                          _finalController,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            "Enter Your Answer",
                                                        border:
                                                            OutlineInputBorder(),
                                                      )),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  child: AvatarGlow(
                                                    // animate: _isListening,
                                                    glowColor: Theme.of(context)
                                                        .primaryColor,
                                                    endRadius: 75.0,
                                                    duration: const Duration(
                                                        milliseconds: 2000),
                                                    repeatPauseDuration:
                                                        const Duration(
                                                            milliseconds: 100),
                                                    // repeat: speakingBoolBtnGlow,
                                                    child: FloatingActionButton(
                                                      onPressed: !_hasSpeech ||
                                                              speech.isListening
                                                          ? () => {
                                                                print('THIS SHOULD NOT HAVE PRINTED, IT MEANS WE FUCKED UP andhasspeech is ' +
                                                                    _hasSpeech
                                                                        .toString() +
                                                                    'and speech.islistining is ' +
                                                                    (speech.isListening)
                                                                        .toString()),
                                                                setState(() {
                                                                  // speakingBoolBtnGlow =
                                                                  //     true;
                                                                  speakingBtnIcon =
                                                                      Icons
                                                                          .mic_none;
                                                                  speech
                                                                      .cancel();
                                                                }),
                                                              }
                                                          : () => {
                                                                setState(() {
                                                                  // speakingBoolBtnGlow =
                                                                  //     true;
                                                                  speakingBtnIcon =
                                                                      Icons.mic;
                                                                }),
                                                                startListening(),
                                                              },
                                                      child:
                                                          Icon(speakingBtnIcon),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 24),
                                          RaisedButton(
                                            onPressed: () {
                                              checkAnswer();
                                            },
                                            child: Text(
                                              'Check Answer',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white),
                                            ),
                                            color:
                                                Theme.of(context).accentColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          ),
                                          SizedBox(height: 16),
                                          Container(
                                            // Keyboard is transparent
                                            child: VirtualKeyboard(
                                                // [0-9] + .
                                                fontSize: 30,
                                                builder: _builder,
                                                textColor: Colors.blue,
                                                type:
                                                    VirtualKeyboardType.Numeric,
                                                height: 220,
                                                // Callback for key press event
                                                onKeyPress: _onKeyPress),
                                          ),
                                          TextButton(
                                              onPressed: () => {addKey('-')},
                                              style: TextButton.styleFrom(
                                                  primary: Colors.blue),
                                              child: Text('-',
                                                  style:
                                                      TextStyle(fontSize: 25)))
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ))),
      );
    }
  }
}
