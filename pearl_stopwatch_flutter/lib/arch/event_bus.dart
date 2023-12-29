import 'package:event_bus/event_bus.dart';

class EventBusSingleton {
  static final EventBus _eventBus = EventBus();

  static EventBusSingleton? _instance;

  EventBusSingleton._internal();

  factory EventBusSingleton() {
    return _instance ??= EventBusSingleton._internal();
  }

  EventBus get eventBus => _eventBus;
}

