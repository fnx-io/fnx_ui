import 'dart:async';
import 'dart:html';

import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:fnx_ui/src/validator.dart';

const CUSTOM_INPUT_WYSIWYG_POOR_VALUE_ACCESSOR =
    const Provider(NG_VALUE_ACCESSOR, useExisting: FnxWysiwygPoor, multi: true);

@Component(
  selector: 'fnx-wysiwyg-poor',
  template: r'''
    <div class="wysiwyg--wrapper flex--column">
      <div class="margin--small--bottom">
          <span class="pointer icon margin--small--right" (mousedown)="doCommand('undo')">undo</span>
          <span class="pointer icon margin--right" (mousedown)="doCommand('redo')">redo</span>
          <span class="pointer btn icon margin--small--right" (mousedown)="doCommand('bold')">format_bold</span>
          <span class="pointer btn icon margin--small--right" (mousedown)="createLink()">link</span>
      </div>
      <div #wysiwyg
           class="input--component flex--grow flex--shrink"
           [class.readonly]="isReadonly"
           [attr.contenteditable]="!readonly"
           (blur)="edited()"
           (keyup)="edited()"
           ></div>
     </div>
''',
  styles: const [
    ":host { display: block; height: 10em; }",
    ":host .wysiwyg--wrapper { height: 100% }",
    ":host .input--component { overflow-y: scroll; }",
    ":host .input--component a {text-decoration: underline;}",
    ":host .input--component div {margin-top: 0.6em;}",
    ":host .input--component p {margin-top: 0.6em;}",
  ],
  providers: const [
    CUSTOM_INPUT_WYSIWYG_POOR_VALUE_ACCESSOR,
    const Provider(FnxValidatorComponent, useExisting: FnxWysiwygPoor, multi: false),
  ],
  preserveWhitespace: false,
)
class FnxWysiwygPoor extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy {
  @Input()
  bool required = false;
  @Input()
  bool readonly = false;

  @ViewChild("wysiwyg")
  ElementRef editor;

  FnxApp app;

  FnxWysiwygPoor(@Optional() this.app, @SkipSelf() @Optional() FnxValidatorComponent parent) : super(parent) {
    if (app == null) {
      throw "Wysiwyg must be wrapped in <fxn-app> element - use this element in your root element's template.";
    }
  }

  @override
  ngOnInit() {
    super.ngOnInit();
    (editor.nativeElement as Element).innerHtml = value == null ? EMPTY_STRING_VALUE : value;
  }

  bool hasValidValue() {
    if (required && (value == null || (value as String).isEmpty) || value == EMPTY_STRING_VALUE) return false;
    return true;
  }

  void edited() {
    String html = editor.nativeElement.innerHtml;
    value = (html == EMPTY_STRING_VALUE ? null : html);
    markAsTouched();
  }

  void writeValue(obj) {
    super.writeValue(obj);
    (editor.nativeElement as Element).innerHtml = (value == null || value.isEmpty) ? EMPTY_STRING_VALUE : value;
  }

  void doCommand(String command) {
    window.document.execCommand(command, false);
    edited();
  }

  Future<Null> createLink() async {
    List<Range> selection = saveSelection();
    String link = await app.input("Insert link, including http://", headline: "Link");
    if (link != null) {
      restoreSelection(selection);
      window.document.execCommand('createLink', false, link);
    }
    edited();
  }

  List saveSelection() {
    Selection sel = window.getSelection();
    if (sel.rangeCount > 0) {
      List<Range> ranges = [];
      for (var i = 0; i < sel.rangeCount; ++i) {
        ranges.add(sel.getRangeAt(i));
      }
      return ranges;
    }
    return [];
  }

  void restoreSelection(List<Range> savedSel) {
    Selection sel = window.getSelection();
    if (sel.rangeCount > 0) {
      sel.removeAllRanges();
    }
    for (var i = 0, len = savedSel.length; i < len; ++i) {
      sel.addRange(savedSel[i]);
    }
  }

  @override
  bool get disabled => false;
}
