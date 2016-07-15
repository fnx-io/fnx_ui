import 'dart:async';

Future cancelSubscription(StreamSubscription subscription) {
  if (subscription != null) {
    return subscription.cancel();
  } else {
    return new Future.value(true);
  }
}