import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

// ignore: must_be_immutable
class Achievement extends StatefulWidget {
  String text;
  String achType; // daily, weekly, or progression
  int reward;
  int progress;
  int total;
  int wkey; // basically we want to do this in a language that the computer can understand
  String icon; // for some reason i cant just print an image

  Achievement(String text, int reward, int progress, int total, int wkey,
      String icon, String achType) {
    this.text = text;
    this.reward = reward;
    this.progress = progress;
    this.total = total;
    this.wkey = wkey;
    this.icon = icon;
    this.achType = achType;
  }
  void addProg(int p) {
    progress += p;
  }

  @override
  _Achievement createState() => _Achievement(
      new Achievement(text, reward, progress, total, wkey, icon, achType));
}

class _Achievement extends State<Achievement> {
  Achievement ach;

  _Achievement(this.ach);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.green[900],
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      new Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: AssetImage(ach.icon),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(width: 10),
                      Container(
                          width: MediaQuery.of(context).size.width - 175,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text(
                                ach.text,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                              SizedBox(height: 5),
                              new Row(
                                children: <Widget>[
                                  new Icon(CupertinoIcons.bolt_circle,
                                      color: Colors.orangeAccent, size: 30),
                                  Text(
                                    " " + ach.reward.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.limeAccent[400]),
                                  ),
                                  Text(
                                    " " + ach.achType,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.limeAccent[400]),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              new Container(
                  width: MediaQuery.of(context).size.width - 80,
                  child: new LinearProgressIndicator(
                    minHeight: 20,
                    backgroundColor: Colors.amberAccent,
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.amber[800]),
                    value: 1.0 * ach.progress / ach.total,
                  )),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
