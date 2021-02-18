import 'package:abacus/screens/AdditionSettingScreen.dart';
import 'package:abacus/screens/MultiplicationSettingScreen.dart';
import 'package:flutter/material.dart';
import 'package:abacus/widgets/drawer.dart';

class LevelScreen extends StatefulWidget {
  final String user;

  LevelScreen({this.user});

  @override
  _LevelScreenState createState() => new _LevelScreenState(user: user);
}

class _LevelScreenState extends State<LevelScreen> {
  int tempzero = 0;

  final String user;
  _LevelScreenState({
    @required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text("Abacus")),
            drawer: AppDrawer(user: user),
            body: Stack(children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/1.jpg"),
                          fit: BoxFit.cover))),
              Container(
                color: Color.fromRGBO(255, 255, 255, 0.6),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: List.generate(7, (index) {
                        return GestureDetector(
                          child: Card(
                              elevation: 8.0,
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: Center(
                                child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.blue),
                                    child: Text(
                                        'Level-' + (index + 1).toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20))),
                              ),
                              color: Colors.blue),
                        );
                      }) +
                      [
                        GestureDetector(
                          onTap: () => {},
                          child: Card(
                              elevation: 8.0,
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: Center(
                                child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.blue),
                                    child: Text('Custom \nOptions ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20))),
                              ),
                              color: Colors.blue),
                        ),
                      ],
                ),
              )
            ])));
  }
}
