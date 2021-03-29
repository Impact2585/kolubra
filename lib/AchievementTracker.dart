import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kolubra/Achievement.dart';

class AchievementTracker extends StatelessWidget {
  List<Achievement> list = List();
  void addAchievement(Achievement ach) {
    list.add(ach);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: Text("Achievement Tracker") ),
        body: Container(
          height: list.length * 105.0,
          width: MediaQuery.of(context).size.width,
          child: new ListView.builder(
            shrinkWrap: true,
            itemBuilder: _buildAchievement,
            itemCount: list.length,
          ),
        )
    );
  }
  Widget _buildAchievement( BuildContext context, int index ){
    return list[index].createState().build(context);
  }
}