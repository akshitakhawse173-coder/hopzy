
import 'event_hub.dart';

class EventHubInstance {
  static EventHub? eventHub;

  static Future<EventHub?> getEventHubInstance() async {
    eventHub ??= EventHub();
    return eventHub;
  }
}
