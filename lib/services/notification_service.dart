import 'package:fluttertoast/fluttertoast.dart';

/// Simple wrapper around [Fluttertoast] to display user notifications.
class NotificationService {
  NotificationService._();

  static void show(String message) {
    Fluttertoast.showToast(msg: message);
  }
}

