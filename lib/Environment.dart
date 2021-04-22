import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'Creature.dart';
import 'package:confetti/confetti.dart';

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
  List<String> backgroundImage;
  String currentHat;
  List<Creature> creatures;

  Environment(List<String> backgroundImage, List<Creature> creatures) {
    this.backgroundImage = backgroundImage;
    this.creatures = creatures;
  }

  @override
  _EnvironmentState createState() => new _EnvironmentState(
      new Environment(backgroundImage, creatures), backgroundImage);
}

class _EnvironmentState extends State<Environment> {
  List<String> backgroundImage;
  int currentBackground;
  String currentHat = 'assets/transparent.png';
  ConfettiController _controller;

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

  _EnvironmentState(this.ach, List<String> backgroundImage) {
    this.backgroundImage = backgroundImage;
  }

  @override
  void initState() {
    _controller = ConfettiController(duration: const Duration(seconds: 2));
    currentBackground = 0;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
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
            image: AssetImage(backgroundImage[currentBackground]),
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
                        color: Colors.green,
                        height: 240,
                        child: TabBarView(children: tabs),
                      ),
                      TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.green[400],
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Colors.green),
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
                  onPressed: () {
                    setState(() {
                      currentBackground--;
                      if (currentBackground < 0)
                        currentBackground = backgroundImage.length - 1;
                    });
                  },
                  child: Icon(Icons.arrow_back_ios_outlined,
                      size: 60, color: Colors.white)),
            ),
            Positioned(
              right: -10,
              bottom: 150,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      currentBackground++;
                      if (currentBackground >= backgroundImage.length)
                        currentBackground = 0;
                    });
                  },
                  child: Icon(Icons.arrow_forward_ios_outlined,
                      size: 60, color: Colors.white)),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: _Triangle(color: Colors.green[600]),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                    ),
                    child:
                        Icon(Icons.arrow_back, size: 40, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })),
            Positioned(
              bottom: 220,
              right: 110,
              child: Image.asset(currentHat, height: 75, width: 75),
            ),
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _controller,
                blastDirectionality: BlastDirectionality
                    .explosive, // don't specify a direction, blast randomly
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
                createParticlePath: drawStar, // define a custom shape/path.
              ),
            ),
          ],
        ));
  }

  Widget itemIcon(String img) {
    return Material(
      color: Colors.transparent,
      child: InkResponse(
          onTap: () {
            if (img == 'assets/Collectibles/Hats/party_hat.png') {
              setState(() {
                currentHat = 'assets/Collectibles/Hats/party_hat.png';
              });
              _controller.play();
            }
          },
          child: Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: RadialGradient(
                  colors: <Color>[
                    Colors.green[400],
                    Colors.green[100],
                  ],
                ),
                color: Colors.green[200],
                border: Border.all(
                  color: Colors.transparent,
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

class _Triangle extends StatelessWidget {
  const _Triangle({
    Key key,
    this.color,
  }) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: _ShapesPainter(color),
        child: Container(
            height: 90,
            width: 150,
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 16),
                    child: Transform.rotate(
                        angle: pi / 4,
                        child: Container(
                            padding: EdgeInsets.all(20),
                            child: Container()))))));
  }
}

class _ShapesPainter extends CustomPainter {
  final Color color;
  _ShapesPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    var path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
