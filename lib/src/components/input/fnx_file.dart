import 'package:angular2/core.dart';
import 'package:angular2/common.dart';
import 'package:fnx_ui/src/util/ui.dart' as ui;
import 'package:fnx_ui/fnx_ui.dart';
import 'package:fnx_ui/src/components/input/fnx_input.dart';
import 'package:angular2/src/common/forms/directives/validators.dart';
import 'package:fnx_ui/src/validator.dart';
import 'dart:html';
import 'package:logging/logging.dart';

const CUSTOM_INPUT_FILE_VALUE_ACCESSOR = const Provider(  NG_VALUE_ACCESSOR,
    useExisting: FnxFile,
    multi: true);
@Component(
    selector: 'fnx-file',
    template: r'''
<div class="input__file">
  <span class="input__file__dropzone" [class.drag--here]="possibleDrop()"
      (dragenter)="onDrag($event, true)"
      (dragleave)="onDrag($event, false)"
      (dragover)="onDragOver($event)"
      (drop)="onDrop($event)">
      {{renderDescription}}
  </span>
  <a *ngIf="!isEmpty" class="input__file__delete btn icon margin--small--right" (click)="deleteFiles()">delete</a>
  <span *ngIf="isEmpty" class="input__file__delete btn icon margin--small--right disabled">delete</span>
  <span class="input__file__browse" data-suffix="search"
    (focus)="markAsTouched()"
    (click)="markAsTouched()"
    [class.error]="isTouchedAndInvalid()">
      Browse
      <input type="file" id="{{ componentId }}"
        (focus)="markAsTouched()"
        (click)="markAsTouched()"
        (change)="onFileSelected($event)"
      >
  </span>
</div>
''',
    styles: const [
      ":host { display: block; flex-grow: 1; flex-shrink: 1;}",
      ".input__file { width: 100%; }",
      ".input__file__delete { z-index: 0 }"
    ],
    providers: const [CUSTOM_INPUT_FILE_VALUE_ACCESSOR]
)
class FnxFile extends FnxInputComponent implements ControlValueAccessor, OnInit, OnDestroy {

  @Input()
  bool required = false;

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
    processFiles(event.target.files);
  }

  void onDrag(MouseEvent event, bool enter) {
    draggingOver = enter && isCompatibleDataTransfer(event);
  }

  bool isCompatibleDataTransfer(MouseEvent event) {
    return true;//event.dataTransfer.files != null && event.dataTransfer.files.isNotEmpty;
  }

  void onDragOver(Event event) {
    event.preventDefault();
  }

  void onDrop(MouseEvent event) {
    event.preventDefault();
    event.stopImmediatePropagation();
    processFiles(event.dataTransfer.files);
  }

  void processFiles(List<File> filesInput) {
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
    value = null;
    files.emit(null);
  }

  bool get isEmpty {
    return value == null || (value is List && (value as List).isEmpty);
  }

  String get renderDescription {
    if (isEmpty) return "Drag'n'drop a file here";
    if (fileName != null) return fileName;
    if (value is List && value.length == 1) {
      return value[0].toString();
    }
    if (value is List) {
      int count = value.length;
      return "$count files selected";
    }
    return value.toString();
  }

}

/*
class FormFileInput extends FormComponent implements

  void processFiles(List<File> files) {
  }OnInit, AfterViewInit {
  final Logger log = new Logger("FormFileInput");

  String inputField = ui.uid("file-input-");

  @Input()
  String label;

  @Input()
  String errorMessage;

  NgForm formCtrl;
  @Input()
  var inputModel;

  @Output()
  EventEmitter inputModelChange = new EventEmitter();

  RestClient rest;

  @Optional()
  @Input()
  bool required = false;

  @Optional()
  @Input()
  String mimePattern;

  String mimeValue = null;

  bool working = false;
  String uploadError = null;

  FormFileInput(FormWrapper wrap, RestClient rest): super(wrap) {
    formCtrl = wrap.formCtrl;
    this.rest = rest.child("/v1/uploads");
  }

  Control control = null;

  ngOnInit() {
    List<ValidatorFn> validators = [];
    if (required) {
      validators.add((AbstractControl control) {
        return inputModel == null ? {"required": true} : null;
      });
    }
    if (mimePattern != null) {
      validators.add((AbstractControl control) {
        if (inputModel == null) return null;
        if ((inputModel as String).startsWith("http")) return null; // to je url ze serveru, to je asi ulozeny dobre
        if (mimeValue == null) return {"mime": true};
        var regex = new RegExp('''^${ mimePattern}\$''');
        return regex.hasMatch(mimeValue) ? null : {"mime": true};
      });
    }

    control = new Control('', Validators.compose(validators));
    this.formCtrl.control..addControl(this.inputField, control);
  }

  bool get showError => !control.valid && !control.root.pristine;

  onChangeInput(event) {
    uploadError = null;
    control.markAsDirty();

    if (event.target.files is! List || event.target.files.isEmpty) {
      log.warning("No file");
      inputModel = null;
      mimeValue = null;
      this.inputModelChange.emit(inputModel);
    } else {
      File file = event.target.files[0];
      inputModel = file.name;
      mimeValue = file.type;

      if (mimePattern != null) {
        log.info("Invalid mime type");
        var regex = new RegExp('''^${ mimePattern}\$''');
        if (!regex.hasMatch(mimeValue)) {
          control.updateValueAndValidity();
          inputModel = null;
          mimeValue = null;
          this.inputModelChange.emit(inputModel);
          return;
        }
      }
      log.info("Uploading");
      working = true;
      inputModel = null;
      mimeValue = null;
      this.inputModelChange.emit(inputModel);

      _uploadFile(file).then((url) {
        working = false;
        inputModel = url;
        this.inputModelChange.emit(inputModel);
        control.updateValueAndValidity();
      }).catchError((e) {
        working = false;
        inputModel = null;
        mimeValue = null;
        this.inputModelChange.emit(inputModel);
        uploadError = "Upload failed, please check your connection and try again";
      });
    }
    control.updateValueAndValidity();
  }

  String fileId = null;

  Future<String> _uploadFile(File file) async {
    fileId = null;
    int page = 0;
    String url = null;
    while (url == null) {
      url = await _uploadFilePart(file, page);
      page++;
    }
    return url;
  }

  Future<String> _uploadFilePart(File file, int page) async {
    String fileName = file.name;
    fileName = removeAccents(fileName.toLowerCase());
    fileName = fileName.replaceAll(new RegExp("[^a-z10-9._-]"), "-");
    log.info("Using filename ${fileName}");

    int pageSize = fnxConfig()["fileUploadPageSize"];
    int start = page * pageSize;
    int end = (page + 1) * pageSize;

    String mimeType = file.type;

    end = min(file.size, end);

    log.info("Uploading file part $page (size=$pageSize)");
    FileReader reader = new FileReader();
    // reader.onProgress.listen((_) => print(_));
    reader.onError.listen((_) => throw _);
    reader.readAsArrayBuffer(file.slice(start, end));
    await reader.onLoad.first;

    String newId = await rest.child("/${fileId == null ? '' : fileId}").post(reader.result, extraHeaders: {"X-Filename": fileName, "Content-Type": mimeType});
    fileId = newId;

    if (end == file.size) {
      // last page, commit returns new fileUrl
      return await rest.child("/${fileId}/commit").get();
    } else {
      // file URL is not known, we need to continue
      return null;
    }
  }

  @override
  ngAfterViewInit() {
    control.updateValueAndValidity();
  }
}

 */