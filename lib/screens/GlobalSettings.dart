import 'package:flutter/cupertino.dart';
import 'package:abacus/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _alwaysPositive = false, _onlyPositive = false, _isMute = false;
  int _time = 1;

  @override
  void initState() {
    super.initState();
    _setVariables();
  }

  void _setVariables() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _speedValue =
          prefs.getDouble("speed") != null ? prefs.getDouble("speed") : 1.0;
      _alwaysPositive = prefs.getBool("alwaysPositive") != null
          ? prefs.getBool("alwaysPositive")
          : false;
      _onlyPositive = prefs.getBool("onlyPositive") != null
          ? prefs.getBool("onlyPositive")
          : false;
      _isMute =
          prefs.getBool("isMute") != null ? prefs.getBool("isMute") : false;
      _time = prefs.getInt("time") != null ? prefs.getInt("time") : 1;
    });
  }

  void _showDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: 1,
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
                  child: Slider(
                    value: _speedValue,
                    min: 0.25,
                    max: 2,
                    divisions: 7,
                    label: _speedValue.toString(),
                    onChanged: (double value) {
                      setState(() {
                        _speedValue = value;
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
                  'Always Positive',
                ),
                trailing: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 5,
                  height: 100,
                  padding: EdgeInsets.all(8),
                  child: FlutterSwitch(
                    valueFontSize: 10.0,
                    toggleSize: 20.0,
                    value: _alwaysPositive,
                    borderRadius: 30.0,
                    padding: 5.0,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        _alwaysPositive = val;
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
            Spacer(),
            Container(
              child: FloatingActionButton.extended(
                onPressed: _saveSettings,
                label: Container(

                    width: MediaQuery.of(context).size.width - 20,
                    child: Text("SAVE",textAlign: TextAlign.center,)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _saveSettings() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("alwaysPositive", _alwaysPositive);
    pref.setBool("onlyPositive", _onlyPositive);
    pref.setBool("isMute", _isMute);
    pref.setString("time", _time.toString());
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
