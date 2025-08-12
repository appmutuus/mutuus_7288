import 'package:shared_preferences/shared_preferences.dart';

/// Manages Karma point storage and rank calculations.
class KarmaService {
  KarmaService._();

  static const _karmaKey = 'karma_points';

  /// Returns the current Karma points stored on the device.
  static Future<int> getKarma() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_karmaKey) ?? 0;
  }

  /// Adds [points] to the stored Karma and returns the updated total.
  static Future<int> addKarma(int points) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_karmaKey) ?? 0;
    final updated = current + points;
    await prefs.setInt(_karmaKey, updated);
    return updated;
  }

  /// Determines the rank name for a given Karma amount.
  static String rankForKarma(int karma) {
    if (karma >= 1000) return 'Vorbild';
    if (karma >= 500) return 'Vertrauensperson';
    if (karma >= 250) return 'Erfahren';
    if (karma >= 100) return 'Community';
    return 'Starter';
  }
}

