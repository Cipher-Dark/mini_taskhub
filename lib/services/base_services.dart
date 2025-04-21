import 'package:supabase_flutter/supabase_flutter.dart';

class BaseService {
  final supabase = Supabase.instance.client;
}
