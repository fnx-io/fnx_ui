// Copyright (c) 2016, Tomucha, Majzlik ruce pryc!

import 'dart:html';

import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:logging/logging.dart';

///
/// Panel, kterému je potřeba nastavit nějakou výšku a jeho vnitřní obsah je pak skrolovatelný. Pokud user zaskroluje
/// na konec, vyvolá se událost "loadMore". Události můžou chodit v dosti rychlém sledu, tak je vhodné si přidat nějaký
/// debounce. Viz. @RestListing
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

  ElementRef template;

  Element container;

  Element content;

  static const int _LOAD_THRESHOLD = 100;

  FnxScrollPanel(this.template);

  @override
  ngOnInit() {
    this.container = (template.nativeElement as Element);
    this.content = (template.nativeElement as Element).querySelector(".scroll-panel-content");

    container.onScroll.listen(processScroll);
    content.onResize.listen(processScroll);
    content.on["DOMNodeInserted"].listen(processScroll);
    content.on["DOMNodeRemoved"].listen(processScroll);

    loadMore.emit(true);
  }

  void processScroll(event) {
    log.fine("Checking scroll state, should we load more data?");
    int bottom = container.scrollHeight - container.scrollTop;
    if (bottom < container.clientHeight + _LOAD_THRESHOLD) {
      log.info("Emiting load more event");
      loadMore.emit(true);
    }
  }

}
