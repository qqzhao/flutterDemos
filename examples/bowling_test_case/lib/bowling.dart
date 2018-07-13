import 'package:flutter/material.dart';


List<int> scores = <int>[];
class Bowling {
  void reset(){
    scores = <int>[];
  }

  void roll(int score) {
//    print('current score = $score');
    scores.add(score);
  }

  // 补中的判断
  bool isBu(int score0, int score1){
    if (score0 + score1 == 10 && score0 != 10){
      return true;
    }
    return false;
  }

  // 全中的判断
  bool isQuan(int score0, int score1){
    if (score0 == 10){
      return true;
    }
    return false;
  }

  int score() {
    int total = 0;
    for(int i = 0;i < scores.length ;i = i+2){
      if (i > 19){
        break;
      }
      total = scores[i] + scores[i + 1] + total;
      if (isBu(scores[i], scores[i + 1])){
        total = total + scores[i + 2];
      } else if (isQuan(scores[i], scores[i + 1])){
        if (isQuan(scores[2], scores[i + 3])){
          total = total + scores[i + 2] + scores[i + 4];
        } else {
          total = total + scores[i + 2] + scores[i + 3];
        }
      }
    }

    reset();
    return total;
  }
}

// 保龄球规则：全中（加未来的2次）和补中（加未来的一次）。
