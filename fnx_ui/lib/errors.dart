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

import 'package:angular/angular.dart';
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
  @override
  void call(dynamic exception,  [dynamic stackTrace = null, String reason = null]) {
    log.severe(ExceptionHandler.exceptionToString(exception, stackTrace, reason));

    // ... and then try to display exception on UI
    FnxError errorToShow = null;
    errorToShow = _processError(exception, stackTrace);

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

  FnxError _processError(exception, stacktrace) {
    for (Type type in _errorBuilders.keys) {
      if (exception.runtimeType == type) {
        if (_errorBuilders[type] == null) return null;
        return _errorBuilders[type](exception, stacktrace);
      }
    }
    log.warning("Unknown FnxError builder for exception of type '${exception.runtimeType}', use method registerErrorBuilder(...)");
    return new FnxError(exception.toString());
  }

}

