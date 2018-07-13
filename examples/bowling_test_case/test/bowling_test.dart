import 'package:flutter_test/flutter_test.dart';

import 'package:bowling_test_case/bowling.dart';

Bowling bowling = Bowling();

typedef void RollFn(int score);

void doSthWithCounter({int count,int score, RollFn fn}){
//  print('fn = $fn, score = $score');
  for(int i=0; i< count; i++){
    fn(score);
  }
}

void main(){
  test('1:all zero', (){
    doSthWithCounter(count: 20, score: 0, fn: bowling.roll);
    expect(0, bowling.score());
  });

  test('2:all one score', (){
    doSthWithCounter(count: 20, score: 1, fn: bowling.roll);
    expect(20, bowling.score());
  });

  test('3: 5/|3|-------', (){
    bowling.roll(5);
    bowling.roll(5);
    bowling.roll(3);
    doSthWithCounter(count: 17, score: 0, fn: bowling.roll);
    expect(16, bowling.score());
  });

  test('4: X|3 4|-------', (){
    bowling.roll(10);
    bowling.roll(0);
    bowling.roll(3);
    bowling.roll(4);
    doSthWithCounter(count: 16, score: 0, fn: bowling.roll);
    expect(24, bowling.score());
  });

  test('5: quanzhong|-------', (){
    final List<int> scoreList = <int>[10,0,10,0,10,0,10,0,10,0,10,0,10,0,10,0,10,0,10,0,10,0,10,0,10,0,10,0,10,0,10,0,10,0,10,0,10,0];
//    print('scoreList.length = ${scoreList.length}');
    for (int i = 0;i< 24; i++){
      bowling.roll(scoreList[i]);
    }
    expect(300, bowling.score());
  });
}



