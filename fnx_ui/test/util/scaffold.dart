import '../../bin/src/_scaffold_model.dart';
import 'package:test/test.dart';

void main() {
  test("Scaffolding tools", () {
    expect("HelloWorld", new Identificator("hello_world").camelCase);
    try {
      new Identificator("Hoj");
      fail("Identificator validation is broken");
    } on String catch (e) {}
    try {
      new Identificator("hello-world");
      fail("Identificator validation is broken");
    } on String catch (e) {}
    try {
      new Identificator("12_monkeys");
      fail("Identificator validation is broken");
    } on String catch (e) {}
  });
}
