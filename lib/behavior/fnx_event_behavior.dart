part of fnx_ui;

@behavior
abstract class FnxEventBehavior {

  @property
  String event = null;

  @Property(computed: 'computeHasEvent(event)')
  bool hasEvent = false;

  @reflectable
  bool computeHasEvent(String e) {
    return e != null;
  }

  @Listen('tap')
  void listenClick(Event e, detail) {
    if (event != null) {
      e.stopPropagation();
      e.preventDefault();
      print(elementToString(this)+" fires event = "+event);
      fire(event);
    }
  }

  void fire(event);

}
