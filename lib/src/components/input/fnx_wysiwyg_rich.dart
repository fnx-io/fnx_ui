import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:fnx_ui/src/quill/quill.dart';


const EMPTY_STRING_VALUE = "<p><br></p>";

const CUSTOM_INPUT_WYSIWYG_RICH_VALUE_ACCESSOR = const Provider(  NG_VALUE_ACCESSOR,
    useExisting: FnxWysiwygRich,
    multi: true);
@Component(
    selector: 'fnx-wysiwyg-rich',
    template: r'''
    <div class="wysiwyg--wrapper">
      <div #toolbar>
          <span class="pointer char bold" (mousedown)="doFormatLine('header', 1)">H1</span>
          <span class="pointer char bold fs-s" (mousedown)="doFormatLine('header', 2)">H2</span>
          <span class="pointer char bold fs-xs" (mousedown)="doFormatLine('header', 3)">H3</span>
          <span class="pointer char fs-xs" (mousedown)="doFormatLine('header', false)">P</span>

          <span class="pointer icon margin--small--left" (mousedown)="doFormatText('bold')">format_bold</span>
          <span class="pointer icon" (mousedown)="doFormatText('italic')">format_italic</span>

          <span class="pointer icon margin--small--left" (mousedown)="doFormatLine('align', false)">format_align_left</span>
          <span class="pointer icon" (mousedown)="doFormatLine('align', 'center')">format_align_center</span>
          <span class="pointer icon" (mousedown)="doFormatLine('align', 'right')">format_align_right</span>

          <span class="pointer icon margin--small--left" (mousedown)="doFormatLine('list', 'bullet')">format_list_bulleted</span>
          <span class="pointer icon" (mousedown)="doFormatLine('list', 'ordered')">format_list_numbered</span>

          <span class="pointer icon margin--small--left" (mousedown)="doCreateLink()">link</span>
          <span *ngIf="imagePicker != null" class="pointer icon margin--small--left" (mousedown)="doCreateImage()">insert_photo</span>

          <!--<span class="pointer icon margin&#45;&#45;left" (mousedown)="doUndo()">undo</span>-->

          <ng-content></ng-content>
      </div>
      <div class="input--component" [style.max-width]="maxWidth" [style.height]="height">
        <div #wysiwyg
             [class.readonly]="isReadonly"
             (blur)="edited()"
             (keyup)="edited()"
             ></div>
     </div>
   </div>
''',
    styles: const [
      ":host { display: block;}",
      ":host .input--component { padding: 0;}",
      ":host .input--component a {text-decoration: underline;}",
      ":host .ql-container.ql-snow {border:0;}",
      ":host .ql-toolbar.ql-snow {display: none;}"
    ],
    providers: const [
      CUSTOM_INPUT_WYSIWYG_RICH_VALUE_ACCESSOR,
      const Provider(Focusable, useExisting: FnxWysiwygRich)
    ],
    preserveWhitespace: false
)
class FnxWysiwygRich extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy, Focusable {

  @Input() bool required = false;
  @Input() bool readonly = false;
  @Input() String height = "15";
  @Input() String maxWidth = "50";
  @Input() PickImageUrl imagePicker = null;
  @Input() bool safe = true;

  Quill quill;

  @ViewChild("wysiwyg")
  ElementRef wysiwyg;

  @ViewChild("toolbar")
  ElementRef toolbar;

  Element get editor => ((wysiwyg.nativeElement as Element).firstChild as Element);

  FnxApp app;

  FnxWysiwygRich(@Optional() this.app, @Optional() FnxForm form, @Optional() FnxInput wrapper) : super(form, wrapper) {
    if (app == null) {
      throw "Wysiwyg must be wrapped in <fxn-app> element - use this element in your root element's template.";
    }
  }

  @override
  ngOnInit() {
    super.ngOnInit();
    (wysiwyg.nativeElement as Element).innerHtml = value == null ? "" : value;

    QuillOptionsStatic options = new QuillOptionsStatic();
    options.theme = "snow";
    options.readOnly = false;
    quill = new Quill(wysiwyg.nativeElement, options);
    quill.on("change", allowInterop(edited));
  }

  bool hasValidValue() {
    if (required && (value == null || (value as String).isEmpty) || value == "<p><br></p>") return false;
    return true;
  }

  void edited() {
    String html = editor.innerHtml;
    value = (html == EMPTY_STRING_VALUE ? null : html);
    print("Edited: "+value);
    markAsTouched();
  }

  void writeValue(obj) {
    super.writeValue(obj);
    quill.pasteHTML(value == null ? "" : value);
    if (safe) {
      ((wysiwyg.nativeElement as Element).firstChild as Element).innerHtml = value == null ? "" : value;
      
    } else {
      print("Not safe: $value");
      ((wysiwyg.nativeElement as Element).firstChild as Element).setInnerHtml(value == null ? "" : value, treeSanitizer: NodeTreeSanitizer.trusted);
    }
  }

  void doFormatText(String command, [var param = true]) {
    List<Range> selection = saveSelection();
    RangeStatic range = quill.getSelection();
    if (range != null) {
      JsObject format = new JsObject.fromBrowserObject(quill.getFormat());
      if ( format != null && format.hasProperty(command)) {
        quill.formatText(range.index, range.length, command, false);
      } else {
        quill.formatText(range.index, range.length, command, param);
      }
    }
    edited();
    focus().then((_) => restoreSelection(selection));
  }

  void doFormatLine(dynamic command, dynamic param) {
    List<Range> selection = saveSelection();
    RangeStatic range = quill.getSelection();
    if (range != null) {
      quill.formatLine(range.index, range.length, command, param);
    }
    edited();
    focus().then((_) => restoreSelection(selection));
  }


  Future<Null> doCreateLink() async {
    List<Range> selection = saveSelection();
    String link = await app.input("Insert link, including http://", headline: "Link");
    if (link != null) {
      restoreSelection(selection);
      doFormatText('link', link);
    }
    edited();
    focus().then((_) => restoreSelection(selection));
  }

  Future<Null> doCreateImage() async {
    RangeStatic range = quill.getSelection();
    if (range != null) {
      String url = await imagePicker();
      if (url != null) {
        quill.insertEmbed(range.index, 'image', url);
        /*
        var delta = new JsObject.jsify({"ops":[{
          "format": {
            "index": range.index,
            "length": 1
          },
          "attributes": {
            "width": 100
          }
        }]});
        quill.updateContents(delta);
        */
      }
    }
    edited();
    focus();
  }

  Future<bool> focus() async {
    await new Future.delayed(new Duration(milliseconds: 20));
    editor.focus();
    return true;
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
  }

  void restoreSelection(List<Range> savedSel) {
    if (savedSel == null) return;
    Selection sel = window.getSelection();
    if (sel.rangeCount > 0) {
      sel.removeAllRanges();
    }
    for (var i = 0, len = savedSel.length; i < len; ++i) {
      sel.addRange(savedSel[i]);
    }
  }

}

typedef Future<String> PickImageUrl();