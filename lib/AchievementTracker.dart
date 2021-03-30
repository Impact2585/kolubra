import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kolubra/Achievement.dart';

class AchievementTracker {
  List<Achievement> list = List();
  List<Achievement> progression = List();
  void addAchievement(Achievement ach) {
    list.add(ach);
  }

  void addProgression(Achievement ach) {
    progression.add(ach);
  }

  Widget buildQuestDialog(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.fromLTRB(20, 40, 20, 40),
      backgroundColor: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: <Widget>[
          DefaultTabController(
              length: 2,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Scaffold(
                    backgroundColor: Colors.green,
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(75.0),
                      child: AppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.white,
                        elevation: 0,
                        bottom: TabBar(
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.green,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                color: Colors.green),
                            tabs: [
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "QUESTS",
                                    textScaleFactor: 3,
                                    style: TextStyle(
                                        fontFamily: 'LeavesAndGround'),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Progression",
                                    textScaleFactor: 3,
                                    style: TextStyle(
                                        fontFamily: 'LeavesAndGround'),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    body: TabBarView(children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: ListView.builder(
                          padding: EdgeInsets.all(10),
                          shrinkWrap: true,
                          itemBuilder: _buildAchievement,
                          itemCount: list.length,
                        ),
                      ),
                      new ListView.builder(
                        padding: EdgeInsets.all(10),
                        shrinkWrap: true,
                        itemBuilder: _buildProgression,
                        itemCount: progression.length,
                      ),
                    ]),
                  ))),
          Positioned(
            right: -15.0,
            top: -15.0,
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
        ],
      ),
    );
  }

  Widget _buildAchievement(BuildContext context, int index) {
    return list[index].createState().build(context);
  }

  Widget _buildProgression(BuildContext context, int index) {
    return progression[index].createState().build(context);
  }
}
