import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'flutter_animation_progress_bar.dart';

// ignore: must_be_immutable
class Achievement extends StatefulWidget {
  String text;
  int achType; // daily - 0, weekly - 1, or progression - 2
  int reward;
  int progress;
  int total;
  int wkey; // basically we want to do this in a language that the computer can understand
  String icon; // for some reason i cant just print an image

  Achievement(String text, int reward, int progress, int total, int wkey,
      String icon, int achType) {
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
    return Container(
        child: Column(
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.green[900],
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              color: Colors.grey[200],
              width: 1.0,
            ),
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
                              getOptionalText(),
                            ],
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              new Container(
                width: MediaQuery.of(context).size.width - 80,
                child: FAProgressBar(
                  size: 15,
                  currentValue: ach.progress,
                  maxValue: ach.total,
                  changeProgressColor: Colors.amberAccent,
                  changeColorValue: ach.total,
                  backgroundColor: Colors.amberAccent,
                  progressColor: Colors.amber[900],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    ));
  }

  Widget getOptionalText() {
    if (ach.achType == 0) {
      return Row(
        children: <Widget>[
          new Image.asset("assets/scale.png", width: 30, height: 30),
          Text(
            " " + ach.reward.toString(),
            style: TextStyle(fontSize: 20, color: Colors.limeAccent[400]),
          ),
          Text(
            " (Daily) ",
            style: TextStyle(fontSize: 20, color: Colors.limeAccent[400]),
          ),
        ],
      );
    } else if (ach.achType == 1) {
      return Row(
        children: <Widget>[
          new Image.asset("assets/scale.png", width: 30, height: 30),
          Text(
            " " + ach.reward.toString(),
            style: TextStyle(fontSize: 20, color: Colors.limeAccent[400]),
          ),
          Text(
            " (Weekly) ",
            style: TextStyle(fontSize: 20, color: Colors.limeAccent[400]),
          ),
        ],
      );
    } else {
      return Text(
        " Progression: " +
            ach.progress.toString() +
            " / " +
            ach.total.toString(),
        style: TextStyle(fontSize: 20, color: Colors.limeAccent[400]),
      );
    }
  }
}
