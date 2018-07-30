import 'package:fnx_ui/fnx_ui.dart';
@TestOn('dartium')

import "package:test/test.dart";

void main() {

  FnxText fnxText = null;

  test("Empty fnxText without attributes should be valid", () {
    fnxText = new FnxText(null);
    expect(fnxText.isValid(), true);
  });

  group("type=text validation", () {

    setUp(() {
      fnxText = new FnxText(null);
      fnxText.type = "text";
      fnxText.value = null;
      fnxText.required = false;
    });

    test("Required validation", () {
      fnxText.required = true;
      expect(fnxText.isValid(), false);

      fnxText.value = 12;
      expect(fnxText.isValid(), true);

      fnxText.value = "";
      expect(fnxText.isValid(), false);

      fnxText.value = true;
      expect(fnxText.isValid(), true);

      fnxText.value = null;
      expect(fnxText.isValid(), false);

    });

    test("minLength validation", () {
      fnxText.value = null;
      fnxText.required = false;
      expect(fnxText.isValid(), true);

      fnxText.minLength = 3;
      expect(fnxText.isValid(), true);

      fnxText.value = 12;
      expect(fnxText.isValid(), false);

      fnxText.value = "12";
      expect(fnxText.isValid(), false);

      fnxText.value = 123;
      expect(fnxText.isValid(), true);

      fnxText.value = "123";
      expect(fnxText.isValid(), true);

      fnxText.minLength = null;
    });

    test("maxLength validation", () {
      fnxText.value = null;
      fnxText.required = false;
      expect(fnxText.isValid(), true);

      fnxText.maxLength = 2;
      expect(fnxText.isValid(), true);

      fnxText.value = 12;
      expect(fnxText.isValid(), true);

      fnxText.value = "12";
      expect(fnxText.isValid(), true);

      fnxText.value = 123;
      expect(fnxText.isValid(), false);

      fnxText.value = "123";
      expect(fnxText.isValid(), false);

      fnxText.maxLength = null;
    });

  });


  group("type=number validation", () {

    setUp(() {
      fnxText = new FnxText(null);
      fnxText.type = "number";
      fnxText.value = null;
      fnxText.required = false;
    });

    test("Required validation", () {
      fnxText.required = true;
      expect(fnxText.isValid(), false);

      fnxText.value = 12;
      expect(fnxText.isValid(), true);

      fnxText.value = "";
      expect(fnxText.isValid(), false);

      fnxText.value = true;
      expect(fnxText.isValid(), true);

      fnxText.value = null;
      expect(fnxText.isValid(), false);

    });

    test("min validation", () {
      fnxText.value = null;
      fnxText.required = false;
      expect(fnxText.isValid(), true);

      fnxText.min = 10;
      expect(fnxText.isValid(), true); // not required, empty is allowed

      fnxText.value = 9;
      expect(fnxText.isValid(), false);

      fnxText.value = 10;
      expect(fnxText.isValid(), true);

      fnxText.value = "9";
      expect(fnxText.isValid(), false);

      fnxText.value = "10";
      expect(fnxText.isValid(), true);

      fnxText.value = "d123";
      expect(fnxText.isValid(), false); // not a number
    });

    test("max validation", () {
      fnxText.value = null;
      fnxText.required = false;
      expect(fnxText.isValid(), true);

      fnxText.max = 20;
      expect(fnxText.isValid(), true);

      fnxText.value = 12;
      expect(fnxText.isValid(), true);

      fnxText.value = "12";
      expect(fnxText.isValid(), true);

      fnxText.value = 123;
      expect(fnxText.isValid(), false);

      fnxText.value = "123";
      expect(fnxText.isValid(), false);

      fnxText.value = "12s3";
      expect(fnxText.isValid(), false); // not a number
    });


  });

  group("type=http validation", () {
    setUp(() {
      fnxText = new FnxText(null);
      fnxText.type = "http";
      fnxText.value = null;
      fnxText.required = false;
    });

    test("HTTP(s) validation", () {
      fnxText.required = false;
      expect(fnxText.isValid(), true);

      fnxText.value = 12;
      expect(fnxText.isValid(), false);

      fnxText.value = " ";
      expect(fnxText.isValid(), false);

      fnxText.value = "https://www.test.test/~emille";
      expect(fnxText.isValid(), true);

      fnxText.value = "http://www.test.test:8081/~emille/profile_.png";
      expect(fnxText.isValid(), true);

      fnxText.value = "ftp://ftp.test.test/~emille/profile_.png";
      expect(fnxText.isValid(), false);

      fnxText.value = "www.test.test/~emille/profile_.png";
      expect(fnxText.isValid(), false);

      fnxText.value = "https://";
      expect(fnxText.isValid(), false); // too short

      fnxText.value = "http://";
      expect(fnxText.isValid(), false); // too short

      fnxText.value = "http://dsda";
      expect(fnxText.isValid(), true); // edgy, but ok

      fnxText.required = true;
      fnxText.value = null;
      expect(fnxText.isValid(), false);

    });

  });

  group("type=email validation", () {
    setUp(() {
      fnxText = new FnxText(null);
      fnxText.type = "email";
      fnxText.value = null;
      fnxText.required = false;
    });

    test("HTTP(s) validation", () {
      fnxText.required = false;
      expect(fnxText.isValid(), true);

      fnxText.value = 12;
      expect(fnxText.isValid(), false);

      fnxText.value = " ";
      expect(fnxText.isValid(), false);

      fnxText.value = "asdas+fghj.ghjk@dasdas.com";
      expect(fnxText.isValid(), true);

      fnxText.value = "fghj.ghjk@das.da.ss.com";
      expect(fnxText.isValid(), true);

      fnxText.value = "fghj.ghjk@dasdas.com fghj.ghjk@dasdas.com";
      expect(fnxText.isValid(), false);

      fnxText.value = "fghj.ghjk@dasdas.com,fghj.ghjk@dasdas.com";
      expect(fnxText.isValid(), false);

      fnxText.value = "fghj.ghjk@das das.com";
      expect(fnxText.isValid(), false);

      fnxText.value = " fghj.ghjk@das das.com";
      expect(fnxText.isValid(), false);

      fnxText.value = "fghj.ghjk@dasdas.com ";
      expect(fnxText.isValid(), false);

      fnxText.required = true;
      fnxText.value = null;
      expect(fnxText.isValid(), false);

    });

  });

}
