import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:fit_kit/fit_kit.dart';
import 'package:kolubra/AchievementTracker.dart';
import 'flutter_animation_progress_bar.dart';

class FitSync extends StatefulWidget {
  FitSync();

  @override
  _FitSyncState createState() => new _FitSyncState();
}

class _FitSyncState extends State<FitSync> {
  _FitSyncState();

  String result = "";
  Map<DataType, List<FitData>> results = Map();
  bool permissions;
  List<Widget> base = <Widget>[
    Center(
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            border: Border.all(
              color: Colors.white,
              width: 0.0,
            ),
            image: DecorationImage(
                image: AssetImage('assets/CalebAssets/caleb1.png'),
                fit: BoxFit.cover)),
      ),
    ),
    Center(
      child: Row(
        children: <Widget>[
          Text(
            "   bleh0.5   ",
            textScaleFactor: 5,
            style:
                TextStyle(fontFamily: 'LeavesAndGround', color: Colors.black),
          ),
          Icon(Icons.star),
        ],
      ),
    ),
    Center(
      child: Row(
        children: <Widget>[
          Text(
            'Currently syncing with:',
            style: TextStyle(color: Colors.black),
            textScaleFactor: 1,
          ),
          // SizedBox(width: 1),
          // ElevatedButton(
          //   onPressed: () {
          //     setState(() {
          //       items = results.entries
          //           .expand((entry) => [entry.key, ...entry.value])
          //           .toList();
          //     });
          //   },
          //   child: Align(
          //       alignment: Alignment.centerLeft,
          //       child: Icon(CupertinoIcons.refresh,
          //           color: Colors.black, size: 25)),
          //   style: ElevatedButton.styleFrom(
          //     minimumSize: new Size(50, 30),
          //     primary: Colors.green, // background
          //     onPrimary: Colors.green, // foreground
          //   ),
          // ),
        ],
      ),
    ),
    SizedBox(height: 10),
    Center(
      child: Image.asset("assets/googlefit.png", width: 100, height: 100),
    ),
    SizedBox(height: 20),
    Center(child: CircularProgressIndicator(backgroundColor: Colors.blue[200])),
  ];

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
              dateFrom: DateTime.now().subtract(Duration(days: 7)),
              dateTo: DateTime.now(),
            );
            // print(type);
            // print(results[type]);
          } on UnsupportedException catch (e) {
            results[e.dataType] = [];
          }
        }

        result = 'readAll: success';
      }
    } catch (e) {
      result = 'readAll: $e';
    }
    print(results);
    setState(() {
      int stepsDay = 0;
      int stepsWeek = 0;
      for (FitData each in results[DataType.STEP_COUNT]) {
        if (each.dateFrom.day == DateTime.now().day) {
          stepsDay += each.value;
        }
        stepsWeek += each.value;
      }
      double distDay = 0;
      double distWeek = 0;
      for (FitData each in results[DataType.DISTANCE]) {
        if (each.dateFrom.day == DateTime.now().day) {
          distDay += each.value;
        }
        distWeek += each.value;
      }
      distDay = distDay.round() / 1000;
      distWeek = distWeek.round() / 1000;

      double caloriesDay = 0;
      double caloriesWeek = 0;
      for (FitData each in results[DataType.ENERGY]) {
        if (each.dateFrom.day == DateTime.now().day) {
          caloriesDay += each.value;
        }
        caloriesWeek += each.value;
      }
      // print(items);
      while (base.length > 6) {
        base.removeLast();
      }
      base.addAll(<Widget>[
        Center(
          child: Text(
            'Daily Stats',
            style: TextStyle(color: Colors.black),
            textScaleFactor: 1.5,
          ),
        ),
        SizedBox(height: 10),
        fitElement(" steps", stepsDay, 5000, 50),
        SizedBox(height: 10),
        fitElement(" km", distDay.round(), 5, 30),
        SizedBox(height: 10),
        fitElement(" calories", caloriesDay.round(), 2000, 80),
        SizedBox(height: 10),
        Center(
          child: Text(
            'Weekly Stats',
            style: TextStyle(color: Colors.black),
            textScaleFactor: 1.5,
          ),
        ),
        SizedBox(height: 10),
        fitElement(" steps", stepsWeek, 35000, 50),
        SizedBox(height: 10),
        fitElement(" km", distWeek.round(), 35, 30),
        SizedBox(height: 10),
        fitElement(" calories", caloriesWeek.round(), 14000, 80),
        SizedBox(height: 10),
        //         // TableRow(children: [
        //         //   Column(children: [
        //         //     Text('Heartrate', style: TextStyle(fontSize: 20))
        //         //   ]),
        //         //   Column(children: [
        //         //     // Text('not found'),
        //         //     Text(results[DataType.HEART_RATE]
        //         //         .getRange(0, 0)
        //         //         .toString()),
        //         //   ]),
        //         // ]),
      ]);
    });
  }

  Widget fitElement(String category, int value, int max, int min) {
    return FAProgressBar(
      currentValue: value,
      maxValue: max,
      displayText: category,
      displayTextStyle: TextStyle(color: Colors.black),
      changeProgressColor: Colors.pink,
      backgroundColor: Colors.white,
      progressColor: Colors.lightBlue,
      minimumVal: min,
    );
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
    if (results.length == 0) read();
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
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 300,
                height: 800,
                child: ListView.builder(
                    itemCount: base.length, // number of items in your list

                    //here the implementation of itemBuilder. take a look at flutter docs to see details
                    itemBuilder: (BuildContext context, int index) {
                      return base[index]; // return your widget
                    }),
              ),
            ),
          ],
        ),
      );
    });
  }
}
