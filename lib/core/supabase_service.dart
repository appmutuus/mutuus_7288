import 'package:supabase_flutter/supabase_flutter.dart';

import 'env.dart';

class SupabaseService {
  SupabaseService._();

  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> init() async {
    await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);
  }

  static Future<AuthResponse> signIn(String email, String password) {
    return client.auth.signInWithPassword(email: email, password: password);
  }

  static Future<dynamic> fetchTable(String table) {
    return client.from(table).select();
  }
}
