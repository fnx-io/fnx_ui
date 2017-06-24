import 'dart:html';

import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:fnx_ui/src/util/global_messages.dart';
import 'package:logging/logging.dart';

const CUSTOM_INPUT_FILE_VALUE_ACCESSOR = const Provider(  NG_VALUE_ACCESSOR,
    useExisting: FnxFile,
    multi: true);
@Component(
    selector: 'fnx-file',
    template: r'''
<div class="input__file">
  <span class="input__file__dropzone" [class.drag--here]="possibleDrop()" [class.readonly]="isReadonly"
      (dragenter)="onDrag($event, true)"
      (dragleave)="onDrag($event, false)"
      (dragover)="onDragOver($event)"
      (drop)="onDrop($event)">
      {{renderDescription}}
  </span>
  <a *ngIf="!isEmpty" class="input__file__delete btn icon margin--small--right" [style.visibility]="isReadonly ? 'hidden' : 'visible'" (click)="deleteFiles()">delete</a>
  <span *ngIf="isEmpty" class="input__file__delete btn icon margin--small--right disabled" [style.visibility]="isReadonly ? 'hidden' : 'visible'" >delete</span>
  <span class="input__file__browse" data-suffix="search"
    (focus)="markAsTouched()"
    (click)="markAsTouched()"
    [class.error]="isTouchedAndInvalid()"
    [style.visibility]="isReadonly ? 'hidden' : 'visible'"
    >
      {{browseLabel}}
      <input type="file" id="{{ componentId }}"
        (focus)="markAsTouched()"
        (click)="markAsTouched()"
        (change)="onFileSelected($event)"
      >
  </span>
</div>
''',
    styles: const [
      ":host { display: block; flex-grow: 1; flex-shrink: 1; max-width: 100%}",
      ".input__file { width: 100%; }",
      ".input__file__delete { z-index: 0 }",
      ".input__file__browse { cursor: pointer }"
    ],
    providers: const [CUSTOM_INPUT_FILE_VALUE_ACCESSOR],
    preserveWhitespace: false
)
class FnxFile extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy {

  @Input()
  bool required = false;

  @Input()
  bool readonly = false;

  /// Is it possible to drag and drop multiple files?
  @Input()
  bool multi = false;

  ///
  /// Optional:
  /// If there is already a selected file in the model, use this attribute to provide file name or description.
  ///
  @Input()
  String fileName = null;

  @Output()
  EventEmitter files = new EventEmitter();

  @Input()
  String browseLabel = GlobalMessages.fileBrowse();


  //@Input() bool readonly = false;

  final Logger log = new Logger("FnxFile");

  FnxFile(@Optional() FnxForm form, @Optional() FnxInput wrapper): super(form, wrapper);

  @override
  bool hasValidValue() {
    if (required) {
      if (value == null) return false;
    }
    return true;
  }

  bool draggingOver = false;

  bool possibleDrop() {
    return draggingOver;
  }

  void onFileSelected(event) {
    if (isReadonly) return;
    processFiles(event.target.files);
  }

  void onDrag(MouseEvent event, bool enter) {
    if (isReadonly) return;
    draggingOver = enter && isCompatibleDataTransfer(event);
  }

  bool isCompatibleDataTransfer(MouseEvent event) {
    if (isReadonly) return false;
    return true;//event.dataTransfer.files != null && event.dataTransfer.files.isNotEmpty;
  }

  void onDragOver(Event event) {
    event.preventDefault();
  }

  void onDrop(MouseEvent event) {
    event.preventDefault();
    event.stopImmediatePropagation();
    if (isReadonly) return;
    processFiles(event.dataTransfer.files);
  }

  void processFiles(List<File> filesInput) {
    if (isReadonly) return;
    log.info("Processing files: ${filesInput}");
    if (filesInput == null || filesInput.isEmpty) {
      log.warning("No files on input");
      return;
    }
    if (!multi && filesInput.length > 1) {
      log.warning("Multiple files on input, but multi=false");
      return;
    }
    if (multi) {
      files.emit(filesInput);
    } else {
      files.emit(filesInput[0]);
    }
  }

  void deleteFiles() {
    if (isReadonly) return;
    value = null;
    files.emit(null);
  }

  bool get isEmpty {
    return value == null || (value is List && (value as List).isEmpty);
  }

  String get renderDescription {
    if (isEmpty) return GlobalMessages.fileDragAndDropHere();
    if (fileName != null) return fileName;
    if (value is List && value.length == 1) {
      return value[0].toString();
    }
    if (value is List) {
      int count = value.length;
      return GlobalMessages.fileSomeFilesSelected(count);
    }
    return value.toString();
  }

}