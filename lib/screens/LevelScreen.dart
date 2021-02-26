import 'package:abacus/screens/AdditionSettingScreen.dart';
import 'package:abacus/screens/MultiplicationSettingScreen.dart';
import 'package:flutter/material.dart';
import 'package:abacus/widgets/drawer.dart';

import 'SolveScreen.dart';

class LevelScreen extends StatefulWidget {
  final String user;
  int isoper;
  LevelScreen({this.user, this.isoper});

  @override
  _LevelScreenState createState() =>
      new _LevelScreenState(user: user, isoper: isoper);
}

class _LevelScreenState extends State<LevelScreen> {
  int tempzero = 0;
  int isoper = 0;
  final String user;
  _LevelScreenState({
    @required this.user,
    this.isoper,
  });

  // var oper = {0: 6, 1: 5, 2: 5, 3: 5};
  List<List<int>> oper = [
    [0, 6],
    [1, 5],
    [2, 4],
    [0, 3]
  ];
  Map<int, String> difficulty = {0: 'Easy', 1: 'Medium', 2: 'Hard'};
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text("Select Level")),
            drawer: AppDrawer(user: user),
            body: Center(
              child: Stack(children: <Widget>[
                // Container(
                //     decoration: BoxDecoration(
                //         image: DecorationImage(
                //             image: AssetImage("images/1.jpg"),
                //             fit: BoxFit.cover))),
                // Container(
                //   color: Color.fromRGBO(255, 255, 255, 0.6),
                // ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: GridView.count(
                    primary: false,
                    childAspectRatio: 4,
                    padding: const EdgeInsets.all(10),
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    crossAxisCount: 1,
                    children: List.generate(oper[isoper][1], (index) {
                          return GestureDetector(
                            child: Card(
                              elevation: 8.0,
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 6.0),
                              child: Container(
                                decoration: isoper == 3
                                    ? BoxDecoration(
                                        color: Colors
                                            .blue[200 * (index + 1) + 100])
                                    : BoxDecoration(
                                        color: Colors
                                            .blue[100 * (index + 1) + 200]),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  leading: Container(
                                    padding: EdgeInsets.only(right: 12.0),
                                    decoration: new BoxDecoration(
                                        border: new Border(
                                            right: new BorderSide(
                                                width: 1.0,
                                                color: Colors.white24))),
                                    child: Icon(Icons.insights,
                                        color: Colors.white),
                                  ),
                                  title: isoper == 3
                                      ? Text(difficulty[index],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20))
                                      : Text(
                                          'Level-' +
                                              (index + 1 + oper[isoper][0])
                                                  .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20)),
                                  trailing: IconButton(
                                    onPressed: () {
                                      print('Clicked');
                                    },
                                    icon: Icon(Icons.info_outline,
                                        color: Colors.white, size: 30.0),
                                  ),
                                  // onTap: () {
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => LevelScreen(
                                  //                 user: user,
                                  //                 isoper: 0,
                                  //               )));
                                  // },
                                ),
                              ),
                            ),

                            //  Card(
                            //     elevation: 8.0,
                            //     margin: new EdgeInsets.symmetric(
                            //         horizontal: 10.0, vertical: 6.0),
                            //     child: Center(
                            //       child: Container(
                            //           decoration:
                            //               BoxDecoration(color: Colors.blue),
                            //           child: Text(
                            //               'Level-' +
                            //                   (index + 1 + oper[isoper][0])
                            //                       .toString(),
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontSize: 20))),
                            //     ),
                            //     color: Colors.blue),

                            onTap: () => {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => (SolveApp(
                                        user: user,
                                        oper: isoper,
                                        noOfTimes: 1,
                                        score: 0,
                                        params: null,
                                        level: index + 1 + oper[isoper][0])),
                                  ),
                                  (r) => false)
                            },
                          );
                        }) +
                        [
                          if (isoper != 3)
                            GestureDetector(
                              onTap: () => {
                                if (isoper == 0)
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AdditionScreen(
                                                user: user,
                                              )),
                                    ),
                                  }
                                else
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MultiplicationScreen(
                                                user: user,
                                                isoper: isoper,
                                              )),
                                    ),
                                  }
                              },
                              child: Card(
                                  elevation: 8.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Center(
                                    child: Container(
                                        decoration:
                                            BoxDecoration(color: Colors.blue),
                                        child: Text('Custom Options ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20))),
                                  ),
                                  color: Colors.blue),
                            ),
                        ],
                  ),
                )
              ]),
            )));
  }
}
