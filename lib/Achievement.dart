import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

// ignore: must_be_immutable
class Achievement extends StatefulWidget  {
  String text;
  int reward;
  int progress;
  int total;
  int wkey; // basically we want to do this in a language that the computer can understand
  String icon; // for some reason i cant just print an image
  Achievement(String text, int reward, int progress, int total, int wkey, String icon) {
    this.text = text;
    this.reward = reward;
    this.progress = progress;
    this.total = total;
    this.wkey = wkey;
    this.icon = icon;
  }
  void addProg(int p) {
    progress += p;
  }
  @override
  _Achievement createState() => _Achievement(new Achievement(text, reward, progress, total, wkey, icon));
}
class _Achievement extends State<Achievement> {
  Achievement ach;

  _Achievement(this.ach);

  @override
  Widget build(BuildContext context) {
      return new Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            new Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage(ach.icon), fit: BoxFit.cover)),
            ),
            new Stack(
              children: <Widget>[
                Align(
                  alignment: FractionalOffset(0.05, 0.1),
                  child: new Text(ach.text),
                ),
                Align(
                  alignment: FractionalOffset(0.05, 0.35),
                  child: new Row(
                    children: <Widget>[
                      new Icon(CupertinoIcons.bolt_circle, color: Colors.orangeAccent, size: 30),
                      new Text(ach.reward.toString() + " Treats o' Gold")
                    ],
                  ),
                ),
                Align(
                  alignment: FractionalOffset(0.5, 0.8),
                  child: new Container(width: MediaQuery.of(context).size.width - 150, child: new LinearProgressIndicator(
                    minHeight: 20,
                    backgroundColor: Colors.amberAccent,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.amber),
                    value: 1.0 * ach.progress / ach.total,
                  )),
                ),
              ],
            ),
          ],
        ),
    );
  }
}