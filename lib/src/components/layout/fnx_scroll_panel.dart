// Copyright (c) 2016, Tomucha, Majzlik ruce pryc!

import 'dart:async';
import 'dart:html';

import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:fnx_ui/src/util/async.dart';
import 'package:logging/logging.dart';

///
/// Srollable panel which emits (loadMore) event whenever the user scrolls to the bottom of current content.
/// Make sure the panel has some height, either set it to some value (style="height: 20em") or place the panel
/// into `<div class="flex--column">`. Etc.
///
/// (loadMore) events might be emmited very frequently. Use debounceMs attribute to set 'debounce'. '200' might be a reasonable value, default is 80.
///
///
///       <fnx-scroll-panel (loadMore)="listing.loadNextPage()">
///           <table class="table--border">
///               <tr *ngFor="let e of listing.list">
///                ...
///               </tr>
///           </table>
///           ...
///
@Component(
    selector: 'fnx-scroll-panel',
    template: r'''
<style>
  :host {
    overflow-y: auto;
    display: block;
    position: relative;
  }
</style>
<div class="scroll-panel-content">
  <ng-content></ng-content>
</div>
''',
    preserveWhitespace: false
)
class FnxScrollPanel implements OnInit {

  final Logger log = new Logger("FnxScrollPanel");

  @Output()
  EventEmitter loadMore = new EventEmitter();

  ///
  /// Input. Debounce of (loadMore) events in ms.
  ///
  @Input()
  int debounceMs = 80;

  ElementRef template;

  Element container;

  Element content;

  static const int _LOAD_THRESHOLD = 100;

  StreamController<int> _debounceCtrl;

  FnxScrollPanel(this.template);

  @override
  ngOnInit() {
    this.container = (template.nativeElement as Element);
    this.content = (template.nativeElement as Element).querySelector(".scroll-panel-content");

    container.onScroll.listen(processScroll);
    content.onResize.listen(processScroll);
    content.on["DOMNodeInserted"].listen(processScroll);
    content.on["DOMNodeRemoved"].listen(processScroll);

    _debounceCtrl = new StreamController<int>();
    Stream<int> eventStream = _debounceCtrl.stream;
    // debounce the stream of load events if we have some duration
    if (debounceMs != null && debounceMs > 0) {
      FnxStreamDebouncer<int> debouncer = new FnxStreamDebouncer<int>(new Duration(milliseconds: debounceMs));
      eventStream = eventStream.transform(debouncer);
    }
    eventStream.listen((_) => doEmit());

    processScroll(null);
  }

  void processScroll(event) {
    //log.finest("Checking scroll state, should we load more data?");
    int bottom = container.scrollHeight - container.scrollTop;
    if (bottom < container.clientHeight + _LOAD_THRESHOLD) {
      debounceEmitLoadMore();
    }
  }

  void debounceEmitLoadMore() {
    _debounceCtrl.add(new DateTime.now().millisecondsSinceEpoch);
  }

  void doEmit() {
    log.fine("Emiting load more event (with $debounceMs ms debounce)");
    loadMore.emit(true);
  }

}
