import 'package:ecommerce/app/protocols/firebase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Declares the FirebaseMessageSubject class.
class FirebaseMessageSubject {
  final List<FirebaseMessageObserver> _observers = [];

  void subscribe(FirebaseMessageObserver observer) {
    _observers.add(observer);
  }

  void unsubscribe(FirebaseMessageObserver observer) {
    _observers.remove(observer);
  }

  void notifyMessageReceived(RemoteMessage message) {
    for (final observer in _observers) {
      observer.onMessageReceived(message);
    }
  }

  void notifyMessageOpenedApp(RemoteMessage message) {
    for (final observer in _observers) {
      observer.onMessageOpenedApp(message);
    }
  }
}
