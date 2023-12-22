import 'package:ecommerce/app/protocols/firebase.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Declares the FirebaseMessageSubject class.
class FirebaseMessageSubject {
// The list of FirebaseMessageObserver observers.
  final List<FirebaseMessageObserver> _observers = [];

// Subscribes an observer to receive notifications.
  void subscribe(FirebaseMessageObserver observer) {
// Adds the observer to the list of observers.
    _observers.add(observer);
  }

// Unsubscribes an observer from receiving notifications.
  void unsubscribe(FirebaseMessageObserver observer) {
// Removes the observer from the list of observers.
    _observers.remove(observer);
  }

// Notifies observers that a message has been received.
  void notifyMessageReceived(RemoteMessage message) {
// Loops through each observer and calls onMessageReceived(), passing the message.
    for (final observer in _observers) {
      observer.onMessageReceived(message);
    }
  }

// Notifies observers that an app was opened by a message.
  void notifyMessageOpenedApp(RemoteMessage message) {
// Loops through each observer and calls onMessageOpenedApp(), passing the message.
    for (final observer in _observers) {
      observer.onMessageOpenedApp(message);
    }
  }
}
