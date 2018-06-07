import 'package:flutter/material.dart';
import 'package:hello/utils/serializable.dart';
import 'package:exportable/exportable.dart';

class FooTest extends Object with Exportable {
  @export String bar;
}

class JsonTestPage extends StatelessWidget {

  _test(){
    FooTest foo = new Exportable(FooTest);
    // The same as
    // Foo foo = new Foo();
    foo.bar = 'Bar';
    print(foo.toMap());
    // => {bar: Bar}
    print(foo.toJson());
    // => {"bar":"Bar"}
    print(foo.toString());
    // => {"bar":"Bar"}
    FooTest baz = new Exportable(FooTest, '{"bar":"Baz"}');
    // The same as
    // Foo baz = new Foo();
    // baz.initFromJson('{"bar":"Baz"}');
    print(baz);
    // => {"bar":"Baz"}
    FooTest baz2 = new Exportable(FooTest, {'bar': 'Baz'});
    // The same as
    // Foo baz2 = new Foo();
    // baz2.initFromMap({'bar': 'Baz'});
    print(baz2);
    // => {"bar":"Baz"}
  }

  @override
  Widget build(BuildContext context) {
//    _test();
    return Container(
      child: new Text('json test'),
    );
  }
}
