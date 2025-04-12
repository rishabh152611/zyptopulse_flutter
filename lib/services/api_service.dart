// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/crypto_model.dart';
//
// class ApiService {
//   static const String _apiUrl =
//       "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1";
//
//   Future<List<CryptoModel>> fetchCryptos() async {
//     try {
//       final response = await http.get(Uri.parse(_apiUrl));
//       if (response.statusCode == 200) {
//         List<dynamic> data = jsonDecode(response.body);
//         return data.map((json) => CryptoModel.fromJson(json)).toList();
//       } else {
//         throw Exception("Failed to load cryptos: ${response.statusCode}");
//       }
//     } catch (e) {
//       throw Exception("Error fetching cryptos: $e");
//     }
//   }
// }




import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crypto_model.dart';

class ApiService {
  static const String _apiUrl =
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1";

  // Returns a Future of crypto list.
  Future<List<CryptoModel>> fetchCryptos() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => CryptoModel.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load cryptos: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching cryptos: $e");
    }
  }

  // Returns a Stream of crypto list.
  Stream<List<CryptoModel>> fetchCryptosStream() {
    return Stream.fromFuture(fetchCryptos());
  }
}
