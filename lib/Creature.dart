import 'package:flutter/cupertino.dart';

class Creature {
  List<String> stages; // how do i make this private???
  String name = "";
  List<int> cutoffs;
  int energy;
  Creature(String name) {
    stages = [];
    cutoffs = [];
    this.name = name;
    energy = 0;
  }
  void addStage(String image, int cutoff) {
    stages.add(image);
    cutoffs.add(cutoff);
  }
  String getImageByEnergy() { // need to return the reference to the file
    String ret;
    int maxCut = -1;
    for (int i = 0; i < stages.length; i++) {
      if(maxCut < cutoffs[i] && cutoffs[i] <= energy) {
        maxCut = cutoffs[i];
        ret = stages[i];
      }
    }
    return ret;
  }
  void getEnergy(int add) {
    energy += add;
  }
}