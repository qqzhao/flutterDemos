import 'package:flutter/material.dart';
import '../options.dart';
import './model_option.dart';

List<HomeOption> options = getCombineOptionList();

class ModelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('ModelTest'),
        ),
        body: new Container(
          color: Colors.white,
          child: new ListView.builder(
              itemCount: options.length,
              shrinkWrap: true,
              itemExtent: 80.0,
              itemBuilder: (context, index) {
                HomeOption item = options[index];
                Widget cell = new Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: new Border(
                        bottom: const BorderSide(
                          color: Color(0x3f000000),
                          width: 1.0,
                        )
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(item.name),
                    ],
                  ),
                );
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, new MaterialPageRoute(
                      builder: (_){
                        return item.route;
                      },
                    ));
                  },
                  child: cell,
                );
              }),
        ),
      ),
    );
  }
}
