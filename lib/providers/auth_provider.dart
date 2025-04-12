import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

final authProvider = Provider<AuthService>((ref) => AuthService());
final authStateProvider = StateProvider<bool>((ref) => false);
