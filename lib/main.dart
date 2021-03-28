import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexagon/hexagon.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:fit_kit/fit_kit.dart';

import 'Creature.dart';

List<Creature> allCreatures = List();

void init() { //such a hassle is there a way to automate this
  Creature Jimmy = new Creature("Jimmy");
  Jimmy.addStage("assets/JimmyAssets/jimmy1.png", 0);
  Jimmy.addStage("assets/JimmyAssets/jimmy2.png", 50);
  allCreatures.add(Jimmy);
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
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
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

class FitKitReader {
  static String result = "";
  static Map<DataType, List<FitData>> results = Map();
  static bool permissions;
  static Future<void> read() async {
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
            print("you fool");
            print(e);
            results[e.dataType] = [];
          }
        }

        result = 'readAll: success';
      }
    } catch (e) {
      result = 'readAll: $e';
    }
    print(result);
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
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch(index) {
      case 0:
        showDialog(
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );
        break;
      case 1:
        allCreatures[0].getEnergy(5);
        print(allCreatures[0].energy);
        currentForm = allCreatures[0].getImageByEnergy();
        print(currentForm);
        setState(() {}); // is there a less dumb way to do make sure it refreshes??
        break;
      case 2:
        FitKitReader.read();
        print(FitKitReader.result);
        break;
      default:
        break;
    }
  }
String currentForm = allCreatures[0].getImageByEnergy();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/clubpenguinmap.png'),
          fit: BoxFit.fill,
        ),
      ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            alignment: Alignment.center,
            child: Image.asset(currentForm, width: 100),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('options'),
                  backgroundColor: Colors.green
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text('add energy to jimmy'),
                  backgroundColor: Colors.yellow
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('get fitness'),
                backgroundColor: Colors.blue,
              ),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            iconSize: 40,
            onTap: _onItemTapped,
            elevation: 5
        ),
      ),

    );
  }

  Widget _buildPopupDialog(BuildContext context) {
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
                  child: RichText(
                    text: TextSpan(
                      text: 'Challenges',
                      style: TextStyle(color: Colors.black),
                    ),
                    textScaleFactor: 2,
                  )),
              SizedBox(width: 10),
              Container(
                color: Colors.lime[300],
                padding: EdgeInsets.all(10),
                child: RichText(
                  text: TextSpan(
                    text: 'Lifetime Progression',
                    style: TextStyle(color: Colors.black),
                  ),
                  textScaleFactor: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
