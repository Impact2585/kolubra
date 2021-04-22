import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fit_kit/fit_kit.dart';
import 'package:kolubra/AchievementTracker.dart';

import 'Achievement.dart';
import 'Creature.dart';
import 'Environment.dart';
import 'FitSync.dart';

List<Creature> allCreatures = <Creature>[];
AchievementTracker _achievementTracker = AchievementTracker();

Future<void> init() async {
  //such a hassle is there a way to automate this
  Creature Jimmy = new Creature("Jimmy");
  Jimmy.addStage("assets/JimmyAssets/jimmy1.png", 0);
  Jimmy.addStage("assets/JimmyAssets/jimmy2.png", 50);
  allCreatures.add(Jimmy);

  // Weekly/Daily quests
  _achievementTracker.addAchievement(new Achievement(
      "Walk 250 steps every hour",
      100,
      50,
      100,
      1,
      "assets/ExerciseIcons/running.png",
      0));
  _achievementTracker.addAchievement(new Achievement("Jog for 10 minutes", 300,
      0, 100, 1, "assets/ExerciseIcons/timer.png", 1));
  _achievementTracker.addAchievement(new Achievement("Jumprope for 5 minutes",
      150, 20, 100, 1, "assets/ExerciseIcons/jumprope.png", 1));
  _achievementTracker.addAchievement(new Achievement(
      "Run for 10 minutes everyday",
      500,
      10,
      100,
      1,
      "assets/ExerciseIcons/running2.png",
      1));

  // Lifetime progression quests
  _achievementTracker.addProgression(new Achievement(
      "Lift weights for 20 lifetime hours",
      10000,
      1,
      5,
      1,
      "assets/Creatures/Cave/golem3.png",
      2));
  _achievementTracker.addProgression(new Achievement(
      "Run for 100 lifetime miles",
      0,
      2,
      5,
      1,
      "assets/Creatures/Forest/demiguise2.png",
      2));
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
        fontFamily: 'KiwiMaru',
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

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
                right: -50,
                bottom: 250,
                child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashRadius: 112,
                      icon: Image.asset('assets/Environments/cave.png'),
                      iconSize: 225,
                      onPressed: () {
                        Navigator.of(context).push(new Transition(
                            exitPage: this,
                            enterPage: new Environment(
                                <String>['assets/Creatures/Cave/sombrero.png'],
                                <Creature>[])));
                      },
                    ))),
            Positioned(
                right: 100,
                top: 60,
                child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashRadius: 112,
                      icon: Image.asset('assets/Environments/tree.png'),
                      iconSize: 225,
                      onPressed: () {
                        Navigator.of(context).push(new Transition(
                            exitPage: this,
                            enterPage: new Environment(<String>[
                              'assets/Creatures/Forest/bowtruckle.png',
                              'assets/Creatures/Grass/birdster.png'
                            ], <Creature>[])));
                      },
                    ))),
            Positioned(
                right: -20,
                top: 150,
                child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashRadius: 75,
                      icon: Image.asset('assets/Environments/rocks_locked.png'),
                      iconSize: 150,
                      onPressed: () {
                        print("rocks");
                      },
                    ))),
            Positioned(
                right: 140,
                top: 200,
                child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashRadius: 100,
                      icon: Image.asset('assets/Environments/grass.png'),
                      iconSize: 250,
                      onPressed: () {
                        Navigator.of(context).push(new Transition(
                            exitPage: this,
                            enterPage: new Environment(
                                <String>['assets/Creatures/Grass/birdster.png'],
                                <Creature>[])));
                      },
                    ))),
            Positioned(
                left: 100,
                bottom: 70,
                child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashRadius: 100,
                      icon: Image.asset('assets/Environments/pier.png'),
                      iconSize: 200,
                      onPressed: () {},
                    ))),
            Align(
                alignment: Alignment.bottomRight,
                child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashRadius: 62,
                      icon: Image.asset('assets/quests.png'),
                      iconSize: 125,
                      onPressed: () {
                        print(Image.asset('assets.quest.png').width);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _achievementTracker.buildQuestDialog(context),
                        );
                      },
                    ))),
            Positioned(
              left: 20,
              bottom: 20,
              child: Material(
                color: Colors.transparent,
                child: InkResponse(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => new FitSync(),
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          border: Border.all(
                            color: Colors.grey[400],
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                border: Border.all(
                                  color: Colors.grey[400],
                                  width: 1.0,
                                ),
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/CalebAssets/caleb1.png'),
                                    fit: BoxFit.cover)),
                          ),
                          Text(
                            "   bleh0.5   ",
                            textScaleFactor: 3,
                            style: TextStyle(
                                fontFamily: 'LeavesAndGround',
                                color: Colors.white),
                          ),
                        ],
                      )),
                ),
              ),
            ),
            // child:
            // Material(
            //   color: Colors.transparent,
            //   child: IconButton(
            //     splashRadius: 40,
            //     color: Colors.grey[200],
            //     icon: Icon(Icons.people_alt),
            //     iconSize: 75,

            //   ))),),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //     padding: EdgeInsets.all(10),
            //     child: FloatingActionButton(
            //       heroTag: null,
            //       onPressed: () {
            //         allCreatures[0].getEnergy(5);
            //         print(allCreatures[0].energy);
            //         currentForm = allCreatures[0].getImageByEnergy();
            //         print(currentForm);
            //         setState(
            //             () {}); // is there a less dumb way to do make sure it refreshes??
            //       },
            //       child:
            //           Icon(CupertinoIcons.paw, color: Colors.black, size: 25),
            //       backgroundColor: Colors.blue[400],
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.all(Radius.circular(15.0))),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   right: 80.0,
            //   top: 200,
            //   child: Image.asset(currentForm, width: 100),
            // ),
            Positioned(
                right: 15,
                top: 25,
                child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashRadius: 25,
                      color: Colors.grey[800],
                      icon: Icon(Icons.settings),
                      iconSize: 50,
                      onPressed: () {},
                    ))),
          ],
        ));
  }
}
