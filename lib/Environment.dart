import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'Creature.dart';

class Transition extends PageRouteBuilder {
  final enterPage;
  final exitPage;
  Transition({this.exitPage, this.enterPage})
      : super(
          transitionDuration: Duration(seconds: 1),
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
  _EnvironmentState createState() => new _EnvironmentState(
      new Environment(backgroundImage, creatures), backgroundImage);
}

class _EnvironmentState extends State<Environment> {
  String backgroundImage;
  final List<Tab> myTabs = <Tab>[
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
          "Feed",
          textScaleFactor: 2,
          style: TextStyle(fontFamily: 'LeavesAndGround'),
        ),
      ),
    ),
    Tab(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          "Shop",
          textScaleFactor: 2,
          style: TextStyle(fontFamily: 'LeavesAndGround'),
        ),
      ),
    ),
  ];

  final List<String> hats = <String>[
    'assets/Collectibles/Hats/bunny.png',
    'assets/Collectibles/Hats/baseball.png',
    'assets/Collectibles/Hats/mask.png',
    'assets/Collectibles/Hats/party_hat.png',
    'assets/Collectibles/Hats/sombrero.png',
  ];
  final List<String> food = <String>[
    'assets/Collectibles/Food/grub.png',
    'assets/Collectibles/Food/minerals.png',
    'assets/Collectibles/Food/muffin.png'
  ];
  final List<String> other = <String>[
    'assets/Collectibles/Body/apron.png',
    'assets/Collectibles/Body/gold_wings.png',
    'assets/Collectibles/Body/heart_pendant.png',
    'assets/Collectibles/Emotes/guitar.png',
    'assets/Collectibles/Emotes/rockfall.png'
  ];

  List<Widget> tabs;

  Environment ach;

  _EnvironmentState(this.ach, String backgroundImage) {
    this.backgroundImage = backgroundImage;
  }

  @override
  Widget build(BuildContext context) {
    tabs = <Widget>[
      ListView.separated(
        // Food tab
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        itemCount: max(other.length, hats.length),
        itemBuilder: (BuildContext context, int index) {
          List<Widget> col = <Widget>[];
          if (hats.length > index) {
            col.add(itemIcon(hats[index]));
          }
          if (other.length > index) {
            col.add(SizedBox(height: 20));
            col.add(itemIcon(other[index]));
          }
          return Column(
            children: col,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 20);
        },
      ),
      ListView.separated(
        // Food tab
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        itemCount: (food.length / 2).ceil(),
        itemBuilder: (BuildContext context, int index) {
          List<Widget> col = <Widget>[];
          col.add(itemIcon(food[index * 2]));
          if (food.length > index * 2 + 1) {
            col.add(SizedBox(height: 20));
            col.add(itemIcon(food[index * 2 + 1]));
          }
          return Column(
            children: col,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 20);
        },
      ),
      Text("3"),
    ];
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
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
                        child: TabBarView(children: tabs),
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
              left: -10,
              bottom: 150,
              child: TextButton(
                  onPressed: () {},
                  child: Icon(Icons.arrow_back_ios_outlined,
                      size: 60, color: Colors.white)),
            ),
            Positioned(
              right: -10,
              bottom: 150,
              child: TextButton(
                  onPressed: () {},
                  child: Icon(Icons.arrow_forward_ios_outlined,
                      size: 60, color: Colors.white)),
            ),
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

  Widget itemIcon(String img) {
    return Material(
      color: Colors.transparent,
      child: InkResponse(
          onTap: () {
            if (img == 'assets/Collectibles/Hats/sombrero.png') {
              setState(() {
                backgroundImage = 'assets/Creatures/Cave/sombrero.png';
              });
            }
          },
          child: Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: RadialGradient(
                  colors: <Color>[
                    Colors.blue[400],
                    Colors.blue[100],
                  ],
                ),
                color: Colors.blue[200],
                border: Border.all(
                  color: Colors.black,
                  width: 0.0,
                ),
              ),
              padding: EdgeInsets.all(10),
              child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                          image: AssetImage(img), fit: BoxFit.contain))))),
    );
  }
}
