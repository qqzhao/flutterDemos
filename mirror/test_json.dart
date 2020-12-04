import 'package:mirror_json/mirror_json.dart';

// Use this annotation to show that this class can be parsed.
@JsonParseable()
class Human {
  Name name;
  int age;

  Human({this.name, this.age});
}

@JsonParseable()
class Name {
  String first;
  String last;

  Name({this.first, this.last});
}

void main() {
  // Initialize the GlobalJsonParserInstance - this loads the default parsers for bool, int, etc.
  GlobalJsonParserInstance.initialize();

  // You can disable loading default parsers by initializing like so:
  // GlobalJsonParserInstance.initialize(includeBasicParsers: false);

  // Create a Parser for Human class. It will automatically create parsers for its children's classes
  // if they are marked with @JsonParseable().
  // In this case, it will automatically create a parser for Name.
  var humanParser = new ClassParser<Human>();
  // var humanParser = GlobalJsonParserInstance.getParser(#Human);
  ;

  // Create a Human instance from corresponding JSON.
  var human = humanParser.fromJson({
    "name": {"first": "Thomas", "last": "Jefferson"},
    "age": 40,
  });

  print(human.age);

  // Turn a Human instance into JSON.
  var newHuman = Human(name: Name(first: "Teddy", last: "Roosevelt"), age: 30);
  print(humanParser.toJson(newHuman));

  // Suppose we need to parse Name. To get its parser, you can use GlobalJsonParserInstance.
  var nameParser = GlobalJsonParserInstance.getParser(#Name);

  // Now you can use it to serialize / deserialize JSON.
  print(nameParser.toJson(newHuman.name));
}
