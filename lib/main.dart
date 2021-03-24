import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexagon/hexagon.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

void main() {
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
        body: ListView(
          children: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context),
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
