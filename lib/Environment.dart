import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Creature.dart';

class Transition extends PageRouteBuilder {
  final enterPage;
  final exitPage;
  Transition({this.exitPage, this.enterPage})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              enterPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
            children: <Widget>[
              FadeTransition(
                opacity: animation,
                child: child,
              ),
              FadeTransition(
                opacity: animation,
                child: child,
              ),
            ],
          ),
        );
}

// ignore: must_be_immutable
class Environment extends StatefulWidget {
  String backgroundImage;
  List<Creature> creatures;

  Environment(String backgroundImage, List<Creature> creatures) {
    this.backgroundImage = backgroundImage;
    this.creatures = creatures;
  }

  @override
  _EnvironmentState createState() =>
      new _EnvironmentState(new Environment(backgroundImage, creatures));
}

class _EnvironmentState extends State<Environment> {
  final List<Tab> myTabs = <Tab>[
    Tab(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Food",
          textScaleFactor: 2,
          style: TextStyle(fontFamily: 'LeavesAndGround'),
        ),
      ),
    ),
    Tab(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Customize",
          textScaleFactor: 2,
          style: TextStyle(fontFamily: 'LeavesAndGround'),
        ),
      ),
    ),
    Tab(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Store",
          textScaleFactor: 2,
          style: TextStyle(fontFamily: 'LeavesAndGround'),
        ),
      ),
    ),
  ];

  Environment ach;

  _EnvironmentState(this.ach);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Creatures/Cave/golem1.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Colors.white,
                  ),
                  width: 90,
                  height: 45,
                ),
              ),
              top: 240,
              left: 0,
              right: 0,
            ),
            Positioned(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Colors.white,
                  ),
                  width: 90,
                  height: 45,
                ),
              ),
              top: 240,
              left: 20,
            ),
            Positioned(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Colors.white,
                  ),
                  width: 90,
                  height: 45,
                ),
              ),
              top: 240,
              right: 20,
            ),
            SizedBox(
              height: 300,
              child: Material(
                color: Colors.transparent,
                child: DefaultTabController(
                  length: myTabs.length,
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.blue,
                        height: 240,
                        child: TabBarView(children: [
                          Text("1"),
                          Text("2"),
                          Text("3"),
                        ]),
                      ),
                      TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.blue[400],
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Colors.blue),
                          tabs: myTabs),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                left: 0,
                bottom: 150,
                child: Icon(Icons.arrow_back_ios_outlined,
                    size: 60, color: Colors.white)),
            Positioned(
                right: 0,
                bottom: 150,
                child: Icon(Icons.arrow_forward_ios_outlined,
                    size: 60, color: Colors.white)),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue[200]),
                        ),
                        child: Icon(
                          Icons.keyboard_return_outlined,
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }))),
          ],
        ));
  }
}
