import 'package:flutter/cupertino.dart';
import 'package:abacus/widgets/drawer.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text("SPEED"),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 5,
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
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    "$_speedValue",
                  ),
                )
              ],
            ),
            Spacer(),
            Container(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("SAVE"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
