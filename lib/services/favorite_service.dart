import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/favorite_model.dart';
import 'auth_service.dart';

class FavoriteService {
  static const String _baseUrl = 'https://api.fluttercrypto.agpro.co.in';

  Future<bool> saveFavorite(FavoriteModel favorite) async {
    String? token = await AuthService().getToken();
    if (token == null) return false;

    final url = Uri.parse('$_baseUrl/items/crypto_favorites');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': favorite.name,
        'symbol': favorite.symbol,
        'current_price': favorite.currentPrice,
        'market_cap_rank': favorite.marketCapRank,
        'price_change_percentage_24h': favorite.priceChange24h,
        'image_url': favorite.imageUrl,
      }),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<List<FavoriteModel>> fetchFavorites() async {
    String? token = await AuthService().getToken();
    if (token == null) return [];
    final url = Uri.parse('$_baseUrl/items/crypto_favorites');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      List<dynamic> list = jsonDecode(response.body)['data'];
      return list.map((json) => FavoriteModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load favorites');
    }
  }

  Future<bool> deleteFavorite(String id) async {
    String? token = await AuthService().getToken();
    if (token == null) return false;
    final url = Uri.parse('$_baseUrl/items/crypto_favorites/$id');
    final response = await http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    return response.statusCode == 200;
  }
}
