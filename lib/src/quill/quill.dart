@JS()
library quill;

import 'dart:html';
import "package:js/js.dart";

/// Type definitions for Quill
/// Project: https://github.com/quilljs/quill/
/// Definitions by: Sumit <https://github.com/sumitkm>
/// Definitions: https://github.com/DefinitelyTyped/DefinitelyTyped

// Module Quill
@anonymous
@JS()
abstract class Key {
  external String get key;
  external set key(String v);
  external bool get shortKey;
  external set shortKey(bool v);
  external factory Key({String key, bool shortKey});
}

/*type Sources = "api" | "user" | "silent";*/
/*
@anonymous
@JS()
abstract class Formats {
  /* Index signature is not yet supported by JavaScript interop. */
}
*/

@anonymous
@JS()
abstract class KeyboardStatic {
  /*external void addBinding(
    Key key, void callback(RangeStatic range, dynamic context));*/
  /*external void addBinding(Key key, dynamic context,
    void callback(RangeStatic range, dynamic context));*/
  external void addBinding(
      key, dynamic /*VoidFunc2<RangeStatic, dynamic>|dynamic*/ callback_context,
      [void callback(RangeStatic range, dynamic context)]);
}

@anonymous
@JS()
abstract class ClipboardStatic {
  /*external void addMatcher(
    String selector, DeltaStatic callback(dynamic node, DeltaStatic delta));*/
  /*external void addMatcher(
    num nodeType, DeltaStatic callback(dynamic node, DeltaStatic delta));*/
  external void addMatcher(dynamic /*String|num*/ selector_nodeType,
      DeltaStatic callback(dynamic node, DeltaStatic delta));
  /*external void dangerouslyPasteHTML(String html, ['api'|'user'|'silent' source]);*/
  /*external void dangerouslyPasteHTML(num index, String html, ['api'|'user'|'silent' source]);*/
  external void dangerouslyPasteHTML(dynamic /*String|num*/ html_index,
      [String /*'api'|'user'|'silent'|String*/ source_html,
        String /*'api'|'user'|'silent'*/ source]);
}

@anonymous
@JS()
abstract class QuillOptionsStatic {
  external String get debug;
  external set debug(String v);
  external dynamic get modules;
  external set modules(dynamic v);
  external String get placeholder;
  external set placeholder(String v);
  external bool get readOnly;
  external set readOnly(bool v);
  external String get theme;
  external set theme(String v);
  external List<String> get formats;
  external set formats(List<String> v);
  external factory QuillOptionsStatic(
      {String debug,
        dynamic modules,
        String placeholder,
        bool readOnly,
        String theme,
        List<String> formats});
}

@anonymous
@JS()
abstract class BoundsStatic {
  external num get left;
  external set left(num v);
  external num get top;
  external set top(num v);
  external num get height;
  external set height(num v);
  external num get width;
  external set width(num v);
  external factory BoundsStatic({num left, num top, num height, num width});
}

@JS("Delta")
abstract class DeltaStatic {
  /*external factory DeltaStatic(List<dynamic> ops);*/
  /*external factory DeltaStatic(dynamic ops);*/
  external factory DeltaStatic(dynamic /*List<dynamic>|dynamic*/ ops);
  external List<dynamic> get ops;
  external set ops(List<dynamic> v);
  external DeltaStatic retain(num length, dynamic attributes);
  external DeltaStatic delete(num length);
  external DeltaStatic filter(dynamic predicate);
  external DeltaStatic forEach(dynamic predicate);
  external DeltaStatic insert(dynamic text, dynamic attributes);
  external DeltaStatic map(dynamic predicate);
  external DeltaStatic partition(dynamic predicate);
  external DeltaStatic reduce(dynamic predicate, num initial);
  external DeltaStatic chop();
  external num length();
  external DeltaStatic slice(num start, num end);
  external DeltaStatic compose(dynamic other);
  external DeltaStatic concat(DeltaStatic other);
  external DeltaStatic diff(DeltaStatic other, num index);
  external DeltaStatic eachLine(dynamic predicate, dynamic newline);
  external DeltaStatic transform(dynamic other, dynamic priority);
  external DeltaStatic transformPosition(num index, dynamic priority);
}

@JS("Range")
abstract class RangeStatic {
  // Constructors on anonymous interfaces are not yet supported.
  /*external factory RangeStatic();*/
  external num get index;
  external set index(num v);
  external num get length;
  external set length(num v);
}

@JS("Quill")
abstract class Quill {
  external factory Quill(dynamic /*String|Element*/ container,
      [QuillOptionsStatic options]);
  external void deleteText(num index, num length,
      [String /*'api'|'user'|'silent'*/ source]);
  external void disable();
  external void enable([bool enabled]);
  external DeltaStatic getContents([num index, num length]);
  external num getLength();
  external String getText([num index, num length]);
  external void insertEmbed(num index, String type, dynamic value,
      [String /*'api'|'user'|'silent'*/ source]);
  /*external DeltaStatic insertText(num index, String text, ['api'|'user'|'silent' source]);*/
  /*external DeltaStatic insertText(num index, String text, String format, dynamic value, ['api'|'user'|'silent' source]);*/
  /*external DeltaStatic insertText(num index, String text, Formats formats, ['api'|'user'|'silent' source]);*/
  external DeltaStatic insertText(num index, String text,
      [String /*'api'|'user'|'silent'|String*/ source_format_formats,
        dynamic /*dynamic|'api'|'user'|'silent'*/ value_source,
        String /*'api'|'user'|'silent'*/ source]);

  /// Use clipboard.dangerouslyPasteHTML(index: number, html: string, source: Sources)
  /*external String pasteHTML(num index, String html, ['api'|'user'|'silent' source]);*/
  /// Use dangerouslyPasteHTML(html: string, source: Sources): void;
  /*external String pasteHTML(String html, ['api'|'user'|'silent' source]);*/
  external String pasteHTML(dynamic /*num|String*/ index_html,
      [String /*String|'api'|'user'|'silent'*/ html_source,
        String /*'api'|'user'|'silent'*/ source]);
  external DeltaStatic setContents(DeltaStatic delta,
      [String /*'api'|'user'|'silent'*/ source]);
  external DeltaStatic setText(String text,
      [String /*'api'|'user'|'silent'*/ source]);
  external void update([String source]);
  external DeltaStatic updateContents(dynamic delta,
      [String /*'api'|'user'|'silent'*/ source]);
  external DeltaStatic format(String name, dynamic value,
      [String /*'api'|'user'|'silent'*/ source]);
  /*external DeltaStatic formatLine(num index, num length, ['api'|'user'|'silent' source]);*/
  /*external DeltaStatic formatLine(num index, num length, String format, dynamic value, ['api'|'user'|'silent' source]);*/
  /*external DeltaStatic formatLine(num index, num length, Formats formats, ['api'|'user'|'silent' source]);*/
  external DeltaStatic formatLine(num index, num length,
      [String /*'api'|'user'|'silent'|String*/ source_format_formats,
        dynamic /*dynamic|'api'|'user'|'silent'*/ value_source,
        String /*'api'|'user'|'silent'*/ source]);
  /*external DeltaStatic formatText(num index, num length, ['api'|'user'|'silent' source]);*/
  /*external DeltaStatic formatText(num index, num length, String format, dynamic value, ['api'|'user'|'silent' source]);*/
  /*external DeltaStatic formatText(num index, num length, Formats formats, ['api'|'user'|'silent' source]);*/
  external DeltaStatic formatText(num index, num length,
      [String /*'api'|'user'|'silent'|String*/ source_format_formats,
        dynamic /*dynamic|'api'|'user'|'silent'*/ value_source,
        String /*'api'|'user'|'silent'*/ source]);
  /*external Formats getFormat([RangeStatic range]);*/
  /*external Formats getFormat(num index, [num length]);*/
  external getFormat([dynamic /*RangeStatic|num*/ range_index, num length]);
  external void removeFormat(num index, num length,
      [String /*'api'|'user'|'silent'*/ source]);
  external void blur();
  external void focus();
  external BoundsStatic getBounds(num index, [num length]);
  external RangeStatic getSelection([bool focus]);
  external bool hasFocus();
  /*external void setSelection(num index, num length, ['api'|'user'|'silent' source]);*/
  /*external void setSelection(RangeStatic range, ['api'|'user'|'silent' source]);*/
  external void setSelection(dynamic /*num|RangeStatic*/ index_range,
      [dynamic /*num|'api'|'user'|'silent'*/ length_source,
        String /*'api'|'user'|'silent'*/ source]);
  external Quill on(String eventName,
      dynamic /*VoidFunc3<T, T, String>|(name: string, ...args: any[]) => void*/ callback);
  external Quill once(
      String eventName, void callback(DeltaStatic delta, String source));
  external Quill off(
      String eventName, void callback(DeltaStatic delta, String source));
  external void debug(String level);
  external dynamic JS$import(String path);
  /*external void register(String path, dynamic def, [bool suppressWarning]);*/
  /*external void register(Formats defs, [bool suppressWarning]);*/
  external void register(String path_defs,
      [dynamic /*dynamic|bool*/ def_suppressWarning, bool suppressWarning]);
  /*external dynamic addContainer(String className, [dynamic refNode]);*/
  /*external dynamic addContainer(dynamic domNode, [dynamic refNode]);*/
  external dynamic addContainer(dynamic /*String|dynamic*/ className_domNode,
      [dynamic refNode]);
  external dynamic getModule(String name);
  external ClipboardStatic get clipboard;
  external set clipboard(ClipboardStatic v);
}

// End module Quill
@JS()
external Quill get Quill2;
@JS()
external set Quill2(Quill v);
@JS()
external DeltaStatic get Delta;
@JS()
external set Delta(DeltaStatic v);
// Module quill
/* WARNING: export assignment not yet supported. */

// End module quill