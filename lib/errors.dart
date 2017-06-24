library errors;

///
/// This class represents any error you need to display to the user.
///
/// Error must have a "message" and it can have "headline" and "details". "Details"
/// is an "Iterable" which will be rendered as <ul><li>element.toString()</li> for each
/// element.
///
/// You are supposed to register your own custom exception handlers like this:
///
///     (handler as FnxExceptionHandler).registerErrorProcessor(CustomException, processCustomException);
///
/// Where processCustomException receives exception of the specified type and can return either FnxError to show something to
/// the user, or process exception completely and return null.
///
///

import 'package:angular2/core.dart';
import 'package:angular2/src/facade/base_wrapped_exception.dart';
import 'package:logging/logging.dart';
/// This class represents any error you need to display to the user.
///
/// Error must have a "message" and it can have "headline" and "details". "Details"
/// is an "Iterable" which will be rendered as <ul><li>element.toString()</li> for each
/// element.
///
/// You are supposed to register your own custom exception handlers like this:
///
///     (handler as FnxExceptionHandler).registerErrorProcessor(CustomException, processCustomException);
///
/// Where processCustomException receives exception of the specified type and can return either FnxError to show something to
/// the user, or process exception completely and return null.
///
///


class FnxError {

  String _headline;
  String _message;
  List<Object> _details;

  String get headline => _headline;
  String get message => _message;
  Iterable<Object> get details => _details;

  FnxError(String message, {String headline: "Error", Iterable<Object> details: null}) {
    _message = message ?? "Unknown error";
    _headline = headline ?? "Error";
    _details = details ?? [];
  }

}

///
/// This type of function should be registered to FnxExceptionHandler to display errors.
/// FnxApp provides this function.
///
typedef void ShowErrorHookType(FnxError errorToShow);

///
/// This type of function can be used to customize exception handling in case you throw
/// your own exceptions.
///
typedef FnxError ErrorProcessorType(dynamic exception, dynamic stacktrace);

///
///
///
class FnxExceptionHandler implements ExceptionHandler {

  final Logger log = new Logger("FnxExceptionHandler");

  bool _rethrowException;

  FnxExceptionHandler([this._rethrowException = false]) {

    registerErrorProcessor(String, (dynamic exception, dynamic stacktrace) {
      return new FnxError(exception.toString());
    });

  }

  Map<Type, ErrorProcessorType> _errorBuilders = {};
  ShowErrorHookType _showErrorHook;

  ///
  /// Customize exception handler with this method.
  ///
  void registerErrorProcessor(Type type, ErrorProcessorType builder) {
    _errorBuilders[type] = builder;
  }

  ///
  ///
  ///
  void setShowErrorCallback(ShowErrorHookType showErrorHook) {
    this._showErrorHook = showErrorHook;
  }

  ///
  /// Process uncaught exception.
  ///
  void call(dynamic exception,  [dynamic stackTrace = null, String reason = null]) {
    var originalException = this._findOriginalException(exception);
    var originalStack = this._findOriginalStack(exception);
    var context = this._findContext(exception);


    // ... first, let's render exception to the log
    List<String> messages = [];

    messages.add('''EXCEPTION: ${ this . _extractMessage ( exception )}''');
    if (stackTrace != null && originalStack == null) {
      messages.add("STACKTRACE:");
      messages.add(this._longStackTrace(stackTrace));
    }
    if (reason != null) {
      messages.add('''REASON: ${ reason}''');
    }
    if (originalException != null) {
      messages.add('''ORIGINAL EXCEPTION: ${ this . _extractMessage ( originalException )}''');
    }
    if (originalStack != null) {
      messages.add("ORIGINAL STACKTRACE:");
      messages.add(this._longStackTrace(originalStack));
    }
    if (context != null) {
      messages.add("ERROR CONTEXT:");
      messages.add(context);
    }
    log.severe(messages.join("\n"));

    // ... and then try to display exception on UI
    FnxError errorToShow = null;
    if (originalException != null) {
      errorToShow = _processError(originalException, originalStack);
    } else {
      errorToShow = _processError(exception, stackTrace);
    }

    if (errorToShow == null) {
      log.fine("Error to show is null, hopefully it got processed some other way");

    } else {
      if (_showErrorHook != null) {
        _showErrorHook(errorToShow);
      } else {
        log.warning("Cannot display error on UI, probably missing <fnx-app> element in your main application component?");
      }
    }

    // when an exception happens. If we do not rethrow, bootstrap will always succeed.
    if (this._rethrowException) throw exception;

  }

  FnxError _processError(originalException, originalStack) {
    for (Type type in _errorBuilders.keys) {
      if (originalException.runtimeType == type) {
        if (_errorBuilders[type] == null) return null;
        return _errorBuilders[type](originalException, originalStack);
      }
    }
    log.warning("Unknown FnxError builder for exception of type '${originalException.runtimeType}', use method registerErrorBuilder(...)");
    return new FnxError(originalException.toString());
  }

  String _extractMessage(dynamic exception) {
    return exception is BaseWrappedException
        ? exception.wrapperMessage
        : exception.toString();
  }

  dynamic _longStackTrace(dynamic stackTrace) {
    return stackTrace is Iterable
        ? ((stackTrace as List<dynamic>)).join("\n\n-----async gap-----\n")
        : stackTrace.toString();
  }

  dynamic _findContext(dynamic exception) {
    try {
      if (!(exception is BaseWrappedException)) return null;
      return exception.context ??
          this._findContext(exception.originalException);
    } catch (e) {
      // exception.context can throw an exception. if it happens, we ignore the context.
      return null;
    }
  }

  dynamic _findOriginalException(dynamic exception) {
    if (!(exception is BaseWrappedException)) return null;
    var e = exception.originalException;
    while (e is BaseWrappedException && e.originalException != null) {
      e = e.originalException;
    }
    return e;
  }

  dynamic _findOriginalStack(dynamic exception) {
    if (!(exception is BaseWrappedException)) return null;
    var e = exception;
    var stack = exception.originalStack;
    while (e is BaseWrappedException && e.originalException != null) {
      e = e.originalException;
      if (e is BaseWrappedException && e.originalException != null) {
        stack = e.originalStack;
      }
    }
    return stack;
  }
}

