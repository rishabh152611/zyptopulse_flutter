import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/crypto_model.dart';
import '../services/api_service.dart';

final cryptoProvider = FutureProvider<List<CryptoModel>>((ref) async {
  return ApiService().fetchCryptos();
});
