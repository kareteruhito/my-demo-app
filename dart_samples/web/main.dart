import 'package:web/web.dart' as web;
import 'util.dart';

int add(int a, int b) {
  return a + b;
}

int add2(int a, int b) => a + b;

void greet([String name = "Guest"]) {
  print("Hello $name");
}

class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void hello() {
    print("Hello $name");
  }
}

Future<String> fetchMessage() async {
  await Future.delayed(Duration(seconds: 1));
  return "Done";
}

Future<void> main() async {
  final element = web.document.querySelector('#output') as web.HTMLDivElement;
  final ao = greet2("Dart");
  element.textContent =
      '${ao} ';
  
  print(greet2("Dart"));

  element.onClick.listen((event) {
    print("click!");
  });

  var x = 10;
  final y = 20;
  const z = 30;  

  int count = 0;
  String message = "hello";

  var price = 100;        // int
  var name = "dart web";  // String

  dynamic value = 123;
  value = "文字列もOK";

  var s1 = 'hello';
  var s2 = "world";
  var mix = "$s1 $s2";
  var expr = "1 + 2 = ${1 + 2}";  

  var html = """
<div>
  <p>Hello Dart</p>
</div>
""";

  var list = [1, 2, 3];
  var names = <String>["a", "b", "c"];

  var map = {
    "name": "dart",
    "lang": "web"
  };
  list.add(4);
  map["age"] = "10";

  String? text;  // nullを許容
  String value2 = "ok"; // null不可

  print(text?.length); // nullなら実行されない

  var msg = await fetchMessage();
  print(msg);


  var inc = (int x) => x + 1;
  print(inc(5));

  list.forEach((e) => print(e));
}
