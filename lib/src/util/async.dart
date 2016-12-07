import 'dart:async';

Future cancelSubscription(StreamSubscription subscription) {
  if (subscription != null) {
    return subscription.cancel();
  } else {
    return new Future.value(true);
  }
}

/// FnxStreamDebouncer is a Stream transformer which will wait for specified amount of time
/// before passing given value through the stream.
///
/// It can be useful for debouncing user events (scroll events, or button clicks).
///
/// If more values are delivered while the debouncer is waiting, only the last value
/// will be delivered and all other will be discarded.
///
/// Usage example:
///
///     var debouncedStream = someStream.transform(new Debouncer(new Duration(milliseconds: 200)))
///     debouncedStream.listen((data) {
///       print("$data");
///     }
class FnxStreamDebouncer<T> implements StreamTransformer<T, T> {

  StreamController _controller;

  StreamSubscription _subscription;

  bool cancelOnError;

  // Original Stream
  Stream<T> _stream;

  Timer _timer;

  Duration _duration;

  FnxStreamDebouncer(Duration duration, {bool sync: false, this.cancelOnError}) {
    this._duration = duration;

    _controller = new StreamController<T>(onListen: _onListen,
        onCancel: _onCancel,
        onPause: () {
          _subscription.pause();
        },
        onResume: () {
          _subscription.resume();
        },
        sync: sync);
  }

  Duration get duration => _duration != null? _duration: new Duration(milliseconds: 100);

  void _onCancel() {
    _subscription.cancel();
    _subscription = null;
  }

  void _onListen() {
    _subscription = _stream.listen(onData,
        onError: _controller.addError,
        onDone: _controller.close,
        cancelOnError: cancelOnError);
  }

  void onData(T data) {
    _debounce(data);
  }

  void _debounce(T data) {
    if (_timer != null) _timer.cancel();
    _timer = new Timer(duration, () {
      if (_controller != null) _controller.add(data);
    });
  }

  @override
  Stream<T> bind(Stream<T> stream) {
    this._stream = stream;
    return _controller.stream;
  }
}
