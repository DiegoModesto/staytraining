import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Local notifications. Used for the offline "workout pending for more than X days" reminder,
/// computed on-device. (Server-side FCM push is optional — see mobile/README.md.)
class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static const _channelId = 'staytraining_reminders';

  Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _plugin.initialize(const InitializationSettings(android: android, iOS: ios));
  }

  Future<void> showPendingWorkout(String workoutName, int days) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        'Lembretes de treino',
        channelDescription: 'Avisos de treinos pendentes',
        importance: Importance.defaultImportance,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await _plugin.show(
      workoutName.hashCode,
      'Treino pendente',
      'Faz $days dias que você não faz "$workoutName".',
      details,
    );
  }
}
