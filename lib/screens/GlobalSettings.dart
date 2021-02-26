import 'package:flutter/cupertino.dart';
import 'package:abacus/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../Variables.dart';

class GlobalSettings extends StatelessWidget {
  final String user;
  GlobalSettings({Key key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Add your Global Settings
    return new Scaffold(
      appBar: AppBar(title: Text("Settings")),
      drawer: AppDrawer(user: user),
      body: SettingWidget(),
    );
  }
}

class SettingWidget extends StatefulWidget {
  @override
  _SettingWidgetState createState() => new _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  double _speedValue = 1;
  bool _onlyPositive = false,
      _isMute = false,
      _isAutoCorrect = false,
      _isSpeech = false;
  int _time = 1;
  final FlutterTts flutterTts = FlutterTts();

  _speak(String text) async {
    flutterTts.stop();
    await flutterTts.speak(text);
    // await flutterTts.speak("1234567 plus 2837");
  }

  @override
  void initState() {
    super.initState();
    _setVariables();
    // _loadShared();
    print("after call");
    flutterTts.setVolume(1.0);
    flutterTts.setVoice('en-in-x-ahp-local');
  }

  Future _setVariables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _speedValue =
          prefs.getDouble("speed") != null ? prefs.getDouble("speed") : 1.0;
      _onlyPositive = prefs.getBool("onlyPositive") != null
          ? prefs.getBool("onlyPositive")
          : false;
      _isMute =
          prefs.getBool("isMute") != null ? prefs.getBool("isMute") : false;
      _time = prefs.getInt("time") != null ? prefs.getInt("time") : 1;
      _isAutoCorrect = prefs.getBool("autoCorrect") != null
          ? prefs.getBool("autoCorrect")
          : false;
      _isSpeech =
          prefs.getBool("isSpeech") != null ? prefs.getBool("isSpeech") : false;

      print("global shared loaded");
    });
  }

  void _showDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: 0,
            maxValue: 30,
            title: new Text("Select Timer"),
            initialIntegerValue: _time,
          );
        }).then((value) {
      if (value != null) {
        setState(() => _time = value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              child: ListTile(
                leading: Icon(Icons.record_voice_over, color: Colors.blue),
                title: Text('Speaking Speed'),
                trailing: Container(
                  alignment: Alignment.bottomRight,
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 100,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Slider(
                          value: _speedValue,
                          min: 0.25,
                          max: 2,
                          divisions: 7,
                          label: _speedValue.toString(),
                          onChanged: (double value) {
                            setState(() {
                              _speedValue = value;
                              flutterTts.setSpeechRate(_speedValue);
                            });
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: IconButton(
                            icon: Icon(
                              Icons.play_arrow,
                              color: Colors.blue,
                            ),
                            onPressed: () => {_speak("79 multiply 179")}),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              height: 20,
              thickness: 0.3,
              indent: 10,
              endIndent: 0,
            ),
            Container(
                child: ListTile(
              leading: Icon(Icons.rule_outlined, color: Colors.blue),
              title: Text('Use Positives values'),
              trailing: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 5,
                height: 100,
                padding: EdgeInsets.all(8),
                child: FlutterSwitch(
                  valueFontSize: 10.0,
                  toggleSize: 20.0,
                  value: _onlyPositive,
                  borderRadius: 30.0,
                  padding: 5.0,
                  showOnOff: true,
                  onToggle: (val) {
                    setState(() {
                      _onlyPositive = val;
                    });
                  },
                ),
              ),
            )),
            const Divider(
              color: Colors.black,
              height: 20,
              thickness: 0.3,
              indent: 10,
              endIndent: 0,
            ),
            Container(
              child: ListTile(
                leading: Icon(Icons.add, color: Colors.blue),
                title: Text(
                  'Voice Input',
                ),
                trailing: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 5,
                  height: 100,
                  padding: EdgeInsets.all(8),
                  child: FlutterSwitch(
                    valueFontSize: 10.0,
                    toggleSize: 20.0,
                    value: _isSpeech,
                    borderRadius: 30.0,
                    padding: 5.0,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        _isSpeech = val;
                      });
                    },
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              height: 20,
              thickness: 0.3,
              indent: 10,
              endIndent: 0,
            ),
            Container(
              child: ListTile(
                leading: Icon(Icons.volume_off, color: Colors.blue),
                title: Text(
                  'Mute Voice',
                ),
                trailing: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 5,
                  height: 100,
                  padding: EdgeInsets.all(8),
                  child: FlutterSwitch(
                    valueFontSize: 10.0,
                    toggleSize: 20.0,
                    value: _isMute,
                    borderRadius: 30.0,
                    padding: 5.0,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        _isMute = val;
                        if (_isMute) {
                          _isSpeech = false;
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              height: 20,
              thickness: 0.3,
              indent: 10,
              endIndent: 0,
            ),
            Container(
              child: ListTile(
                leading: Icon(Icons.access_time_outlined, color: Colors.blue),
                title: Text('Timer'),
                onTap: _showDialog,
                trailing: Container(
                    width: MediaQuery.of(context).size.width / 5,
                    alignment: Alignment.center,
                    child: Text(
                      "$_time",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            const Divider(
              color: Colors.black,
              height: 20,
              thickness: 0.3,
              indent: 10,
              endIndent: 0,
            ),
            Container(
              child: ListTile(
                leading: Icon(Icons.check, color: Colors.blue),
                title: Text(
                  'Auto Correct Answer',
                ),
                trailing: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 5,
                  height: 100,
                  padding: EdgeInsets.all(8),
                  child: FlutterSwitch(
                    valueFontSize: 10.0,
                    toggleSize: 20.0,
                    value: _isAutoCorrect,
                    borderRadius: 30.0,
                    padding: 5.0,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        _isAutoCorrect = val;
                      });
                    },
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
              height: 20,
              thickness: 0.3,
              indent: 10,
              endIndent: 0,
            ),
            Spacer(),
            Container(
              child: FloatingActionButton.extended(
                onPressed: _saveSettings,
                label: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Text(
                      "SAVE",
                      textAlign: TextAlign.center,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _saveSettings() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.setBool("alwaysPositive", _alwaysPositive);
    pref.setBool("onlyPositive", _onlyPositive);
    pref.setBool("isMute", _isMute);
    pref.setBool("autoCorrect", _isAutoCorrect);
    pref.setBool("isSpeech", _isSpeech);

    pref.setInt("time", _time);
    print('global saved time: $_time');
    pref.setDouble("speed", _speedValue);
    Fluttertoast.showToast(
        msg: "SAVED",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
