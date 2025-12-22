abstract class Observer {
  void update(String message);
}

class NotificationCenter {
  final List<Observer> observers = [];

  void subscribe(Observer observer) {
    observers.add(observer);
  }

  void notify(String message) {
    for (var o in observers) {
      o.update(message);
    }
  }
}

class AppNotification implements Observer {
  @override
  void update(String message) {
    print('NOTIFICATION: $message');
  }
}
