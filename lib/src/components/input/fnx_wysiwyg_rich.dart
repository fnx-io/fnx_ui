import 'dart:async';
import 'dart:html';
import 'dart:js';

import 'package:angular2/common.dart';
import 'package:angular2/core.dart';

import 'package:async/async.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:fnx_ui/src/quill/quill.dart';
import 'package:fnx_ui/src/validator.dart';

const EMPTY_STRING_VALUE = "<p><br></p>";

const CUSTOM_INPUT_WYSIWYG_RICH_VALUE_ACCESSOR =
const Provider(NG_VALUE_ACCESSOR, useExisting: FnxWysiwygRich, multi: true);

@Component(
  selector: 'fnx-wysiwyg-rich',
  template: r'''
    <div class="wysiwyg--wrapper">
      <div #toolbar>
          <span class="icon-container" [class.is--html]="htmlView == true">
            <span class="pointer char bold" (mousedown)="doFormatLine('header', 1)">H1</span>
            <span class="pointer char bold fs-s" (mousedown)="doFormatLine('header', 2)">H2</span>
            <span class="pointer char bold fs-xs" (mousedown)="doFormatLine('header', 3)">H3</span>
            <span class="pointer char bold fs-xs" (mousedown)="doFormatLine('header', false)">P</span>
  
            <span class="pointer icon margin--small--left" (mousedown)="doFormatText('bold')">format_bold</span>
            <span class="pointer icon" (mousedown)="doFormatText('italic')">format_italic</span>
  
            <span class="pointer icon margin--small--left" (mousedown)="doFormatLine('align', false)">format_align_left</span>
            <span class="pointer icon" (mousedown)="doFormatLine('align', 'center')">format_align_center</span>
            <span class="pointer icon" (mousedown)="doFormatLine('align', 'right')">format_align_right</span>
  
            <span class="pointer icon margin--small--left" (mousedown)="doFormatLine('list', 'bullet')">format_list_bulleted</span>
            <span class="pointer icon" (mousedown)="doFormatLine('list', 'ordered')">format_list_numbered</span>
  
            <span class="pointer icon margin--small--left" (mousedown)="doCreateLink()">link</span>
            <span *ngIf="imagePicker != null" class="pointer icon margin--small--left" (mousedown)="doCreateImage()">insert_photo</span>
          </span>

          <span class="pointer icon margin--small--left" (mousedown)="toggleView()">code</span>

          <!--<span class="pointer icon margin&#45;&#45;left" (mousedown)="doUndo()">undo</span>-->

          <ng-content></ng-content>
      </div>
      <div class="input--component" [style.max-width]="maxWidth" [style.height]="height">
        <div #wysiwyg
             [hidden]="htmlView == true"
             [class.readonly]="isReadonly"
             (blur)="edited()"
             (keyup)="edited()"
             ></div>

         <fnx-textarea [(ngModel)]="value"
                       [hidden]="htmlView == false" 
                       [class.readonly]="isReadonly"
                       ></fnx-textarea>
     </div>
   </div>
''',
  styles: const [
    ":host { display: block;}",
    ":host .input--component { padding: 0;}",
    ":host .input--component a {text-decoration: underline;}",
    ":host .ql-container.ql-snow {border:0;}",
    ":host .ql-toolbar.ql-snow {display: none;}",
    ":host fnx-textarea, :host fnx-textarea textarea {min-width: 100%; width: 100%; max-width: 100%; min-height: 100%; height: 100%; max-height: 100%;}",
    ":host .icon-container.is--html {color: #777 !important; pointer-events: none;}"
  ],
  providers: const [
    CUSTOM_INPUT_WYSIWYG_RICH_VALUE_ACCESSOR,
    const Provider(Focusable, useExisting: FnxWysiwygRich),
    const Provider(FnxValidatorComponent, useExisting: FnxWysiwygRich, multi: false),
  ],
  preserveWhitespace: false,
)
class FnxWysiwygRich extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy, Focusable {
  @Input()
  bool required = false;
  @Input()
  bool readonly = false;
  @Input()
  String height = '15';
  @Input()
  String maxWidth = '50';
  @Input()
  PickImageUrl imagePicker = null;
  @Input()
  bool safe = true;

  Quill quill;

  @Input('initWithHtmlView')
  bool htmlView = false;

  @ViewChild('wysiwyg')
  ElementRef wysiwyg;

  @ViewChild('toolbar')
  ElementRef toolbar;

  StreamSubscription keySubscription;

  Element get editor => ((wysiwyg.nativeElement as Element).firstChild as Element);

  FnxApp app;

  FnxWysiwygRich(@Optional() this.app, @SkipSelf() @Optional() FnxValidatorComponent parent) : super(parent) {
    if (app == null) {
      throw "Wysiwyg must be wrapped in <fxn-app> element - use this element in your root element's template.";
    }
  }

  @override
  ngOnInit() {
    super.ngOnInit();
    Element el = (wysiwyg.nativeElement as Element);
    el.innerHtml = value == null ? '' : value;

    QuillOptionsStatic options = new QuillOptionsStatic();
    options.theme = "snow";
    options.readOnly = false;
    quill = new Quill(wysiwyg.nativeElement, options);
    quill.on("change", allowInterop(edited));

    keySubscription = StreamGroup.merge([el.onDragEnd, el.onKeyUp]).listen((_) {
      new Future.delayed(new Duration(milliseconds: 100), edited);
    });
  }


  @override
  ngOnDestroy() {
    super.ngOnDestroy();
    if (keySubscription != null) {
      keySubscription.cancel();
      keySubscription = null;
    }
  }

  bool hasValidValue() {
    if (required && (value == null || (value as String).isEmpty) || value == "<p><br></p>") return false;
    return true;
  }

  void edited() {
    String html = editor.innerHtml;
    value = (html == EMPTY_STRING_VALUE ? null : html);
    markAsTouched();
  }

  void writeValue(obj) {
    super.writeValue(obj);
    quill.pasteHTML(value??'');
    if (safe) {
      ((wysiwyg.nativeElement as Element).firstChild as Element).innerHtml = value == null ? '' : value;
    } else {
      ((wysiwyg.nativeElement as Element).firstChild as Element)
          .setInnerHtml(value == null ? '' : value, treeSanitizer: NodeTreeSanitizer.trusted);
    }
  }

  void toggleView() {
    htmlView ??= false;
    htmlView = !htmlView;

    if (htmlView) {
      edited();
    } else {
      quill.pasteHTML(value??'');
    }
  }

  Future doFormatText(String command, [var param = true]) async {
    RangeStatic selection = quill.getSelection();

    if (selection != null) {
      JsObject format = new JsObject.fromBrowserObject(quill.getFormat(selection.index, selection.length));
      if (format.hasProperty('o')) {
        format = format['o'];
      }
      if (format != null && format.hasProperty(command)) {
        quill.formatText(selection.index, selection.length, command, false);
      } else {
        quill.formatText(selection.index, selection.length, command, param);
      }
    }

    edited();
    await focus();
    restoreSelection(selection);
  }

  Future doFormatLine(dynamic command, dynamic param) async {
    RangeStatic selection = quill.getSelection();

    if (selection != null) {
      quill.formatLine(selection.index, selection.length, command, param);
    }

    edited();
    await focus();
    restoreSelection(selection);
  }

  Future<Null> doCreateLink() async {
    RangeStatic selection = quill.getSelection();

    String link = await app.input("Insert link, including http://", headline: "Link");

    if (link != null) {
      if (selection != null) {
        restoreSelection(selection);
        doFormatText('link', link);
      } else {
        quill.insertText(0, link);
        quill.setSelection(0, link.length);
        doFormatText('link', link);
      }
    }

    edited();
    await focus();
    restoreSelection(selection);
  }

  Future<Null> doCreateImage() async {
    RangeStatic selection = quill.getSelection();

    String url = await imagePicker();

    if (url != null) {
      if (selection != null) {
        quill.insertEmbed(selection.index, 'image', url);
      } else {
        quill.setSelection(0, 0);
        quill.insertEmbed(selection.index, 'image', url);
      }
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

    edited();
    await focus();
  }

  Future<bool> focus() async {
    await new Future.delayed(new Duration(milliseconds: 20));
    editor.focus();
    return true;
  }

  void restoreSelection(RangeStatic savedSel) {
    if (savedSel != null) {
      quill.setSelection(savedSel.index, savedSel.length);
    }
  }

  @override
  bool get disabled => false;
}

typedef Future<String> PickImageUrl();
