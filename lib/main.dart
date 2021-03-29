import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexagon/hexagon.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:fit_kit/fit_kit.dart';
import 'package:kolubra/AchievementTracker.dart';

import 'Achievement.dart';
import 'Creature.dart';

List<Creature> allCreatures = List();
AchievementTracker _achievementTracker = AchievementTracker();

Future<void> init() async {
  //such a hassle is there a way to automate this
  Creature Jimmy = new Creature("Jimmy");
  Jimmy.addStage("assets/JimmyAssets/jimmy1.png", 0);
  Jimmy.addStage("assets/JimmyAssets/jimmy2.png", 50);
  allCreatures.add(Jimmy);
  print("AOK0");
  _achievementTracker.addAchievement(new Achievement("Walk 250 steps every hour", 100, 0, 100, 1, "assets/ExerciseIcons/running.png"));
  _achievementTracker.addAchievement(new Achievement("Jog for 10 minutes", 300, 0, 100, 1, "assets/ExerciseIcons/timer.png"));
  _achievementTracker.addAchievement(new Achievement("Run for 10 minutes everyday this week", 500, 0, 100, 1, "assets/ExerciseIcons/running2.png"));
  _achievementTracker.addAchievement(new Achievement("Jumprope for 5 minutes", 150, 0, 100, 1, "assets/ExerciseIcons/jumprope.png"));
  print("AOK2");
}

void main() {
  init();
  runApp(Kolubra());
}

class Kolubra extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Kolubra',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: Home(title: 'Kolubra Home Page'),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String currentForm = allCreatures[0].getImageByEnergy();
  String result = "";
  Map<DataType, List<FitData>> results = Map();
  bool permissions;

  @override
  void initState() {
    super.initState();
    hasPermissions();
  }

  Future<void> read() async {
    results.clear();

    try {
      permissions = await FitKit.requestPermissions(DataType.values);
      if (!permissions) {
        result = 'requestPermissions: failed';
      } else {
        for (DataType type in DataType.values) {
          try {
            results[type] = await FitKit.read(
              type,
              dateFrom: DateTime.now().subtract(Duration(days: 5)),
              dateTo: DateTime.now(),
            );
          } on UnsupportedException catch (e) {
            results[e.dataType] = [];
          }
        }

        result = 'readAll: success';
      }
    } catch (e) {
      result = 'readAll: $e';
    }

    setState(() {});
  }

  Future<void> revokePermissions() async {
    results.clear();

    try {
      await FitKit.revokePermissions();
      permissions = await FitKit.hasPermissions(DataType.values);
      result = 'revokePermissions: success';
    } catch (e) {
      result = 'revokePermissions: $e';
    }

    setState(() {});
  }

  Future<void> hasPermissions() async {
    try {
      permissions = await FitKit.hasPermissions(DataType.values);
    } catch (e) {
      result = 'hasPermissions: $e';
    }

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/clubpenguinmap.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildQuestDialog(context),
                    );
                  },
                  // child: HexagonWidget.flat(
                  //   width: 5,
                  //   color: Colors.limeAccent,
                  //   padding: 4.0,
                  //   child: Icon(exclamationmark, color: Colors.black),
                  // ),
                  child: Icon(CupertinoIcons.exclamationmark,
                      color: Colors.black, size: 25),
                  backgroundColor: Colors.limeAccent[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    read();
                    print(result);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildSyncDialog(context),
                    );
                  },
                  child: Icon(CupertinoIcons.refresh,
                      color: Colors.black, size: 25),
                  backgroundColor: Colors.green[600],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: FloatingActionButton(
                  heroTag: null,
                  onPressed: () {
                    allCreatures[0].getEnergy(5);
                    print(allCreatures[0].energy);
                    currentForm = allCreatures[0].getImageByEnergy();
                    print(currentForm);
                    setState(
                        () {}); // is there a less dumb way to do make sure it refreshes??
                  },
                  child:
                      Icon(CupertinoIcons.paw, color: Colors.black, size: 25),
                  backgroundColor: Colors.blue[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Image.asset(currentForm, width: 100),
            )
          ],
        ));
  }

  Widget _buildSyncDialog(BuildContext context) {
    List items =
        results.entries.expand((entry) => [entry.key, ...entry.value]).toList();
    print("ITEMS: ");
    print(items);
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        content: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              right: -40.0,
              top: -35.0,
              child: InkResponse(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  child: Icon(Icons.close),
                  backgroundColor: Colors.red,
                  radius: 15,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: 'Sync to Google Fit',
                          style: TextStyle(color: Colors.black),
                        ),
                        textScaleFactor: 1.5,
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          print("DF");
                          setState(() {
                            items = results.entries
                                .expand((entry) => [entry.key, ...entry.value])
                                .toList();
                          });
                        },
                        child: Icon(CupertinoIcons.refresh,
                            color: Colors.black, size: 25),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, // background
                          onPrimary: Colors.green, // foreground
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 600,
                  width: 500,
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      if (item is DataType) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            '$item - ${results[item].length}',
                            style: Theme.of(context).textTheme.title,
                          ),
                        );
                      } else if (item is FitData) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          child: Text(
                            '$item',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        );
                      }

                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildQuestDialog(BuildContext context) {
    return AlertDialog(
      content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -35.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
                radius: 15,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  color: Colors.green[200],
                  padding: EdgeInsets.all(10),
                  child: TextButton(
                    child: Text('Quests'),
                    onPressed: () {
                      print(_achievementTracker.list.length);
                          _achievementTracker.list[0].addProg(50);
                          Navigator.push(context, new MaterialPageRoute(builder: (context) => _achievementTracker));
                      setState(() {});
                    },
                  ),
                ),
              SizedBox(width: 10),
              Container(
                color: Colors.lime[300],
                padding: EdgeInsets.all(10),
                child: RichText(
                  text: TextSpan(
                    text: 'Progression',
                    style: TextStyle(color: Colors.black),
                  ),
                  textScaleFactor: 1.5,
                ),
              ),
            ],
          ),
          // Container(
          //   child: SizedBox(
          //     height: 100,
          //     width: 100,
          //   ),
          //   color: Colors.lime[100],
          // )
        ],
      ),
    );
  }
}
