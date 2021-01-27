//TODO: validation   of _range1 and _range2, _range1>=range2>0 and not empty and number

// import 'package:abacus/screens/LoginScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:math';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:abacus/screens/ScoreScreen.dart';
import 'package:abacus/screens/SolveScreen.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:math';

class MultiplicationScreen extends StatefulWidget {
  final String user;

  MultiplicationScreen({this.user});

  @override
  _MultiplicationScreenState createState() =>
      new _MultiplicationScreenState(user: user);
}

class _MultiplicationScreenState extends State<MultiplicationScreen> {
  List<String> _speed = [
    '0.25',
    '0.5',
    '0.75',
    '1.0',
    '1.25',
    '1.5',
    '1.75',
    '2.0',
  ];
  List<String> _time = [
    'Free',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '12',
    '15',
    '20',
    '25',
    '30'
  ];
  String _selectedSpeed = '1.0';
  String _selectedTime = 'Free';
  TextEditingController _range1, _range2, _numberOfQuestions;
  int tempzero = 0;
  int _isOperation = 1;
  final String user;
  _MultiplicationScreenState({
    @required this.user,
  });

  void initState() {
    super.initState();
    _range1 = TextEditingController();
    _range2 = TextEditingController();
    _numberOfQuestions = TextEditingController();
  }

  void dispose() {
    _range1.dispose();
    _range2.dispose();
    _numberOfQuestions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text("Multiplication & Division Setting"),
            ),
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
                new Center(
                    child: SingleChildScrollView(
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
                      child: new Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          direction: Axis.vertical,
                          children: <Widget>[
                            new Text(
                              'Select the range of the digits',
                              style: new TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            new SizedBox(
                              height: 16,
                            ),
                            new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    color: Colors.white,
                                    width: 120,
                                    child: new TextField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(1),
                                        CustomRangeTextInputFormatter3(),
                                      ],
                                      controller: _range1,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          labelText: "Range start",
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    width: 120,
                                    child: new TextField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(1),
                                        CustomRangeTextInputFormatter3()
                                      ],
                                      controller: _range2,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          labelText: "Range end",
                                          border: OutlineInputBorder()),
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: 250,
                              color: Colors.white,
                              child: new TextField(
                                keyboardType: TextInputType.number,
                                maxLength: 3,
                                buildCounter: (BuildContext context,
                                        {int currentLength,
                                        int maxLength,
                                        bool isFocused}) =>
                                    null,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CustomRangeTextInputFormatter2(),
                                ],
                                controller: _numberOfQuestions,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    labelText: "Enter Number of Questions",
                                    hintText: "should be between 1-100",
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),

                            Row(
                              children: [
                                Text('Speed',
                                    style: TextStyle(
                                        fontSize: 18, color: (Colors.blue))),
                                SizedBox(
                                  width: 5,
                                ),
                                DropdownButton(
                                  value: _selectedSpeed,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedSpeed = newValue;
                                    });
                                  },
                                  items: _speed.map((speed) {
                                    return DropdownMenuItem(
                                      child: new Text(speed),
                                      value: speed,
                                    );
                                  }).toList(),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('Timer',
                                    style: TextStyle(
                                        fontSize: 18, color: (Colors.blue))),
                                SizedBox(
                                  width: 5,
                                ),
                                DropdownButton(
                                  value: _selectedTime,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedTime = newValue;
                                    });
                                  },
                                  items: _time.map((time) {
                                    return DropdownMenuItem(
                                      child: new Text(time),
                                      value: time,
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Radio(
                                  value: 1,
                                  groupValue: _isOperation,
                                  onChanged: (int value) {
                                    setState(() {
                                      _isOperation = value;
                                      // print(_isOperation);
                                    });
                                  },
                                ),
                                new Text(
                                  'Multiplication',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                    value: 2,
                                    groupValue: _isOperation,
                                    onChanged: (int value) {
                                      setState(() {
                                        _isOperation = value;
                                        // print(_isOperation);
                                      });
                                    }),
                                new Text(
                                  'Division',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            //TODO: Use _range1 and _range2 values
                            new RaisedButton(
                              onPressed: () => {
                                if (_range1.text.isEmpty ||
                                    _range2.text.isEmpty ||
                                    _numberOfQuestions.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(
                                        msg: 'All fields are compulsary',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0)
                                  }
                                else
                                  {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => (SolveApp(
                                            user: user,
                                            //numdig: _radioValue1,
                                            oper: _isOperation,
                                            noOfTimes: 1,
                                            score: 0,
                                            params: {
                                              'range1': max(
                                                  int.parse(_range1.text),
                                                  int.parse(_range2.text)),
                                              'range2': min(
                                                  int.parse(_range1.text),
                                                  int.parse(_range2.text)),
                                              'numberOfQuestions': int.parse(
                                                  _numberOfQuestions.text),
                                              'isOpertaion': _isOperation,
                                              'speed': _selectedSpeed,
                                              'time': _selectedTime,
                                            },
                                          )),
                                        ),
                                        (r) => false),
                                  }
                              },
                              child: new Text(
                                'Start',
                                style: new TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                              ),
                              color: Theme.of(context).accentColor,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0)),
                            ),

                            // ])
                          ]),
                    ),
                  ),
                )),
              ],
            )));
  }
}

class CustomRangeTextInputFormatter2 extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '')
      return TextEditingValue();
    else if (int.parse(newValue.text) < 1)
      return TextEditingValue().copyWith(text: '1');

    return int.parse(newValue.text) > 100
        ? TextEditingValue().copyWith(text: '100')
        : newValue;
  }
}

class CustomRangeTextInputFormatter3 extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '')
      return TextEditingValue();
    else if (int.parse(newValue.text) < 1)
      return TextEditingValue().copyWith(text: '1');

    return int.parse(newValue.text) > 7
        ? TextEditingValue().copyWith(text: '7')
        : newValue;
  }
}
