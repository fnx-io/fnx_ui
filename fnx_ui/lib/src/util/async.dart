import 'dart:async';

void later(Function f) {
  new Future.delayed(new Duration(milliseconds: 30)).then((_) => f());
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
class FnxStreamDebouncer<T> extends StreamTransformerBase<T, T?> {
  StreamController? _controller;

  StreamSubscription? _subscription;

  bool? cancelOnError;

  // Original Stream
  late Stream<T> _stream;

  Timer? _timer;

  Duration? _duration;

  FnxStreamDebouncer(Duration duration, {bool sync: false, this.cancelOnError}) {
    this._duration = duration;

    _controller = new StreamController<T>(
        onListen: _onListen,
        onCancel: _onCancel,
        onPause: () {
          _subscription!.pause();
        },
        onResume: () {
          _subscription!.resume();
        },
        sync: sync);
  }

  Duration? get duration => _duration != null ? _duration : new Duration(milliseconds: 150);

  void _onCancel() {
    _subscription!.cancel();
    _subscription = null;
  }

  void _onListen() {
    _subscription = _stream.listen(onData, onError: _controller!.addError, onDone: _controller!.close, cancelOnError: cancelOnError);
  }

  void onData(T data) {
    _debounce(data);
  }

  var data;

  void _debounce(T d) {
    data = d;
    if (_timer != null) return;
    _timer = new Timer(duration!, () {
      if (_controller != null) _controller!.add(data);
      _timer = null;
    });
  }

  @override
  Stream<T?> bind(Stream<T> stream) {
    this._stream = stream;
    return _controller!.stream as Stream<T?>;
  }
}
