import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hello/components/scroll_to_index/auto_scroll_tag.dart';
import 'package:hello/components/scroll_to_index/scroll_to_index.dart';

class ScrollToPageIndexPage extends StatefulWidget {
  const ScrollToPageIndexPage({Key? key}) : super(key: key);

  @override
  _ScrollToPageIndexPageState createState() => _ScrollToPageIndexPageState();
}

class ItemType {
  double height;
  Color color;
  String title;

  ItemType({this.height = 0, this.color = Colors.black, this.title = ''});
}

class _ScrollToPageIndexPageState extends State<ScrollToPageIndexPage> {
  final controller = AutoScrollController();
  List<ItemType> randomList = [
    ItemType(height: 350, color: Colors.red, title: '1'),
    ItemType(height: 203, color: Colors.black12, title: '1'),
    ItemType(height: 200, color: Colors.black26, title: '1'),
    ItemType(height: 300, color: Colors.black38, title: '1'),
    ItemType(height: 130, color: Colors.black54, title: '1'),
    ItemType(height: 250, color: Colors.black87, title: '1'),
    ItemType(height: 200, color: Colors.purple, title: '1'),
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('scroll to index'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: randomList.length,
                itemBuilder: (context, index) {
                  var element = randomList[index];
                  return AutoScrollTag(
                    key: ValueKey(index),
                    controller: controller,
                    index: index,
                    child: Container(
                      height: element.height,
                      color: element.color,
                      child: Center(child: Text('index: $index')),
                    ),
                    highlightColor: Colors.black.withOpacity(0.1),
                  );
                },
                controller: controller,
                // children: randomList.mapIndexed((index, element) {
                //   return AutoScrollTag(
                //     key: ValueKey(index),
                //     controller: controller,
                //     index: index,
                //     child: Container(
                //       height: element.height,
                //       color: element.color,
                //       child: Center(child: Text('index: $index')),
                //     ),
                //     highlightColor: Colors.black.withOpacity(0.1),
                //   );
                // }).toList(),
              ),
            ),
          ),
          Container(
            child: Wrap(
              children: randomList
                  .mapIndexed((index, e) => GestureDetector(
                        onTap: () {
                          controller.scrollToIndex(index, duration: Duration(milliseconds: 200), preferPosition: AutoScrollPosition.begin);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black54,
                          ),
                          width: 30,
                          height: 30,
                          child: Center(
                            child: Text('$index'),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.highlight(1, highlightDuration: Duration(seconds: 1));
        },
        child: Text('1'),
      ),
    );
  }
}
