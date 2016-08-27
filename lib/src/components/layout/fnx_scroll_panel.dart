// Copyright (c) 2016, Tomucha, Majzlik ruce pryc!

import 'dart:html';

import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:fnx_ui/src/util/async.dart';
import 'package:logging/logging.dart';

///
/// Panel, kterému je potřeba nastavit nějakou výšku a jeho vnitřní obsah je pak skrolovatelný. Pokud user zaskroluje
/// na konec, vyvolá se událost "loadMore". Události můžou chodit v dosti rychlém sledu, tak je tu defaultni debounce 80ms,
/// ktery lze ovlivnit atributem debounceMs.
///
/// Použití:
///
///     <fnx-scroll-panel style="height: 100%;" (loadMore)="listing.loadNextPage()">
///         <table class="bordered striped">
///             <tr *ngFor="#e of listing.list">
///              ...
///             </tr>
///         </table>
///         ...
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
''')
class FnxScrollPanel implements OnInit {

  final Logger log = new Logger("FnxScrollPanel");

  @Output()
  EventEmitter loadMore = new EventEmitter();

  @Input()
  int debounceMs = 80;

  ElementRef template;

  Element container;

  Element content;

  static const int _LOAD_THRESHOLD = 100;

  FnxScrollPanel(this.template);

  FnxDebouncer emitDebouncer = null;

  @override
  ngOnInit() {
    this.container = (template.nativeElement as Element);
    this.content = (template.nativeElement as Element).querySelector(".scroll-panel-content");

    container.onScroll.listen(processScroll);
    content.onResize.listen(processScroll);
    content.on["DOMNodeInserted"].listen(processScroll);
    content.on["DOMNodeRemoved"].listen(processScroll);

    if (debounceMs != null && debounceMs > 0) {
      emitDebouncer = new FnxDebouncer(new Duration(milliseconds: debounceMs), doEmit);
    }

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
    if (emitDebouncer == null) {
      doEmit();
    } else {
      emitDebouncer.debounce();
    }
  }

  void doEmit() {
    log.fine("Emiting load more event (with $debounceMs ms debounce)");
    loadMore.emit(true);
  }

}