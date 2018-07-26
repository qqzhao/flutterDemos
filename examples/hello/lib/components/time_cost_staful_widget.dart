import 'package:flutter/material.dart';

class TETimeCostWidget extends StatefulWidget {

  TETimeCostWidget({Key key}): super(key: key);

  @override
  TETimeCostWidgetState createState() => TETimeCostWidgetState();
}

class TETimeCostWidgetState<T extends TETimeCostWidget> extends State with WidgetsBindingObserver {
  DateTime _enterDataTime; // 需要初始化state的时候传入
  String costTimeKey;
//  TECostDataType costType = TECostDataType.homeworkCost;

  T get widget => super.widget as T;

  @override
  void initState() {
    _enterDataTime = DateTime.now();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _commitExtentCost();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

//  @override // need super call.
  @mustCallSuper
  Widget build(BuildContext context) {
    costTimeKey = 'setId';
    return Container();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
//        log.info('paused.....');
        _commitExtentCost();
        break;
      case AppLifecycleState.resumed:
        _enterDataTime = DateTime.now();
//        log.info('resumed.....');
        break;
      default:
    }
  }

  _commitExtentCost (){
    if (mounted){
      num cost = DateTime.now().difference(_enterDataTime).inSeconds;
//      TEHomeworkCostManager.sharedInstance.addCostData(cost: cost, costType: costType, homeworkId: costTimeKey);
      _enterDataTime = DateTime.now();
    }
  }
}
